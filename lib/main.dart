import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:potspot/api/database_service.dart';
import 'package:potspot/screens/profile_page.dart';
import 'package:rive_splash_screen/rive_splash_screen.dart';

import './screens/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen.navigate(
          name: 'assets/toiletpaperloading.riv',
          next: (context) => const MyHomePage(),
          until: () => Future.delayed(const Duration(seconds: 1)),
          startAnimation: 'Animation',
          backgroundColor: Colors.blue,
        ));
  }
}

class MyHomePage extends StatefulWidget {
  final User? user;

  const MyHomePage({Key? key, this.user}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  final LatLng _center = const LatLng(39.7287607, -121.8498174);
  int _selectedIndex = 0;

  void _handleNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PotSpot"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  if (widget.user != null) {
                    return ProfilePage(user: widget.user!);
                  } else {
                    return LoginPage();
                  }
                }),
              );
            },
          )
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseService.getBathrooms(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Text("oh no");
          } else if (snapshot.hasData) {
            markers.clear();
            for (Map<String, dynamic> bathroom in snapshot.data!) {
              LatLng point = LatLng(bathroom['location']['latitude'],
                  bathroom['location']['longitude']);
              markers.add(Marker(
                  markerId: MarkerId(point.toString()),
                  position: point,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
                  onTap: () {
                    Map<String, dynamic> amenities = bathroom['amenities'];
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => Column(children: [
                              const Padding(padding: EdgeInsets.all(5)),
                              Text(
                                bathroom["name"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text("Soap"),
                                                Checkbox(
                                                  value: amenities["soap"],
                                                  onChanged: (bool? value) {},
                                                )
                                              ]),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text("Toilet Paper"),
                                                Checkbox(
                                                  value:
                                                      amenities["toilet_paper"],
                                                  onChanged: (bool? value) {},
                                                )
                                              ]),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text("Tampons"),
                                                Checkbox(
                                                  value: amenities["tampons"],
                                                  onChanged: (bool? value) {},
                                                )
                                              ]),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text("Hand Dryer"),
                                                Checkbox(
                                                  value:
                                                      amenities["hand_dryer"],
                                                  onChanged: (bool? value) {},
                                                )
                                              ]),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text("Hot Water"),
                                                Checkbox(
                                                  value: amenities["hot_water"],
                                                  onChanged: (bool? value) {},
                                                )
                                              ]),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text("Seat Covers"),
                                                Checkbox(
                                                  value:
                                                      amenities["seat_covers"],
                                                  onChanged: (bool? value) {},
                                                )
                                              ]),
                                        ]),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text("Baby Station"),
                                                Checkbox(
                                                  value:
                                                      amenities["baby_station"],
                                                  onChanged: (bool? value) {},
                                                )
                                              ]),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text(
                                                    "Hands-free Flushing"),
                                                Checkbox(
                                                  value:
                                                      amenities["auto_flush"],
                                                  onChanged: (bool? value) {},
                                                )
                                              ]),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text("Hands-free Sinks"),
                                                Checkbox(
                                                  value: amenities["auto_sink"],
                                                  onChanged: (bool? value) {},
                                                )
                                              ]),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text(
                                                    "Hands-free Soap Dispensers"),
                                                Checkbox(
                                                  value: amenities["auto_soap"],
                                                  onChanged: (bool? value) {},
                                                )
                                              ]),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text("Verified"),
                                                Checkbox(
                                                  value: bathroom["verified"],
                                                  onChanged: (bool? value) {},
                                                )
                                              ]),
                                        ]),
                                  ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text("User: "),
                                    FutureBuilder<Map<String, dynamic>?>(
                                      // We can get a lot more out of getUserFromUID, but for now the username is enough.
                                      future: DatabaseService.getUserFromUID(bathroom['user']),
                                      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                                        if (snapshot.hasData && snapshot.data != null) {
                                          return Text(snapshot.data!['displayName']);
                                        } else {
                                          return const Text("User not found");
                                        }
                                      },
                                    )
                                  ]),
                            ]));
                  }));
            }
            return GoogleMap(
              onMapCreated: _onMapCreated,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 17.0,
              ),
              markers: markers,
              // These things don't work in web, see: <https://github.com/flutter/flutter/issues/64073>
              compassEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      bottomNavigationBar: (widget.user == null
          ? null
          : BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.locationArrow),
                    label: "Bathrooms"),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.solidStar), label: "Reviews"),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.toiletPaper),
                    label: "Your Bathrooms"),
              ],
              currentIndex: _selectedIndex,
              onTap: _handleNavTap,
              selectedItemColor: Colors.white,
              backgroundColor: Colors.blue,
            )),
    );
  }
}
