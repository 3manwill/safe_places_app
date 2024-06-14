import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_places_app/models/results/place_details_result.dart';
import 'package:safe_places_app/providers/place_provider.dart';
import 'package:safe_places_app/services/places_services.dart';

class CancelArrivedButton extends StatefulWidget {
  const CancelArrivedButton({super.key});

  @override
  State<CancelArrivedButton> createState() => _CancelArrivedButtonState();
}

class _CancelArrivedButtonState extends State<CancelArrivedButton> {
  bool sending = false;


  Future<void> _cancelArrivedHandler(BuildContext context, String placeId) async {
    setState(() {
      sending = true;
    });


    try {
      await placesServices.leavePlace(placeId);

      if (context.mounted){
        Provider.of<PlaceProvider>(context, listen: false).changeExistsStatus(UserExistsStatus.notExists);
      }
    }
    on Exception catch (ex) {
      debugPrint(ex.toString());
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
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        ),
      );
    }

    final placeId = Provider.of<PlaceProvider>(context).place.id;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, foregroundColor: Colors.white),
      onPressed: () {
        _cancelArrivedHandler(context, placeId);
      },
      child: const Text('Cancel'),
    );
  }
}
