import 'package:flutter/material.dart';

class DrawerListTileImage extends StatelessWidget {
  final String? image;
  const DrawerListTileImage({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      child: Image.asset('images/$image.png'),
    );
  }
}
