import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:safe_places_app/constants/urls.dart';

import '../models/results/rating_result.dart';
import 'package:http/http.dart' as http;

class _RatingServices {
  Future<RatingResult> ratePlace(String placeId, int value) async {
    const storage = FlutterSecureStorage();

    String? jwt = await storage.read(key: 'jwt');

    if (jwt == null) {
      throw {'unauthorized': true};
    }

    http.Response response = await http.post(
        Uri.parse('${Urls.baseUrl}/api/ratings/rate-place?placeId=$placeId&value=$value'),
        headers: {'Authorization': 'Bearer $jwt'});

    return RatingResult.fromJson(response.body);
  }
}

final ratingServices = _RatingServices();
