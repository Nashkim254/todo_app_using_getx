import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/auth_controller.dart';
import 'package:todo_app/controllers/todo_controller.dart';
import 'package:todo_app/controllers/user_controller.dart';
import 'package:todo_app/screens/todocard.dart';
import 'package:todo_app/services/database_service.dart';

class HomePage extends GetWidget<AuthController> {
  TextEditingController _todoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetX<UserController>(
          initState: (_) async {
            Get.find<UserController>().user =
                await Database().getUser(Get.find<AuthController>().user.uid);
          },
          builder: (_) {
            if (_.user.name != null) {
              return Text("Welcome " + _.user.name);
            } else {
              return Text("loading...");
            }
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              controller.signOut();
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              if (Get.isDarkMode) {
                Get.changeTheme(ThemeData.light());
              } else {
                Get.changeTheme(ThemeData.dark());
              }
            },
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100.0,
                child: Card(
                  color: Colors.grey,
                  child: ListTile(
                    title: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: 'Add your todo',
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                    trailing: RaisedButton(
                      color: Colors.lightBlue,
                      onPressed: () {
                        if (_todoController.text != "") {
                          Database().addTodo(
                              _todoController.text, controller.user.uid);
                          _todoController.clear();
                        }
                      },
                      child: Text('Add'.toUpperCase()),
                    ),
                  ),
                ),
              ),
            ),
            GetX<TodoController>(
              init: Get.put<TodoController>(TodoController()),
              builder: (TodoController todoController) {
                if (todoController != null && todoController.todos != null) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: todoController.todos.length,
                      itemBuilder: (_, index) {
                        return TodoCard(
                            uid: controller.user.uid,
                            todo: todoController.todos[index]);
                      },
                    ),
                  );
                } else {
                  return Text("loading...");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
