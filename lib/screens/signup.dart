import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/services/database_service.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final register = Get.put(DatabaseService());
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
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
              onPressed: (!register.isValid) ? null : register.signup,
              child: Text('Signup'),
              color: Colors.lightBlue,
            ),
          ],
        ),
      ),
    );
  }
}
