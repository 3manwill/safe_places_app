import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:safe_places_app/constants/urls.dart';
import 'package:safe_places_app/models/results/place_image_result.dart';
import 'package:safe_places_app/widgets/public/future_widget.dart';

class PlaceImages extends StatelessWidget {
  final List<PlaceImageResult> images;

  const PlaceImages({super.key, required this.images});

  Future<String> getJwt() async {
    const storage = FlutterSecureStorage();

    return await storage.read(key: 'jwt') ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return FutureWidget<String>(
        future: getJwt(),
        successBuilder: (jwt) {
          jwt = jwt ?? "";

          return Row(
            children: images
                .map(
                  (img) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                      width: 50,
                      height: 80,
                      child: Image.network(
                        '${Urls.safePlaces}/${img.url}?access_token=$jwt',

                      ),
                                        ),
                    );
                    },
                )
                .toList(),
          );
        });
  }
}
