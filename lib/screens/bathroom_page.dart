import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/toilet.jpeg')))),
    );
  }
}
