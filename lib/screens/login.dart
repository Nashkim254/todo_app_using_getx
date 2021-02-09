import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/screens/signup.dart';
import 'package:todo_app/services/database_service.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final register = Get.put(DatabaseService());
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                register.emailChange(value);
              },
              decoration: InputDecoration(
                hintText: 'Email',
                errorText: register.email.error,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            TextField(
              onChanged: (value) {
                register.passChange(value);
              },
              decoration: InputDecoration(
                hintText: 'Password',
                errorText: register.pass.error,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            RaisedButton(
              onPressed: (!register.isValid) ? null : register.login,
              child: Text('Login'),
              color: Colors.lightBlue,
            ),
            SizedBox(
              height: 40.0,
            ),
            RaisedButton(
              onPressed: () {
                Get.to(Signup());
              },
              child: Text('Sign up'),
              color: Colors.lightBlue,
            ),
          ],
        ),
      ),
    );
  }
}
