import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../note_writing/note_service.dart';
import '../quote/quote_view.dart';
import '../storage/token_storage.dart';

class SoulCheckingController extends GetxController {
  String selectedFeelingKey = '';
  final TextEditingController messageController = TextEditingController();
  final NoteService _noteService = NoteService();

  void selectFeeling(String label) {
    selectedFeelingKey = 'soul_${label.toLowerCase().replaceAll(' ', '_')}';
    print("Selected key: $selectedFeelingKey");
  }

  Future<void> handleNoteSubmission() async {
    final message = messageController.text.trim();

    if (message.isEmpty) {
      Get.snackbar("Note Required", "Please write something before continuing.");
      return;
    }

    final token = await TokenStorage.getToken();

    // If token is not available, skip API and go directly to QuoteView
    if (token == null || token.isEmpty) {
      Get.back(); // Close dialog if open
      Get.to(() => QuoteView(category: selectedFeelingKey));
      return;
    }

    // If token is available, proceed with API call
    final words = message.split(' ');
    final title = words.take(2).join(' ');

    final success = await _noteService.createNote(
      token: token,
      note: message,
      title: title,
    );

    if (success) {
      Get.back(); // Close dialog
      Get.to(() => QuoteView(category: selectedFeelingKey));
    } else {
      Get.snackbar("Failed", "Failed to create note.");
    }
  }

}
