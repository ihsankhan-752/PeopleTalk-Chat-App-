import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/constants.dart';

class AudioServices {
  final recorder = FlutterSoundRecorder();
  final audioPlayer = AudioPlayer();

  bool isRecorderReady = false;
  bool isPlaying = false;
  bool isRecording = false;
  var audioFile;
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

  Future stop() async {
    if (!isRecorderReady) return;
    final path = await recorder.stopRecorder();
    audioFile = File(path!);
    FirebaseStorage fs = FirebaseStorage.instance;
    Reference ref = await fs.ref().child(DateTime.now().millisecondsSinceEpoch.toString());
    await ref.putFile(File(path));
    String url = await ref.getDownloadURL();
    await fireStore.collection("audio").add({
      "audioUrl": url,
    });
  }
}
