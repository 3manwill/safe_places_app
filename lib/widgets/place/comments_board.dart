import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:safe_places_app/screens/login_screen.dart';
import 'package:safe_places_app/services/comments_services.dart';
import 'package:safe_places_app/widgets/place/commetns_list.dart';
import 'package:safe_places_app/widgets/place/place_comment.dart';

import '../../models/results/comment_result.dart';
import 'comment_form.dart';

class CommentsBoard extends StatefulWidget {
  final String placeId;

  const CommentsBoard({super.key, required this.placeId});

  @override
  State<CommentsBoard> createState() => _CommentsBoardState();
}

class _CommentsBoardState extends State<CommentsBoard> {
  late List<CommentResult> _comments;
  late bool _loading;

  @override
  void initState() {
    // implement initState
    _comments = [];
    _loading = true;

    commentsServices.getPlaceComments(widget.placeId).then((value) {
      setState(() {
        _loading = false;
        _comments = value;
      });
    }).catchError((err) {
      if (err is Map<String, dynamic> && err.containsKey('unauthorized')) {
        const storage = FlutterSecureStorage();

        storage.delete(key: 'jwt').then((_) {
          Navigator.of(context).pushReplacementNamed(LoginScreen.route);
        });

        return;
      }

      if (kDebugMode) {
        print('error server');
      }
    }).whenComplete(() => super.initState());
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.95,
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ],
            ),
            const Text(
              'Comments',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: CommentsList(
                comments: _comments,
              ),
            ),
            CommentForm(
              placeId: widget.placeId,
              onAddComment: (comment) {
                setState(() {
                  _comments = [comment, ..._comments];
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
