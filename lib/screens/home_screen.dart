
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:safe_places_app/models/params/Coords.dart';

import 'package:safe_places_app/models/results/identity_result.dart';
import 'package:safe_places_app/models/results/place_result.dart';
import 'package:safe_places_app/screens/login_screen.dart';
import 'package:safe_places_app/services/identity_services.dart';
import 'package:safe_places_app/services/places_services.dart';
import 'package:safe_places_app/widgets/home/place_info.dart';
import 'package:safe_places_app/widgets/public/future_widget.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../constants/colors.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Map<String, dynamic>> _getHomePageData(BuildContext context) async {
    IdentityResult identityResult = await identityServices.authorization();

    if (identityResult.status == ResponseStatus.unauthorized) {
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed(LoginScreen.route);
      }
    }

    bool enabled = await Geolocator.isLocationServiceEnabled();

    if (!enabled) {
      throw Exception("You should provide the permission of get the location");
    }

    var locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
    }

    if (locationPermission == LocationPermission.denied) {
      throw Exception('You should send your position ...');
    }

    final position = await Geolocator.getCurrentPosition();

    final mapInfo = await placesServices
        .getMapInfo(Coords(lat: position.latitude, lng: position.longitude));

    return {
      'mapKey': mapInfo.mapKey,
      'lat': position.latitude,
      'lng': position.longitude,
      'places': mapInfo.places
    };
  }

  late final MapController controller;

  @override
  void initState() {
    controller = MapController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureWidget<Map<String, dynamic>>(
        future: _getHomePageData(context),
        loadingWidget: const Center(
          child: CircularProgressIndicator(),
        ),
        successBuilder: (data) {
          if (data == null) {
            return const Center(
              child: Text('No Data'),
            );
          }

          return FlutterMap(
            mapController: controller,
            options: MapOptions(
                initialCenter: LatLng(data['lat'], data['lng']),
                initialZoom: 10),
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/basel-askar/clvz63hic02df01qp6xhqf4tl/tiles/256/{z}/{x}/{y}@2x?access_token=${data['mapKey']}',
                userAgentPackageName: 'com.example.safe_places_app',
              ),
              Container(
                padding: const EdgeInsets.all(10),
                height: double.infinity,
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.move(LatLng(data['lat'], data['lng']), 15);
                        },
                        icon: const Icon(Icons.my_location),
                        style: IconButton.styleFrom(
                            backgroundColor: AppColor.primary),
                      )
                    ]),
              ),
              MarkerLayer(
                  markers: (data['places'] as List<PlaceResult>).map((p) {
                return Marker(
                  width: 50,
                  height: 50,
                  point: LatLng(p.latitude, p.longitude),
                  child: GestureDetector(
                      onLongPress: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return PlaceInfo(place: p);
                          },
                        );
                      },
                      onDoubleTap: () =>
                          controller.move(LatLng(p.latitude, p.longitude), 20),
                      child: Image.asset('assets/marker.png')),
                );
              }).toList())
            ],
          );
        },
        errorBuilder: (ex) {
          return const Expanded(
            child: Center(child: Text('Error')),
          );
        },
      ),
    );
  }
}
