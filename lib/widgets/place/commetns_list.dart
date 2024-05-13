import 'package:flutter/material.dart';
import 'package:safe_places_app/widgets/place/place_comment.dart';

import '../../models/results/comment_result.dart';

class CommentsList extends StatelessWidget {
  final List<CommentResult> comments;

  const CommentsList({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:
          comments.map((comment) => PlaceComment(comment: comment)).toList(),
    );
  }
}
