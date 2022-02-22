import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DatabaseService {
  // create functions to communicate with Firebase
  // 'add' auto generates id (documents)
  static Future<void> addBathroom(User user, String name, LatLng location, Map<String, dynamic> amenities) async {
    FirebaseFirestore.instance.collection('bathrooms').add({
      'user': user.uid,
      'name': name,
      'amenities': amenities,
      'location': {
        'latitude': location.latitude,
        'longitude': location.longitude
      },
      'verified': false
    });
  }

  static Future<List<Map<String, dynamic>>> getBathrooms() async {
    await Firebase.initializeApp();
    List<Map<String, dynamic>> bathrooms = [];
    QuerySnapshot<Map<String, dynamic>> query =
        await FirebaseFirestore.instance.collection('bathrooms').get();
    List bathroomsQuery = query.docs;
    for (QueryDocumentSnapshot<Map<String, dynamic>> bathroomSnap
        in bathroomsQuery) {
      bathrooms.add(bathroomSnap.data());
    }
    return bathrooms;
  }

  static Future<Map<String, dynamic>?> getUserFromUID(String? uid) async {
    if (uid == null) {
      return null;
    }
    try {
      return (await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get())
          .docs
          .first
          .data();
    } catch (error) {
      print(error);
      return null;
    }
  }

  static void setUser(User user) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('users');
    DocumentReference userDoc = collection.doc(user.uid);
    await userDoc.set({
      // Filtered list of user data stored in a user firestore collection
      // Email, Phone #, and the like redacted for privacy reasons
      'displayName': user.displayName,
      'creationTime': user.metadata.creationTime,
      'lastSignInTime': user.metadata.lastSignInTime,
      'uid': user.uid,
      'photoURL': user.photoURL
    });
  }
}
