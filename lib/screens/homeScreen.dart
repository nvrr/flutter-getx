import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_todo/controllers/todoController.dart';
import 'package:get_todo/screens/TodoScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.put(TodoController());
    return Scaffold(
      appBar:AppBar(
        title: Text('Getx Product List'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(TodoScreen());
        }
      ),
      body: Container(
        child: Obx(() => ListView.separated(
          itemCount: todoController.todo.length,
          itemBuilder: (context, index) => Dismissible(

            key: UniqueKey(),
            onDismissed: (_) {
              var removed = todoController.todo[index];
              todoController.todo.removeAt(index);
              Get.snackbar('Task removed',
               'The task "${removed.text}" was successfully removed',
               mainButton: FlatButton(
                 child: Text('Undo'),
                 onPressed: () {
                   if (removed == null) {
                     return;
                   }
                   todoController.todo.insert(index, removed);
                   removed = null;
                   if (Get.isSnackbarOpen) {
                     Get.back();
                   }
                 }
               )
               );

            },
                      child: ListTile(
              title: Text(todoController.todo[index].text,
              style: (todoController.todo[index].done) 
                  ? TextStyle(
                    color: Colors.red,
                    decoration: TextDecoration.lineThrough)
                  : TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color
                  )
              ),
            onTap: () {
              Get.to(TodoScreen(index: index));
            },
            leading : Checkbox(
              value: todoController.todo[index].done,
              onChanged: (v) {
                var changed = todoController.todo[index];
                changed.done = v;
                todoController.todo[index] = changed;
              }
            ),
            trailing: Icon(Icons.chevron_right),
            ),
          ),
          separatorBuilder: (_,__) => Divider(),
        ))
      )
    );
  }
}