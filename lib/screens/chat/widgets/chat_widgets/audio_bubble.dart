import 'package:audio_wave/audio_wave.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:peopletalk/screens/chat/widgets/chat_widgets/widgets_list.dart';

class AudioBubble extends StatelessWidget {
  final dynamic data;
  const AudioBubble({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayer = AudioPlayer();
    bool isPlaying = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          height: 30,
          // width: 100,
          width: MediaQuery.of(context).size.width * 0.4,
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(data['senderImage']),
              ),
              InkWell(
                onTap: () async {
                  if (isPlaying) {
                    await audioPlayer.pause();
                    setState(() {
                      isPlaying = false;
                    });
                  } else {
                    await audioPlayer.play(UrlSource(data['audioUrl']));

                    setState(() {
                      isPlaying = true;
                    });
                  }
                },
                child: isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
              ),
              isPlaying
                  ? AudioWave(
                      height: 32,
                      width: 45,
                      spacing: 2.5,
                      animation: true,
                      bars: selectedWaveAudioForm,
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: unselectedAudioWaveForm,
                      ),
                    )
            ],
          ),
        );
      },
    );
  }
}
