import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peopletalk/screens/chat/widgets/chat_widgets/emoji_widget.dart';
import 'package:peopletalk/screens/chat/widgets/chat_widgets/sending_image_widget.dart';
import 'package:peopletalk/screens/chat/widgets/chat_widgets/sound_record_widget_to_show_seconds.dart';
import 'package:peopletalk/screens/chat/widgets/chat_widgets/user_chat_widget.dart';
import 'package:peopletalk/services/audio_services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../controllers/firestore_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/show_custom_message.dart';
import '../../../utils/text_styles.dart';
import '../../../widgets/text_input.dart';
import '../widgets/chat_widgets/get_data.dart';

late String message;

class ChatMainScreen extends StatefulWidget {
  final String? frndUid;
  final dynamic data;
  const ChatMainScreen({Key? key, this.frndUid, this.data}) : super(key: key);

  @override
  State<ChatMainScreen> createState() => _ChatMainScreenState();
}

class _ChatMainScreenState extends State<ChatMainScreen> {
  TextEditingController chatController = TextEditingController();
  String docId = '';
  var myId = FirebaseAuth.instance.currentUser!.uid;
  bool isLoading = false;
  //====================BELOW CODE IS RELATED WITH AUDIO SENDING AND LISTING==========//
  var audioFile;
  bool isEmojiTap = false;
  final recorder = FlutterSoundRecorder();
  final audioPlayer = AudioPlayer();
  bool isRecorderReady = false;
  bool isPlaying = false;
  bool isRecording = false;
  AudioServices audioServices = AudioServices();
  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'MicroPhone permission not granted';
    }
    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(Duration(milliseconds: 500));
  }

  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: 'audio');
  }

//============================================================================//

  //===============CODE FOR SENDING IMAGE==========================//
  File? selectedImage;

  Future<void> getImage() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
    );
    setState(() {
      selectedImage = File(pickedFile!.path);
    });
  }

  //==================CODE FOR GENERATING ID FOR ONE TO ONE CHAT======================//

  @override
  void initState() {
    if (myId.hashCode > widget.frndUid.hashCode) {
      docId = myId + widget.frndUid!;
    } else {
      docId = widget.frndUid! + myId;
    }
    super.initState();
    initRecorder();
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    recorder.closeRecorder();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<FireStoreController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data['username'], style: AppTextStyle().BASIC_STYLE.copyWith(color: AppColors.PRIMARY_WHITE)),
        actions: [
          InkWell(
              onTap: () async {
                showCustomMessage(context, "Not Implemented Yet We will Working on It");
              },
              child: Icon(Icons.video_call)),
          SizedBox(width: 15),
          InkWell(
            onTap: () async {
              showCustomMessage(context, "Not Implemented Yet We will Working on It");
              // navigateWithPush(
              //     context,
              //     AudioCallScreen(
              //       data: widget.data,
              //       frndUid: widget.frndUid,
              //     ));
              // await AudioCallServices().makeAudioCall(
              //   frndUid: widget.frndUid,
              //   data: widget.data,
              // );
            },
            child: Icon(Icons.phone, size: 20),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            selectedImage == null
                ? UserChatWidget(getData: getData, docId: docId)
                : SendingImageWidget(
                    data: widget.data,
                    selectedImage: selectedImage,
                    onPressed: () async {
                      chatProvider.sendingImage(
                        context: context,
                        docId: docId,
                        myId: myId,
                        frndUid: widget.frndUid,
                        data: widget.data,
                        selectedImage: selectedImage,
                        isLoading: isLoading,
                      );
                    },
                  ),
            Container(
              child: Row(
                children: [
                  isRecording
                      ? SoundRecordWidgetToShowSeconds(recorder: recorder)
                      : Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: ChatTextInput(
                            onCameraTapped: () {
                              getImage();
                            },
                            emojiTapped: () {
                              setState(() {
                                isEmojiTap = ! isEmojiTap;
                                chatController.clear();
                              });
                            },
                            onPressed: () async {
                              if (chatController.text.isEmpty) {
                                showCustomMessage(context, "Please Write something");
                              } else {
                                chatProvider.sendingTextMsg(
                                  context: context,
                                  docId: docId,
                                  myId: myId,
                                  frndUid: widget.frndUid,
                                  data: widget.data,
                                  chatController: chatController,
                                  isEmojiTap: isEmojiTap,
                                );

                                chatProvider.sendNotificationToSpecificUser(
                                  frndUid: widget.frndUid,
                                  msg: chatController.text,
                                  description: "Text Message",
                                );
                              }
                            },
                            controller: chatController,
                          ),
                        ),
                  CircleAvatar(
                    backgroundColor: Colors.teal,
                    radius: 25,
                    child: IconButton(
                      onPressed: () async {
                        setState(() {
                          isRecording = !isRecording;
                        });
                        if (recorder.isRecording) {
                          try {
                            if (!isRecorderReady) return;
                            final path = await recorder.stopRecorder();
                            audioFile = File(path!);
                            chatProvider.sendingAudioFile(
                              context: context,
                              docId: docId,
                              myId: myId,
                              frndUid: widget.frndUid,
                              data: widget.data,
                              path: path,
                              chatController: chatController,
                            );
                          } catch (e) {
                            print(e);
                          }
                        } else {
                          await record();
                        }
                      },
                      icon: Icon(isRecording ? Icons.send : Icons.mic, color: AppColors.PRIMARY_WHITE),
                    ),
                  ),
                ],
              ),
            ),
            isEmojiTap ? EmojiWidget(chatController: chatController) : SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
