import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.lightBlue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Todo App'),
          elevation: 0.0,
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Get.changeTheme(ThemeData.dark());
              },
              icon: Icon(
                Icons.wb_sunny_outlined,
              ),
            ),
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
                        decoration: InputDecoration(
                            hintText: 'Add your todo',
                            hintStyle: TextStyle(color: Colors.black)),
                      ),
                      trailing: RaisedButton(
                        color: Colors.lightBlue,
                        onPressed: () {},
                        child: Text('Add'.toUpperCase()),
                      ),
                    ),
                  ),
                ),
              ),
              ListView()
            ],
          ),
        ),
      ),
    );
  }
}
