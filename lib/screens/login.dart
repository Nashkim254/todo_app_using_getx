import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/auth_controller.dart';
import 'package:todo_app/screens/home_page.dart';
import 'package:todo_app/screens/signup.dart';
import 'package:todo_app/services/database_service.dart';

class Login extends GetWidget<AuthController> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            RaisedButton(
              onPressed: () {
                controller.login(emailController.text, passwordController.text);
                Get.to(HomePage());
              },
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
