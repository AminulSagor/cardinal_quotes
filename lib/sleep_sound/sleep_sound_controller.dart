import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class SleepSoundController extends GetxController {
  final AudioPlayer player = AudioPlayer();

  var isPlaying = false.obs;
  var currentTime = 0.0.obs;
  var maxDuration = 1.0.obs;
  var volume = 0.8.obs;

  Future<void> init(String url) async {
    try {
      await player.setUrl(url);
      await player.setVolume(volume.value);
      maxDuration.value = player.duration?.inSeconds.toDouble() ?? 0.0;

      player.positionStream.listen((position) {
        currentTime.value = position.inSeconds.toDouble();
      });

      player.playerStateStream.listen((state) {
        isPlaying.value = state.playing;
      });
    } catch (e) {
      print('🎵 Audio load error: $e');
    }
  }

  Future<void> togglePlay() async {

    try {
      if (player.playing) {
        await player.pause();
      } else {
        await player.play();
      }
      // ✅ Remove this line:
      isPlaying.value = player.playing;

    } catch (e) {
      print("🎵 Toggle error: $e");
    }
  }


  void seek(double seconds) {
    player.seek(Duration(seconds: seconds.toInt()));
  }

  void setVolume(double newVolume) {
    volume.value = newVolume;
    player.setVolume(newVolume);
  }


  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
