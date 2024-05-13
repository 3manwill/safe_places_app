import 'package:flutter/material.dart';
import 'package:safe_places_app/models/results/place_details_result.dart';
import 'package:safe_places_app/widgets/place/place_details_info.dart';

class PlaceScreen extends StatelessWidget {
  static const String route = '/place';

  const PlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final place =
        ModalRoute.of(context)!.settings.arguments as PlaceDetailsResult;

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: PlaceDetailsInfo(
        place: place,
      ),
    );
  }
}
