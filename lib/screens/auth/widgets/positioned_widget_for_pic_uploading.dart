import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class PositionedWidgetForPicUploading extends StatelessWidget {
  final Function()? onPressed;
  const PositionedWidgetForPicUploading({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: InkWell(
        onTap: onPressed ?? () {},
        child: Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.pink,
                Colors.deepPurple,
                AppColors.SKY,
              ],
            ),
          ),
          child: Center(
            child: Icon(Icons.camera, color: AppColors.PRIMARY_WHITE, size: 18),
          ),
        ),
      ),
    );
  }
}
