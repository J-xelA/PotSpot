import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:potspot/api/database_service.dart';
import 'package:potspot/main.dart';

class FinalizeBathroomPage extends StatefulWidget {
  final LatLng location;
  final User user;
  const FinalizeBathroomPage({Key? key, required this.location, required this.user})
      : super(key: key);

  @override
  State<FinalizeBathroomPage> createState() => _FinalizeBathroomState();
}

class _FinalizeBathroomState extends State<FinalizeBathroomPage> {
  Map<String, dynamic> amenities = {
    'soap': true,
    'toilet_paper': true,
    'tampons': false,
    'hand_dryer': false,
    'hot_water': true,
    'seat_covers': true,
    'baby_station': true,
    'auto_flush': false,
    'auto_sink': false,
    'auto_soap': false,
    'gender': "male"
  };
  Genders gender = Genders.male;

  final _formKey = GlobalKey<FormState>();
  final controller = TextEditingController();

  _FinalizeBathroomState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Add Bathroom"),
      ),
      body: Form(
        key: _formKey,
        child: Column(children: [
          Row(
            children: [
              const Text("Name: "),
              Expanded(
                  child: TextFormField(
                    controller: controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length > 255){
                        return 'Name too long';
                      }
                      return null;
                    },
                  )
              )
            ]
          ),
          Row(children: [
            Checkbox(
                value: amenities["soap"],
                onChanged: (value) =>
                    setState(() => amenities["soap"] = value!)),
            const Text("Soap")
          ]),
          Row(children: [
            Checkbox(
                value: amenities["toilet_paper"],
                onChanged: (value) =>
                    setState(() => amenities["toilet_paper"] = value!)),
            const Text("Toilet Paper")
          ]),
          Row(children: [
            Checkbox(
                value: amenities["tampons"],
                onChanged: (value) =>
                    setState(() => amenities["tampons"] = value!)),
            const Text("Tampons")
          ]),
          Row(children: [
            Checkbox(
                value: amenities["hand_dryer"],
                onChanged: (value) =>
                    setState(() => amenities["hand_dryer"] = value!)),
            const Text("Hand Dryer")
          ]),
          Row(children: [
            Checkbox(
                value: amenities["hot_water"],
                onChanged: (value) =>
                    setState(() => amenities["hot_water"] = value!)),
            const Text("Hot Water")
          ]),
          Row(children: [
            Checkbox(
                value: amenities["seat_covers"],
                onChanged: (value) =>
                    setState(() => amenities["seat_covers"] = value!)),
            const Text("Seat Covers")
          ]),
          Row(children: [
            Checkbox(
                value: amenities["baby_station"],
                onChanged: (value) =>
                    setState(() => amenities["baby_station"] = value!)),
            const Text("Baby Station")
          ]),
          Row(children: [
            Checkbox(
                value: amenities["auto_flush"],
                onChanged: (value) =>
                    setState(() => amenities["auto_flush"] = value!)),
            const Text("Hands-free Flushing")
          ]),
          Row(children: [
            Checkbox(
                value: amenities["auto_sink"],
                onChanged: (value) =>
                    setState(() => amenities["auto_sink"] = value!)),
            const Text("Hands-free Sinks")
          ]),
          Row(children: [
            Checkbox(
                value: amenities["auto_soap"],
                onChanged: (value) =>
                    setState(() => amenities["auto_soap"] = value!)),
            const Text("Hands-free Soap Dispensers")
          ]),
          DropdownButton<Genders>(
              value: gender,
              onChanged: (value) => setState(() {
                    amenities["gender"] = value.toString().split(".")[1];
                    gender = value!;
                  }),
              items: const [
                DropdownMenuItem(
                  value: Genders.male,
                  child: Text("Male"),
                ),
                DropdownMenuItem(
                  value: Genders.female,
                  child: Text("Female"),
                ),
                DropdownMenuItem(
                  value: Genders.unisex,
                  child: Text("Unisex"),
                ),
                DropdownMenuItem(
                  value: Genders.handicap,
                  child: Text("Handicap"),
                ),
              ]),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Bathroom Submitted')),
                  );
                  DatabaseService.addBathroom(widget.user, controller.text, widget.location, amenities);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                  );
                }
              },
              child: const Text("Publish"))
        ]),
      ),
    );
  }
}

enum Genders { male, female, handicap, unisex }
