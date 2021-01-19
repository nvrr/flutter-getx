import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get_todo/models/todo.dart';


class TodoController extends GetxController {
    var todo = List<Todo>().obs;

    @override
  void onInit() {
    List storedTodos = GetStorage().read<List>('todo');

    if (storedTodos != null) {
      todo = storedTodos.map((e) => Todo.fromJson(e)).toList().obs;
    }
    ever(todo, (_) {
      GetStorage().write('todo', todo.toList());
    });
    super.onInit();
  }
}