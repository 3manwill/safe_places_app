

import 'package:flutter/material.dart';
import 'package:safe_places_app/models/results/place_details_result.dart';

class PlaceProvider with ChangeNotifier {

  final PlaceDetailsResult _place;

  PlaceProvider(this._place);

  PlaceDetailsResult get place => _place;

  changeExistsStatus(UserExistsStatus status) {
    _place.existsStatus = status;
    notifyListeners();
  }


}