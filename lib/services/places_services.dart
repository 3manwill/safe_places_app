import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:safe_places_app/constants/urls.dart';
import 'package:safe_places_app/models/params/Coords.dart';
import 'package:safe_places_app/models/results/place_result.dart';

import '../models/results/place_details_result.dart';
import '../models/results/places_map_info.dart';
import 'package:http/http.dart' as http;

class _PlacesServices {
  Future<String> get _jwt async {
    const storage = FlutterSecureStorage();

    String? jwt = await storage.read(key: 'jwt');

    if (jwt == null) throw {'unauthorized': true};

    return jwt;
  }

  Future<PlacesMapInfo> getMapInfo(Coords coords) async {
    const storage = FlutterSecureStorage();

    String? jwt = await storage.read(key: 'jwt');

    if (jwt == null) throw Exception('Failed to catch jwt ...');

    http.Response response = await http.get(
        Uri.parse(
            '${Urls.baseUrl}/api/safe_places/map_info?lat=${coords.lat}&lng=${coords.lng}'),
        headers: {'Authorization': 'Bearer $jwt'});

    Map<String, dynamic> data = jsonDecode(response.body);

    return PlacesMapInfo(
        places: (data['places'] as List)
            .map((map) => PlaceResult.fromMap(map))
            .toList(),
        mapKey: data['mapKey']);
  }

  Future<PlaceDetailsResult> getPlaceDetails(String placeId) async {
    // get jwt
    const storage = FlutterSecureStorage();

    String? jwt = await storage.read(key: 'jwt');

    if (jwt == null) {
      throw {'unauthorized': true};
    }

    // send http request
    http.Response response = await http.get(
        Uri.parse(
            '${Urls.baseUrl}/api/safe_places/place_details?placeId=$placeId'),
        headers: {'Authorization': 'Bearer $jwt'});

    return PlaceDetailsResult.fromJson(response.body);
  }

  Future<void> arrivedPlace(String placeId, Coords coords) async {
    final jwt = await _jwt;
    final response = await http.post(
      Uri.parse(
          '${Urls.baseUrl}/api/safe_places/arrived_request?placeId=$placeId&lat=${coords.lat}&lng=${coords.lng}'),
      headers: {'Authorization': 'Bearer $jwt'},
    );

    if (response.statusCode == 401) {
      throw {'unauthorized': true};
    }

    if (response.statusCode >= 400){
      throw {'message':jsonDecode(response.body)['message']};
    }
  }


  Future<void> leavePlace(String placeId) async {
    final jwt = await _jwt;
    final response = await http.delete(
      Uri.parse(
          '${Urls.baseUrl}/api/safe_places/cancel_arrived_request?placeId=$placeId'),
      headers: {'Authorization': 'Bearer $jwt'},
    );

    if (response.statusCode == 401) {
      throw {'unauthorized': true};
    }



  }

}

final placesServices = _PlacesServices();
