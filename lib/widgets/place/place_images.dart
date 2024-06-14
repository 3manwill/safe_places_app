import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:safe_places_app/constants/urls.dart';
import 'package:safe_places_app/models/results/place_image_result.dart';
import 'package:safe_places_app/screens/image_screen.dart';
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

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: images.map(
                (img) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(ImageScreen.route, arguments: {
                          'currentId': img.id,
                          'images': images
                              .map((img) => {
                                    'image': NetworkImage(
                                        img.url),
                                    'id': img.id,
                                    'name': img.fileName
                                  })
                              .toList()
                        });
                      },
                      child: Container(
                        height: 150,
                        child: Hero(
                          tag: img.id,
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/location.png',
                            image:
                                img.url,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          );

          // return Container(
          //     height: 200,
          //     child: PhotoViewGallery.builder(
          //       scrollPhysics: const BouncingScrollPhysics(),
          //       builder: (BuildContext context, int index) {
          //         final url =
          //             '${Urls.safePlaces}/${images[index].url}?access_token=$jwt';
          //
          //         return PhotoViewGalleryPageOptions(
          //           imageProvider: NetworkImage(url),
          //           initialScale: PhotoViewComputedScale.contained * 0.8,
          //           heroAttributes:
          //               PhotoViewHeroAttributes(tag: images[index].id),
          //         );
          //       },
          //       itemCount: images.length,
          //       loadingBuilder: (context, event) => const Center(
          //         child: SizedBox(
          //           width: 20.0,
          //           height: 20.0,
          //           child: CircularProgressIndicator(),
          //         ),
          //       ),
          //       backgroundDecoration:const BoxDecoration(color: Colors.white),
          //       // pageController: widget.pageController,
          //       // onPageChanged: onPageChanged,
          //     ));
        });
  }
}
