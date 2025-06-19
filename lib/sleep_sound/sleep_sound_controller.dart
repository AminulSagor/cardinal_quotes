import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

class SleepSoundController extends GetxController {
  final AudioPlayer player = AudioPlayer();

  var isPlaying = false.obs;
  var isBuffering = false.obs;
  var currentTime = 0.0.obs;
  var maxDuration = 1.0.obs;
  var volume = 0.8.obs;

  static const _nativeAudioChannel = MethodChannel('com.cardinal.audio');


  @override
  void onInit() {
    super.onInit();
    _nativeAudioChannel.setMethodCallHandler(_handleNativeCall);
  }

  Future<void> _handleNativeCall(MethodCall call) async {
    switch (call.method) {
      case 'toggle':
        await togglePlay();
        _updateAndroidNotification(isPlaying.value);
        break;
    }
  }
  Future<void> _updateAndroidNotification(bool isPlaying) async {
    try {
      await _nativeAudioChannel.invokeMethod('updateNotification', {
        'isPlaying': isPlaying,
        'title': 'Sleep Sound',
      });
    } catch (e) {
      print('Failed to update notification: $e');
    }
  }


  Future<void> init(String url, String title) async {
    try {
      if (player.playing) {
        print("Already playing. Skipping re-init.");
        return;
      }

      if (await Permission.notification.isDenied) {
        await Permission.notification.request();
      }

      await player.setUrl(url);
      await player.setVolume(volume.value);

      player.durationStream.listen((duration) {
        if (duration != null) {
          maxDuration.value = duration.inSeconds.toDouble();
        }
      });

      player.positionStream.listen((position) {
        currentTime.value = position.inSeconds.toDouble();
      });

      player.playerStateStream.listen((state) {
        isPlaying.value = state.playing;
        isBuffering.value = state.processingState == ProcessingState.buffering;

        if (state.playing) {
          _startNativeForeground(title, url);
        } else {
          _stopNativeForeground();
        }
      });

      await player.play();

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

  Future<void> _startNativeForeground(String title, String url) async {
    try {
      await _nativeAudioChannel.invokeMethod('startForeground', {
        'title': title,
        'url': url,
      });
    } catch (e) {
      print("⚠️ Failed to start foreground: $e");
    }
  }

  Future<void> _stopNativeForeground() async {
    try {
      await _nativeAudioChannel.invokeMethod('stopForeground');
    } catch (e) {
      print("⚠️ Failed to stop foreground: $e");
    }
  }

  @override
  void onClose() {
    _stopNativeForeground();
    player.dispose();
    super.onClose();
  }
}
