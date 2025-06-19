import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import '../combine_service/save_service.dart';
import 'audio_service.dart';

class SoundController extends GetxController {
  final sounds = [].obs;
  final isLoading = true.obs;
  final durations = <int, String>{}.obs;

  final String category;
  final audioService = AudioService();

  SoundController(this.category);
  final CombineSaveService saveService = CombineSaveService();

  @override
  void onInit() {
    super.onInit();
    loadSounds();
  }

  void loadSounds() async {
    isLoading.value = true;
    final result = await audioService.fetchAudiosByCategory(category);
    sounds.assignAll(result);
    await _loadDurations();
    isLoading.value = false;
  }

  Future<void> _loadDurations() async {
    for (int i = 0; i < sounds.length; i++) {
      final audioUrl = sounds[i]['audio_path'];
      final player = AudioPlayer();
      try {
        await player.setUrl(audioUrl);
        final duration = player.duration;
        if (duration != null) {
          durations[i] = _formatDuration(duration);
        } else {
          durations[i] = "00:00";
        }
      } catch (e) {
        durations[i] = "00:00";
      } finally {
        await player.dispose();
      }
    }
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  Future<void> saveAudio(int id) async {
    final success = await saveService.saveItem('audio', id);
    if (success) {
      Get.snackbar(
        'Saved',
        'Audio added to your saved list',
        backgroundColor: Colors.white,
        colorText: Colors.brown,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        'Error',
        'Failed to save audio',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
