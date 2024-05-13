import 'package:flutter/material.dart';
import 'package:safe_places_app/models/params/comment_params.dart';
import 'package:safe_places_app/models/results/comment_result.dart';
import 'package:safe_places_app/services/comments_services.dart';

class CommentForm extends StatefulWidget {
  final String placeId;
  final void Function(CommentResult comment) onAddComment;

  const CommentForm({super.key, required this.placeId, required this.onAddComment});

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  // Form params
  CommentParams commentParams = CommentParams(placeId: '', content: '');

  final _formKey = GlobalKey<FormState>();


  Future<void> _submitForm() async {
    commentParams.placeId = widget.placeId;

    _formKey.currentState?.save();

    if (commentParams.content.trim().isEmpty) return;

    final comment = await commentsServices.addComment(commentParams);

    widget.onAddComment(comment);

    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                textInputAction: TextInputAction.done,
                decoration:
                    const InputDecoration(hintText: 'Write the comment ...'),
                onSaved: (value){
                   commentParams.content = value ?? "";
                },
                onFieldSubmitted: (_){
                  _submitForm();
                },
              ),
            ),
            IconButton(
              onPressed: () {
                _submitForm();
              },
              icon: const Icon(Icons.send),
            ),
          ],
        ));
  }
}
