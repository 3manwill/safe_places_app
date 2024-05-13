import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingPlace extends StatelessWidget {
  final int value;
  const RatingPlace({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return RatingBar(

      ratingWidget: RatingWidget(

        full: const Icon(Icons.star, color: Colors.yellow),
        half: const SizedBox(),
        empty: const Icon(Icons.star_border),
      ),
      onRatingUpdate: (double value) {},
      ignoreGestures: true,
      initialRating: value.toDouble(),
    );
  }
}
