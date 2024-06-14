import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:safe_places_app/constants/urls.dart';
import 'package:safe_places_app/models/params/comment_params.dart';
import 'package:safe_places_app/models/results/comment_result.dart';
import 'package:http/http.dart' as http;

class _CommentsServices {
  Future<List<CommentResult>> getPlaceComments(String placeId) async {
    // Get jwt token
    const storage = FlutterSecureStorage();

    String? jwt = await storage.read(key: 'jwt');

    if (jwt == null) {
      throw {'unauthorized': true};
    }

    // Get place comments
    final response = await http.get(
      Uri.parse(
          '${Urls.baseUrl}/api/comments/place-comments?placeId=$placeId'),
      headers: {'Authorization': 'Bearer $jwt'},
    );

    final result = jsonDecode(response.body);

    List<CommentResult> comments = [];

    for (var map in result) {
      comments.add(CommentResult.fromMap(map));
    }

    return comments;
  }

  Future<CommentResult> addComment(CommentParams commentParams) async {
    const storage = FlutterSecureStorage();
    
    String? jwt = await storage.read(key: 'jwt');
    
    if (jwt == null){
      throw {'unauthorized':true};
    }
    
    final response = await http.post(Uri.parse('${Urls.baseUrl}/api/comments/add-comment'),headers: {
      'Authorization': 'Bearer $jwt',
      'Content-Type': 'application/json'
    },
      body: jsonEncode(commentParams.toMap())
    );

    if (response.statusCode == 401){
      throw {'unauthorized':true};
    }

    return CommentResult.fromJson(response.body);
  }

}

final commentsServices = _CommentsServices();
