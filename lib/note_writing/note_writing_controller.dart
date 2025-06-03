import 'package:get/get.dart';
import '../storage/token_storage.dart';
import 'note_service.dart';

class NoteWritingController extends GetxController {
  final title = "".obs;
  final note = "".obs;
  final editedDate = "Edited 11 May 2025".obs;
  final editedTime = "11:41 PM".obs;

  final isTitleVisible = true.obs;
  final isNoteVisible = true.obs;

  final isSaved = false.obs;
  int? noteId;

  @override
  void onInit() {
    super.onInit();
    _loadFromArguments();
  }

  void _loadFromArguments() {
    final args = Get.arguments;
    if (args != null) {
      title.value = args["title"] ?? "";
      note.value = args["note"] ?? "";
      noteId = args["id"];
      isSaved.value = noteId != null;
    }
  }

  Future<void> saveOrUpdateNote() async {
    final token = await TokenStorage.getToken();
    if (token == null || note.value.trim().isEmpty) {
      Get.snackbar("Error", "Note text is required");
      return;
    }

    final trimmedTitle = title.value.trim().isNotEmpty ? title.value : null;

    if (!isSaved.value) {
      final createdNoteId = await NoteService().createNote(
        token: token,
        note: note.value,
        title: trimmedTitle,
      );

      if (createdNoteId != null) {
        isSaved.value = true;
        noteId = createdNoteId as int?;
        Get.snackbar("Success", "Note created");
      } else {
        Get.snackbar("Error", "Failed to create note");
      }
    } else {
      if (noteId == null) return;

      final updated = await NoteService().updateNote(
        token: token,
        noteId: noteId!,
        note: note.value,
        title: trimmedTitle,
      );

      if (updated) {
        Get.snackbar("Success", "Note updated");
      } else {
        Get.snackbar("Error", "Failed to update note");
      }
    }
  }
}
