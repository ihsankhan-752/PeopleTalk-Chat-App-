import 'package:flutter/material.dart';
import 'package:peopletalk/utils/colors.dart';

class DecoratedFloatingButton extends StatelessWidget {
  const DecoratedFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          end: Alignment.centerLeft,
          begin: Alignment.centerRight,
          colors: [
            Colors.purple,
            Colors.deepPurple,
            Colors.blueAccent,
          ],
        ),
      ),
      child: Center(
        child: Icon(Icons.add, color: AppColors.PRIMARY_WHITE),
      ),
    );
  }
}
