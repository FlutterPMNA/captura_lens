import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods {
  Future addPhotoDetails(Map<String, dynamic> photoInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Photographers")
        .doc(id)
        .set(photoInfoMap);
  }
  Future addAdminCompetition(Map<String, dynamic> competitionInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Competition")
        .doc(id)
        .set(competitionInfoMap);
  }
  
  Future<Stream<QuerySnapshot>> getCompetitionDetails()async{
    return  FirebaseFirestore.instance.collection("Competition").snapshots();
  }
}
