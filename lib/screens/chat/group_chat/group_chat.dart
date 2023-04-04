import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peopletalk/controllers/firestore_controller.dart';
import 'package:peopletalk/screens/chat/widgets/chat_widgets/emoji_widget.dart';
import 'package:peopletalk/services/audio_services.dart';
import 'package:peopletalk/utils/colors.dart';
import 'package:peopletalk/utils/constants.dart';
import 'package:peopletalk/utils/show_custom_message.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../utils/image_picking_dialog_box.dart';
import '../../../widgets/text_input.dart';
import '../widgets/chat_widgets/sound_record_widget_to_show_seconds.dart';
import '../widgets/group_widgets/getGroupChatData.dart';
import '../widgets/group_widgets/group_information_card.dart';
import '../widgets/group_widgets/sending_image_to_group_widget.dart';

class GroupChatMainScreen extends StatefulWidget {
  final dynamic groupId;
  final dynamic data;
  final dynamic groupMemberlength;
  const GroupChatMainScreen({Key? key, this.groupId, this.data, this.groupMemberlength}) : super(key: key);

  @override
  State<GroupChatMainScreen> createState() => _GroupChatMainScreenState();
}

class _GroupChatMainScreenState extends State<GroupChatMainScreen> {
  TextEditingController _chatController = TextEditingController();
  File? selectedImage;
  bool isLoading = false;
  var audioFile;
  bool isEmojiTapped = false;
  final recorder = FlutterSoundRecorder();
  final audioPlayer = AudioPlayer();
  bool isRecorderReady = false;
  bool isPlaying = false;
  bool isRecording = false;
  AudioServices audioServices = AudioServices();
  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'MicroPhone Permission not Granted';
    }
    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(Duration(milliseconds: 500));
  }

  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: 'audio');
  }

  Future<void> getImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: source,
      imageQuality: 30,
    );
    setState(() {
      selectedImage = File(pickedFile!.path);
    });
  }

  @override
  void initState() {
    super.initState();
    initRecorder();
    audioPlayer.onPlayerStateChanged.listen((event) {});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final groupChatController = Provider.of<FireStoreController>(context);
    return Scaffold(
      appBar: AppBar(
        title: GroupInformationCard(data: widget.data, groupMemberLength: widget.groupMemberlength),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            selectedImage == null
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: StreamBuilder(
                      stream: fireStore
                          .collection("groupChat")
                          .doc(widget.groupId)
                          .collection("messages")
                          .orderBy("createdAt", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Text("No Chat Found"),
                          );
                        }
                        return ListView.builder(
                          padding: EdgeInsets.only(bottom: 10, top: 08),
                          reverse: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data!.docs[index];

                            return getGroupChatData(data);
                          },
                        );
                      },
                    ),
                  )
                : SendingImageToGroup(
                    isLoading: isLoading,
                    selectedImage: selectedImage,
                    groupId: widget.groupId,
                  ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  isRecording
                      ? SoundRecordWidgetToShowSeconds(recorder: recorder)
                      : SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: ChatTextInput(
                            onCameraTapped: () {
                              showImagePickingDialogBox(
                                context: context,
                                onCameraTapped: () {
                                  Navigator.of(context).pop();
                                  getImage(ImageSource.camera);
                                },
                                galleryTapped: () {
                                  Navigator.of(context).pop();
                                  getImage(ImageSource.gallery);
                                },
                              );
                            },
                            emojiTapped: () {
                              setState(() {
                                isEmojiTapped = !isEmojiTapped;
                                FocusScope.of(context).unfocus();
                              });
                            },
                            onPressed: () async {
                              if (_chatController.text.isEmpty) {
                                showCustomMessage(context, "Empty Text Can't be Sent");
                              } else {
                                await groupChatController.sendingTextInGroup(
                                  context: context,
                                  chatController: _chatController,
                                  groupId: widget.groupId,
                                );
                              }
                            },
                            controller: _chatController,
                          ),
                        ),
                  CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.teal,
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
                              groupChatController.sendingAudioToGroup(
                                path: path,
                                groupId: widget.groupId,
                              );
                            } catch (e) {
                              showCustomMessage(context, e.toString());
                            }
                          } else {
                            await record();
                          }
                        },
                        icon: Icon(isRecording ? Icons.send : Icons.mic, color: AppColors.PRIMARY_WHITE),
                      ))
                ],
              ),
            ),
            isEmojiTapped ? EmojiWidget(chatController: _chatController) : SizedBox(),
          ],
        ),
      ),
    );
  }
}
