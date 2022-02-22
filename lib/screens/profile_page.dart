import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'add_bathroom_page.dart';

class ProfilePage extends StatelessWidget {
  final User user;
  const ProfilePage({Key? key, required this.user}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff75BBFF),
      appBar: AppBar(
        title: const Text('Profile Page'),
        backgroundColor: Colors.grey,
        actions: const [],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                'assets/toilet.png',
              ),
              margin: const EdgeInsets.only(
                  left: 40.0, right: 40.0, top: 10.0, bottom: 20.0),
            ),
            const Text(
              "Manage your profile",
              textAlign: TextAlign.center,
              strutStyle: StrutStyle(
                height: 1.0,
              ),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Righteous',
                  fontSize: 18),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            const Text(
              "Contribute to PotSpot",
              textAlign: TextAlign.center,
              strutStyle: StrutStyle(
                height: 1.0,
              ),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Righteous',
                  fontSize: 18),
            ),
            ElevatedButton.icon(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddBathroomPage(user: user)),
              );
            }, icon: const FaIcon(FontAwesomeIcons.toilet), label: const Text("Add a Restroom"))
          ],
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(30.0),
        decoration: const BoxDecoration(
            color: Color(0xFFE1F5FE),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
      ),
    );
  }
}
