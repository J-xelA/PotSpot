import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:potspot/api/authentication.dart';
import 'package:potspot/main.dart';

class LoginPage extends StatelessWidget {
  // Default button styling. Feel free to change this
  final ButtonStyle style = ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.only(
              left: 60.0, right: 60.0, top: 10.0, bottom: 10.0)),
      shape: MaterialStateProperty.all<OutlinedBorder>(
          const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)))));

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log In"),
      ),
      backgroundColor: const Color(0xff75BBFF),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Image.asset('assets/toilet.png'),
              margin: const EdgeInsets.only(
                  left: 40.0, right: 40.0, top: 10.0, bottom: 20.0),
            ),
            const Text(
              "You Never Know When You Gotta Go",
              textAlign: TextAlign.center,
              strutStyle: StrutStyle(
                height: 1.0,
              ),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Righteous',
                  fontSize: 18),
            ),
            const Padding(padding: EdgeInsets.all(30.0)),
            ElevatedButton.icon(
                icon:
                    const FaIcon(FontAwesomeIcons.google, color: Colors.white),
                label: const Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                style: style,
                onPressed: () async {
                  User? user =
                      await Authentication.signInWithGoogle(context: context);

                  if (user != null) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(user: user),
                      ),
                    );
                  }
                }),
            const Padding(padding: EdgeInsets.all(5.0)),
            ElevatedButton.icon(
                icon: const FaIcon(FontAwesomeIcons.facebook,
                    color: Colors.white),
                label: const Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                style: style,
                onPressed: () async {
                  User? user =
                      await Authentication.signInWithFacebook(context: context);

                  if (user != null) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(user: user),
                      ),
                    );
                  }
                }),
            const Padding(padding: EdgeInsets.all(5.0)),
            ElevatedButton.icon(
                icon:
                    const FaIcon(FontAwesomeIcons.twitter, color: Colors.white),
                label: const Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                style: style,
                onPressed: () async {
                  User? user =
                      await Authentication.signInWithTwitter(context: context);

                  if (user != null) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const MyHomePage(),
                      ),
                    );
                  }
                })
          ],
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(30.0),
        decoration: const BoxDecoration(
          color: Color(0xFFE1F5FE),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }
}
