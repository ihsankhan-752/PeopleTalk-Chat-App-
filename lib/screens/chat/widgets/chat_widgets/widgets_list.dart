import 'package:audio_wave/audio_wave.dart';
import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

List<Widget> unselectedAudioWaveForm = [
  Container(
    margin: EdgeInsets.only(left: 2),
    height: 3,
    width: 2,
    color: Colors.grey,
  ),
  Container(
    margin: EdgeInsets.only(left: 2),
    height: 7,
    width: 2,
    color: Colors.grey,
  ),
  Container(
    margin: EdgeInsets.only(left: 2),
    height: 3,
    width: 2,
    color: Colors.grey,
  ),
  Container(
    margin: EdgeInsets.only(left: 2),
    height: 12,
    width: 2,
    color: Colors.grey,
  ),
  Container(
    margin: EdgeInsets.only(left: 2),
    height: 15,
    width: 2,
    color: Colors.grey,
  ),
  Container(
    margin: EdgeInsets.only(left: 2),
    height: 22,
    width: 2,
    color: Colors.grey,
  ),
  Container(
    margin: EdgeInsets.only(left: 2),
    height: 12,
    width: 2,
    color: Colors.grey,
  ),
  Container(
    margin: EdgeInsets.only(left: 2),
    height: 15,
    width: 2,
    color: Colors.grey,
  ),
  Container(
    margin: EdgeInsets.only(left: 2),
    height: 4,
    width: 2,
    color: Colors.grey,
  ),
  Container(
    margin: EdgeInsets.only(left: 2),
    height: 8,
    width: 2,
    color: Colors.grey,
  ),
];
List<AudioWaveBar> selectedWaveAudioForm = [
  AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.1, radius: 20),
  AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.3, radius: 20),
  AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.2, radius: 20),
  AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.5, radius: 20),
  AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.3, radius: 20),
  AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.8, radius: 20),
  AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.9, radius: 10),
  AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.3, radius: 10),
  AudioWaveBar(color: AppColors.PRIMARY_BLACK, heightFactor: 0.2, radius: 10),
];
