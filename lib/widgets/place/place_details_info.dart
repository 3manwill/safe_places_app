import 'package:flutter/material.dart';
import 'package:safe_places_app/models/results/place_details_result.dart';
import 'package:safe_places_app/widgets/home/place_field.dart';
import 'package:safe_places_app/widgets/place/place_images.dart';
import 'package:safe_places_app/widgets/home/rating_place.dart';
import 'package:safe_places_app/widgets/home/user_rating_place.dart';
import 'package:safe_places_app/widgets/place/comment_form.dart';
import 'package:safe_places_app/widgets/place/comments_board.dart';
import 'package:safe_places_app/widgets/place/place_comment.dart';

class PlaceDetailsInfo extends StatefulWidget {
  final PlaceDetailsResult place;

  const PlaceDetailsInfo({super.key, required this.place});

  @override
  State<PlaceDetailsInfo> createState() => _PlaceDetailsInfoState();
}

class _PlaceDetailsInfoState extends State<PlaceDetailsInfo> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(widget.place.description),
        const SizedBox(height: 10),
        RatingPlace(value: widget.place.rating),
        const SizedBox(height: 20),
        PlaceField(title: 'Size', value: widget.place.size.toString()),
        const SizedBox(height: 10),
        PlaceField(
            title: 'Available size',
            value: widget.place.availableSize.toString()),
        const SizedBox(height: 10),
        ...widget.place.features.expand(
          (f) => [
            PlaceField(title: f.title, value: f.value),
            const SizedBox(height: 10)
          ],
        ),
        PlaceImages(images: widget.place.images),
        const Divider(),
        const SizedBox(height: 10),
        UserRatingPlace(
            value: widget.place.userRating.value, onChange: (value) {}),
        const SizedBox(height: 20),
        const Text(
          'Comments',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        ...widget.place.comments.expand(
          (c) => [PlaceComment(comment: c), const Divider()],
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return CommentsBoard(placeId: widget.place.id);
                  },
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
              child: const Text('See all'),
            ),
          ],
        ),
      ],
    );
  }
}
