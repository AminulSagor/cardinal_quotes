import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import '../ wallpaper /wallpaper_controller.dart';
import '../ful_screen/wallpaper_full_view.dart';
import '../storage/token_storage.dart';
import '../widgets/quote_card_widget.dart';
import '../widgets/wallpaper_card_widget.dart';
import 'save_service.dart';
import '../widgets/sound_card_widget.dart';

class SaveController extends GetxController {
  final String category;
  SaveController(this.category);
  final WallpaperController wallpaperController = Get.put(WallpaperController());


  var selectedTab = 'quote'.obs;


  var audios = [].obs;
  var quotes = <Map<String, dynamic>>[].obs;
  var wallpapers = <Map<String, dynamic>>[].obs;
  var memorials = <Map<String, dynamic>>[].obs;
  final durations = <int, String>{}.obs;

  final isLoading = true.obs;
  final SaveService _service = SaveService();

  @override
  void onInit() {
    super.onInit();

    if (category == 'saved') {
      loadSavedPosts(); // 🔁 For saved post tab
    } else {
      _loadQuotes(); // 🔁 Load quotes by default instead of audio
    }
  }


  void onTabChanged(String tab) async {
    selectedTab.value = tab;

    switch (tab) {
      case 'quote':
        if (quotes.isEmpty) {
          isLoading.value = true;
          await _loadQuotes();
        }
        break;
      case 'wallpaper':
      case 'memorial':
        if (wallpapers.isEmpty && memorials.isEmpty) {
          isLoading.value = true;
          await _loadVisuals();
        }
        break;
      case 'audio':
        if (audios.isEmpty) {
          isLoading.value = true;
          await _loadAudios();
        }
        break;
      default:
        break;
    }
  }

  void saveQuote(Map<String, dynamic> quote) async {
    try {
      // You can call your SaveService API here if needed
      print("Saving quote: ${quote['id']}");
      Get.snackbar("Saved", "Quote saved successfully", backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar("Error", "Failed to save quote", backgroundColor: Colors.red);
    }
  }

  void shareQuote(Map<String, dynamic> quote) {
    // Example sharing logic
    print("Sharing quote: ${quote['text']}");
    Get.snackbar("Share", "Quote shared", backgroundColor: Colors.blue);
  }

  void downloadQuote(Map<String, dynamic> quote) {
    // Example download logic
    print("Downloading quote: ${quote['text']}");
    Get.snackbar("Download", "Quote download started", backgroundColor: Colors.orange);
  }


  Future<void> _loadAudios() async {
    try {
      final audioData = await _service.fetchAudios(category);
      audios.assignAll(List<Map<String, dynamic>>.from(audioData));
      await _loadDurations();
    } catch (e) {
      print("Error loading audios: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadQuotes() async {
    try {
      final quoteData = await _service.fetchQuotes(category);
      quotes.assignAll(List<Map<String, dynamic>>.from(quoteData));
    } catch (e) {
      print("Error loading quotes: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadVisuals() async {
    try {
      final visualData = await _service.fetchVisuals(category);
      wallpapers.assignAll(List<Map<String, dynamic>>.from(visualData['wallpapers'] ?? []));
      memorials.assignAll(List<Map<String, dynamic>>.from(visualData['memorials'] ?? []));
    } catch (e) {
      print("Error loading visuals: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadDurations() async {
    for (int i = 0; i < audios.length; i++) {
      final audioUrl = audios[i]['audio_path'];
      final player = AudioPlayer();
      try {
        await player.setUrl(audioUrl);
        final duration = player.duration;
        durations[i] = duration != null ? _formatDuration(duration) : "00:00";
      } catch (_) {
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

  Widget buildAudioCard(Map<String, dynamic> audio, int index) {
    return SoundCard(
      sound: audio,
      category: "save",
      duration: durations[index] ?? "00:00",
      onTap: () {
        Get.toNamed('/sleep-sound', arguments: {
          'category': 'save',
          'audio': audio,
          'duration': durations[index] ?? "00:00",
        });
      },
      onSave: () {},
      onShare: () {},
      onDownload: () {},
    );
  }

  Widget buildQuoteCard(Map<String, dynamic> quote) {
    return QuoteCardWidget(
      quote: quote,
      onSave: () => saveQuote(quote),
      onShare: () => shareQuote(quote),
      onDownload: () => downloadQuote(quote),
    );
  }


  Widget buildImageCard(Map<String, dynamic> wallpaper) {
    return WallpaperCard(
      wallpaper: wallpaper,
      onTap: () => Get.to(() => WallpaperFullView(wallpaper: wallpaper)),
      onActionSelected: (value) {
        switch (value) {
          case 'save':
            wallpaperController.saveWallpaper(wallpaper['id']);
            break;
          case 'set_lock':
            wallpaperController.setWallpaper(wallpaper['background'], 'lock');
            break;
          case 'set_home':
            wallpaperController.setWallpaper(wallpaper['background'], 'home');
            break;
          case 'set_both':
            wallpaperController.setWallpaper(wallpaper['background'], 'both');
            break;
          case 'download':
            wallpaperController.downloadWallpaper(wallpaper['background']);
            break;
          case 'share':
          // Optional: Add your share logic
            break;
        }
      },
    );
  }


  Future<void> loadSavedPosts() async {
    try {
      isLoading.value = true;

      final token = await TokenStorage.getToken();
      if (token == null || token.isEmpty) {
        print("❌ Token not found");
        return;
      }

      final savedData = await _service.fetchSavedPosts(token);

      audios.assignAll(savedData['audios'] ?? []);
      quotes.assignAll(savedData['quotes'] ?? []);
      wallpapers.assignAll(savedData['wallpapers'] ?? []);
      memorials.assignAll(savedData['memorials'] ?? []);

      await _loadDurations();
    } catch (e) {
      print("❌ Error loading saved posts: $e");
    } finally {
      isLoading.value = false;
    }
  }




}
