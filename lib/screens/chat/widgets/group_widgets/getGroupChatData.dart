



import '../chat_widgets/audio_bubble.dart';
import 'display_image_in_group_chat.dart';
import 'display_text_in_group_chat_card.dart';
import 'group_audio_widget.dart';

getGroupChatData(dynamic data){
  if (data['msg'] == "" && data['audioUrl'] == "") {
    return DisplayImageInGroupChat(data: data);
  } else if (data['msg'] == "" && data['imageUrl'] == "") {
    return GroupAudioWidget(
      data: data,
      widget: AudioBubble(data: data),
    );
  } else {
    return DisplayTextInGroupChatCard(data: data);
  }
}