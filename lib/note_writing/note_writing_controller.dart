import 'package:get/get.dart';

class NoteWritingController extends GetxController {
  final title = "".obs;
  final note = "".obs;
  final editedDate = "Edited 11 May 2025".obs;
  final editedTime = "11:41 PM".obs;

  final isTitleVisible = true.obs;
  final isNoteVisible = true.obs;
}
