import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_places_app/models/results/place_details_result.dart';
import 'package:safe_places_app/providers/place_provider.dart';
import 'package:safe_places_app/services/rating_services.dart';
import 'package:safe_places_app/widgets/home/place_field.dart';
import 'package:safe_places_app/widgets/place/arrived_button.dart';
import 'package:safe_places_app/widgets/place/place_images.dart';
import 'package:safe_places_app/widgets/home/rating_place.dart';
import 'package:safe_places_app/widgets/place/user_rating_place.dart';
import 'package:safe_places_app/widgets/place/comments_board.dart';
import 'package:safe_places_app/widgets/place/place_comment.dart';

class PlaceDetailsInfo extends StatefulWidget {


  const PlaceDetailsInfo({super.key});

  @override
  State<PlaceDetailsInfo> createState() => _PlaceDetailsInfoState();
}

class _PlaceDetailsInfoState extends State<PlaceDetailsInfo> {



  @override
  Widget build(BuildContext context) {

    final place = Provider.of<PlaceProvider>(context).place;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(place.description),
        const SizedBox(height: 10),
        RatingPlace(value: place.rating),
        const SizedBox(height: 20),
        PlaceField(title: 'Size', value: place.size.toString()),
        const SizedBox(height: 10),
        PlaceField(
            title: 'Available size',
            value: place.availableSize.toString()),
        const SizedBox(height: 10),
        ...place.features.expand(
          (f) => [
            PlaceField(title: f.title, value: f.value),
            const SizedBox(height: 10)
          ],
        ),
        PlaceImages(images: place.images),
        const Divider(),
        const SizedBox(height: 10),
        UserRatingPlace(
            value: place.userRating.value, onChange: (value) {
              ratingServices.ratePlace(place.id, value);
        }),
        const SizedBox(height: 10),
        const ArrivedButton(),
        const SizedBox(height: 20),
        const Text(
          'Comments',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        ...place.comments.expand(
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
                    return CommentsBoard(placeId: place.id);
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
