import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/services/database_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final dbservice = Get.put(DatabaseService());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light, primaryColor: Colors.lightBlue),
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
                        onChanged: (String value) {
                          dbservice.todoChange(value);
                        },
                        decoration: InputDecoration(
                          errorText: dbservice.todo.error,
                          hintText: 'Add your todo',
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      trailing: RaisedButton(
                        color: Colors.lightBlue,
                        onPressed: (!dbservice.isValid) ? null : dbservice.save,
                        child: Text('Add'.toUpperCase()),
                      ),
                    ),
                  ),
                ),
              ),
              StreamBuilder(
                stream: dbservice.firestore.collection('todo').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      if (snapshot.hasData) {
                        return ListTile(
                          title: snapshot.data[index],
                          trailing: Checkbox(
                            value: dbservice.valuefirst,
                            checkColor: Colors.greenAccent,
                            activeColor: Colors.red,
                            onChanged: (bool value) {
                              dbservice.changeBool(value);
                            },
                          ),
                        );
                      }
                      return Center(
                        child: Text('No data!'),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
