import 'package:flutter/material.dart';
import 'package:peopletalk/screens/chat/widgets/chat_widgets/display_image_in_chat.dart';

import '../../../../utils/colors.dart';
import 'audio_bubble.dart';

getData(dynamic data) {
  if (data['msg'] == "" && data['audioUrl'] == "") {
    return DisplayImageInChat(data: data);
  } else if (data['msg'] == "" && data['image'] == "") {
    return AudioBubble(data: data);
  } else {
    return Text(
      data['msg'],
      style: TextStyle(color: AppColors.PRIMARY_BLACK),
    );
  }
}
