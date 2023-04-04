import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';

class PhotoView extends StatelessWidget {
  final dynamic image;
  const PhotoView({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FullScreenWidget(
      child: ClipRRect(
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
