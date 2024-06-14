import 'package:flutter/material.dart';
import 'package:safe_places_app/models/results/comment_result.dart';

class PlaceComment extends StatelessWidget {
  final CommentResult comment;

  const PlaceComment({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: comment.userPhoto == null
          ? Image.asset('assets/user.png', width: 40)
          : ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(comment.userPhoto!, width: 40)),
      title: Text(comment.userName),
      subtitle: Text(comment.content),
    );
  }
}
