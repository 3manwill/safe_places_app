import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:safe_places_app/models/results/place_result.dart';
import 'package:safe_places_app/screens/place_screen.dart';
import 'package:safe_places_app/services/places_services.dart';
import 'package:safe_places_app/widgets/home/place_field.dart';
import 'package:safe_places_app/widgets/home/rating_place.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceInfo extends StatelessWidget {
  final PlaceResult place;

  const PlaceInfo({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            place.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(place.description),
          const SizedBox(height: 20),
          SizedBox(child: RatingPlace(value: place.rating)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  placesServices.getPlaceDetails(place.id).then((details) {
                    Navigator.of(context)
                        .pushNamed(PlaceScreen.route, arguments: details);
                  });
                },
                style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
                child: const Text('More info'),
              ),
              TextButton(
                onPressed: () {
                  final url = 'https://www.google.com/maps/place/${place.latitude},${place.longitude}';
                  canLaunchUrl(Uri.parse(url))
                    .then((canLaunch) {
                     if (canLaunch){
                       launchUrl(Uri.parse(url));
                     }
                     else {
                       if (kDebugMode) {
                         print("Can't launch ........................................................");
                       }
                    }
                  });
                },
                child: const Text('Google maps'),
              )
            ],
          )
        ],
      ),
    );
  }
}
