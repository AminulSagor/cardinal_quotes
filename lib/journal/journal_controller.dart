import 'package:get/get.dart';
import 'journal_service.dart';
import '../storage/token_storage.dart';

class JournalController extends GetxController {
  final journals = <Map<String, dynamic>>[].obs;
  final filteredJournals = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final isSearchVisible = false.obs;
  final searchText = ''.obs;

  final _colors = [
    0xFFCCFFFF,
    0xFFFFFFCC,
    0xFFFFCCFF,
    0xFF000000,
    0xFFCCFFFF,
  ];

  List<Map<String, dynamic>> _allJournals = [];

  @override
  void onReady() {
    super.onReady();
    loadJournals();
  }

  Future<void> loadJournals() async {
    isLoading.value = true;

    final token = await TokenStorage.getToken();
    if (token == null) {
      journals.clear();
      filteredJournals.clear();
      isLoading.value = false;
      return;
    }

    final data = await JournalService().fetchJournals(token);

    final withColors = data.asMap().entries.map((entry) {
      final index = entry.key;
      final note = entry.value;
      return {
        "id": note["id"],
        "title": note["title"] ?? "Untitled",
        "text": note["note"] ?? "",
        "color": _colors[index % _colors.length],
      };
    }).toList();

    _allJournals = withColors;
    journals.assignAll(withColors);
    filteredJournals.assignAll(withColors);
    isLoading.value = false;
  }

  void toggleSearch() {
    isSearchVisible.value = !isSearchVisible.value;
    if (!isSearchVisible.value) {
      search('');
    }
  }

  void search(String text) {
    searchText.value = text;
    final query = text.toLowerCase();
    final filtered = _allJournals.where((j) {
      final title = (j['title'] ?? '').toString().toLowerCase();
      final note = (j['text'] ?? '').toString().toLowerCase();
      return title.contains(query) || note.contains(query);
    }).toList();
    filteredJournals.assignAll(filtered);
  }
}
