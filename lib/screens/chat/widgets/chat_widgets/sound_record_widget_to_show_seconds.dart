import 'package:audio_wave/audio_wave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';

import '../../../../utils/colors.dart';

class SoundRecordWidgetToShowSeconds extends StatelessWidget {
  final FlutterSoundRecorder recorder;
  const SoundRecordWidgetToShowSeconds({Key? key, required this.recorder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: recorder.onProgress,
          builder: (context, snapshot) {
            final duration = snapshot.hasData ? snapshot.data!.duration : Duration.zero;
            return Row(
              children: [
                SizedBox(width: 30),
                Text('${duration.inSeconds}'),
                SizedBox(width: 20),
                AudioWave(
                  height: 40,
                  width: 80,
                  spacing: 2.5,
                  animation: true,
                  bars: [
                    AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.1, radius: 20),
                    AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.3, radius: 20),
                    AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.2, radius: 20),
                    AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.5, radius: 20),
                    AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.3, radius: 20),
                    AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.8, radius: 20),
                    AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.9, radius: 10),
                    AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.3, radius: 10),
                    AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.2, radius: 10),
                    AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.5, radius: 20),
                    AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.3, radius: 20),
                    AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.8, radius: 20),
                    AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.9, radius: 10),
                    AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.3, radius: 10),
                    AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.2, radius: 10),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
