import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_todo/controllers/todoController.dart';
import 'package:get_todo/models/todo.dart';

class TodoScreen extends StatelessWidget {
  final TodoController todoController = Get.find();
  final int index;

   TodoScreen({this.index});

  @override
  Widget build(BuildContext context) {
    String text = '';
    if (this.index != null){
       text = todoController.todo[index].text;
    }
    TextEditingController textEditingController = TextEditingController(text: text);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: textEditingController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Ehat do you want to do?',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                style: TextStyle(fontSize: 25.0,),
                keyboardType: TextInputType.multiline,
                maxLines: 999,
              ),

              ),

              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  child: Text('Cancel'),
                  color: Colors.red,
                  onPressed: () {
                    Get.back();
                  },
                ),
                RaisedButton(
                  child: Text((this.index != null) ? "Edit" : 'Add'),
                  color: Colors.green,
                  onPressed: () {
                    if( this.index == null) {
                      todoController.todo.add(Todo(text: textEditingController.text));
                    } else {
                      var editing = todoController.todo[index];
                      editing.text = textEditingController.text;
                      todoController.todo[index] = editing;
                    }
                    Get.back();
                  },
                ),
          ],
        )
          ],
        )
      )
    );
  }
}