import 'package:flutter/material.dart';
import 'package:safe_places_app/models/results/comment_result.dart';

class PlaceComment extends StatelessWidget {
  final CommentResult comment;

  const PlaceComment({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset('assets/user.png', width: 30),
      title: Text(comment.userName),
      subtitle: Text(comment.content),
    );
  }
}
