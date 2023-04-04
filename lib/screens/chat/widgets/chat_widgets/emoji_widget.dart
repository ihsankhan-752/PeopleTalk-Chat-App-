import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class EmojiWidget extends StatelessWidget {
  final TextEditingController chatController;
  const EmojiWidget({Key? key, required this.chatController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: EmojiPicker(
        textEditingController: chatController,
        config: Config(columns: 7, emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0)),
      ),
    );
  }
}
