import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:potspot/screens/finalize_bathroom_page.dart';

class AddBathroomPage extends StatefulWidget {
  final User user;
  const AddBathroomPage({Key? key, required this.user}) : super(key: key);

  @override
  State<AddBathroomPage> createState() => _AddBathroomState();

}

class _AddBathroomState extends State<AddBathroomPage> {
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  final LatLng _center = const LatLng(39.7287607, -121.8498174);
  Widget? _fab;


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _handleTap(LatLng point) {
    setState(() {

      if (markers.isNotEmpty) {
        markers.clear();
      }
      markers.add(
          Marker(
            markerId: MarkerId(point.toString()),
            position: point,
            infoWindow: const InfoWindow(
              title: 'New Bathroom',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          )
      );
      _fab = FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FinalizeBathroomPage(
                user: widget.user,
                location: point
            )),
          );
        },
        child: const Icon(Icons.arrow_forward),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Bathroom"),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 17.0,
        ),
        onTap: _handleTap,
        markers: markers,
        // These things don't work in web, see: <https://github.com/flutter/flutter/issues/64073>
        compassEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false,

      ),
      floatingActionButton: _fab
    );
  }
}