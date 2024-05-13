import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UserRatingPlace extends StatelessWidget {
  final int value;
  final void Function(int value) onChange;

  const UserRatingPlace({super.key, required this.value, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return RatingBar(ratingWidget: RatingWidget(
      full:const Icon(Icons.star,color: Colors.yellow),
      half: const SizedBox(),
      empty:const Icon(Icons.star_border)
    ),
        itemSize: 30,
        initialRating: value.toDouble(),
        onRatingUpdate: (value){
          onChange(value.toInt());
        }
    );
  }
}
