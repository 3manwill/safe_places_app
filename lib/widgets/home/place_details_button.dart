import 'package:flutter/material.dart';
import 'package:safe_places_app/screens/place_screen.dart';

import '../../services/places_services.dart';

class PlaceDetailsButton extends StatefulWidget {
  final String placeId;

  const PlaceDetailsButton({super.key, required this.placeId});

  @override
  State<PlaceDetailsButton> createState() => _PlaceDetailsButtonState();
}

class _PlaceDetailsButtonState extends State<PlaceDetailsButton> {

  bool loading = false;


  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const SizedBox(width: 20,height: 20, child: CircularProgressIndicator(color: Colors.blueAccent,));
    }


    return TextButton(
      onPressed: () {
        setState(() {
          loading = true;
        });
        placesServices.getPlaceDetails(widget.placeId).then((details) {
          Navigator.of(context)
              .pushNamed(PlaceScreen.route, arguments: details);

          setState(() {
            loading = false;
          });
        });
      },
      style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
      child: const Text('More info'),
    );
  }
}