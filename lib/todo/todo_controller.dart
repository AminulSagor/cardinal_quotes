import 'package:get/get.dart';

class TodoController extends GetxController {
  RxList<Map<String, dynamic>> todos = <Map<String, dynamic>>[
    {"title": "Napa", "time": "Everyday At 6.00 Pm", "checked": true, "overdue": false},
    {"title": "Vigimate", "time": "Everyday At 4.00 Pm", "checked": false, "overdue": false},
    {"title": "Napa", "time": "Everyday At 4.00 Pm", "checked": true, "overdue": true},
  ].obs;

  RxBool showInput = false.obs;
  RxString newTodo = ''.obs;

  void toggleTodo(int index) {
    todos[index]['checked'] = !todos[index]['checked'];
    todos.refresh();
  }

  void addTodo() {
    if (newTodo.value.trim().isEmpty) return;
    todos.add({
      "title": newTodo.value.trim(),
      "time": "Everyday At 6.00 Pm",
      "checked": false,
      "overdue": false
    });
    newTodo.value = '';
    showInput.value = false;
  }
}
