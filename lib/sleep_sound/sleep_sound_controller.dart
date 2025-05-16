import 'package:get/get.dart';

class SleepSoundController extends GetxController {
  RxBool isPlaying = false.obs;
  RxDouble currentTime = 4.0.obs;
  RxDouble volume = 0.5.obs;

  void togglePlay() {
    isPlaying.value = !isPlaying.value;
  }
}
