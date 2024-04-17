import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DataBaseMethods {
  Future addPhotoDetails(Map<String, dynamic> photoInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Photographers")
        .doc(id)
        .set(photoInfoMap);
  }
  Future<Stream<QuerySnapshot>> getPhotographerDetails()async{
    return await FirebaseFirestore.instance.collection("Photographers").snapshots();
  }

  Future photoPost(Map<String, dynamic> postInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Posts")
        .doc(id)
        .set(postInfoMap);
  }
  Future<Stream<QuerySnapshot>> getPostDetails()async{
    return await FirebaseFirestore.instance.collection("Posts").snapshots();
  }

  Future complaintsDetails(Map<String, dynamic> complaintsInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Complaints")
        .doc(id)
        .set(complaintsInfoMap);
  }
  Future<Stream<QuerySnapshot>> getComplaintsDetails()async{
    return await FirebaseFirestore.instance.collection("Complaints").snapshots();
  }


  Future addAdminCompetition(Map<String, dynamic> competitionInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Competition")
        .doc(id)
        .set(competitionInfoMap);
  }
  
  Future<Stream<QuerySnapshot>> getCompetitionDetails()async{
    return await FirebaseFirestore.instance.collection("Competition").snapshots();
  }

  Future<Stream<QuerySnapshot>> getBookingDetails()async{
    return await FirebaseFirestore.instance.collection("Bookings").snapshots();
  }

  Future rejectBooking(String id) async{
    return await FirebaseFirestore.instance.collection("Bookings").doc(id).delete();
  }


  Reference reference = FirebaseStorage.instance.ref();
}
