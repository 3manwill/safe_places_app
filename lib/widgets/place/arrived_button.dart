import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:safe_places_app/models/params/Coords.dart';
import 'package:safe_places_app/models/results/place_details_result.dart';
import 'package:safe_places_app/providers/place_provider.dart';
import 'package:safe_places_app/screens/login_screen.dart';
import 'package:safe_places_app/services/places_services.dart';
import 'package:safe_places_app/services/token_services.dart';
import 'package:safe_places_app/widgets/place/cancel_arrived_button.dart';

final _statusString = {
  UserExistsStatus.pending: 'Waiting confirm booking place',
  UserExistsStatus.accepted: 'Accepted Booking place',
  UserExistsStatus.rejected: 'Rejected Booking place',
};

class ArrivedButton extends StatefulWidget {
  const ArrivedButton({super.key});

  @override
  State<ArrivedButton> createState() => _ArrivedButtonState();
}

class _ArrivedButtonState extends State<ArrivedButton> {
  bool sending = false;

  Future<void> arrivedRequest(String placeId, BuildContext context) async {
    setState(() {
      sending = true;
    });

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      await placesServices.arrivedPlace(
          placeId, Coords(lat: position.latitude, lng: position.longitude));

      if (context.mounted){
        Provider.of<PlaceProvider>(context, listen: false).changeExistsStatus(UserExistsStatus.pending);
      }
    }
    on Map<String, dynamic> catch(map){
      if (map.containsKey('unauthorized')){
        if (context.mounted){
          tokenServices.removeToken();
          Navigator.of(context).pushReplacementNamed(LoginScreen.route);

        }
      }
    }
    on Exception catch (ex) {
      if (kDebugMode) {
        print(ex.toString());
      }
    }
    finally {
      setState(() {
        sending = false;
      });

    }




  }

  @override
  Widget build(BuildContext context) {
    if (sending) {
      return const Center(
        child: SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(),
        ),
      );
    }

    final place = Provider.of<PlaceProvider>(context).place;

    if (place.existsStatus != UserExistsStatus.notExists) {
      return Row(
        children: [
          const CancelArrivedButton(),
          Expanded(
            child: Center(
              child: Text(
                _statusString[place.existsStatus]!,
              ),
            ),
          )
        ],
      );
    }

    return ElevatedButton(
      onPressed: () {
        arrivedRequest(place.id,context);
      },
      child: const Text('Arrived'),
    );
  }
}
