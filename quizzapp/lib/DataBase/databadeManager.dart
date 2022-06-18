import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference teacherList =
      FirebaseFirestore.instance.collection('Teachers');

  Future<void> createTeacher(String email, String uId) async {
    Map<String, dynamic> map = {
      'Email': email,
      'uID': uId,
    };
    return await teacherList.doc(uId).set(map);
  }

  
}
