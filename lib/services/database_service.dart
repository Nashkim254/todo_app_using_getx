import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo_app/model/todo_model.dart';

class DatabaseService extends GetxController {
  FirebaseFirestore firestore;
  FirebaseAuth auth;

  bool valuefirst = false;

  RegExp regExp = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  TodoModel _todo = TodoModel(null, null);
  TodoModel _email = TodoModel(null, null);
  TodoModel _pass = TodoModel(null, null);

  TodoModel get todo => _todo;
  TodoModel get email => _email;
  TodoModel get pass => _pass;

  bool get isValid {
    if (_todo != null) {
      return true;
    } else {
      return false;
    }
  }

  void todoChange(String value) {
    if (value.length >= 3) {
      _todo = TodoModel(value, null);
    } else {
      _todo = TodoModel(null, 'Value must be atleast 3 characters');
    }
    update();
  }

  void emailChange(String value) {
    if (regExp.hasMatch(value)) {
      _email = TodoModel(value, null);
    } else {
      _email = TodoModel(null, 'Enter correct format');
    }
    update();
  }

  void changeBool(bool value) {
    if (valuefirst = false) {
      valuefirst = false;
    } else {
      valuefirst = true;
    }
    update();
  }

  void passChange(String value) {
    if (value.length >= 6) {
      _pass = TodoModel(value, null);
    } else {
      _pass = TodoModel(null, 'Atleast 6 characters');
    }
    update();
  }

  void signup() async {
    UserCredential result;
    try {
      result = await auth.createUserWithEmailAndPassword(
          email: email.value, password: pass.value);
    } catch (e) {
      print(e.toString());
    }
    firestore
        .collection('users')
        .doc(result.user.uid)
        .set({'email': email.value});

    update();
  }

  void login() async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email.value, password: pass.value);
    } catch (e) {
      print(e.toString());
    }
  }

  void save() {
    User user;
    try {
      firestore.collection('todo').doc(user.uid).set({'todo': todo.value});
    } catch (e) {
      print(e.toString());
    }
    update();
  }
}
