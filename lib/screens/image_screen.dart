import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:safe_places_app/services/token_services.dart';


class ImageScreen extends StatelessWidget {
  static const String route = '/images';
  const ImageScreen({super.key});

  Future<String> getToke() async => await tokenServices.getToken() ?? "";

  @override
  Widget build(BuildContext context) {

    final args = (ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>);

    final images = args['images'] as List<Map<String, dynamic>>;
    final currentId = args['currentId'] as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(images.firstWhere((img) => img['id'] == currentId)['name']),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: PhotoView(
            heroAttributes: PhotoViewHeroAttributes(tag: currentId),
            imageProvider: images.firstWhere((img) => img['id'] == currentId)['image'] as NetworkImage,

            ),
          )
      );

  }
}
