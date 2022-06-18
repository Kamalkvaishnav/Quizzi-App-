import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference teacherList =
      FirebaseFirestore.instance.collection('Teachers');

  Future<void> createTeacher(String email, String uId, String number, String subject) async {
    Map<String, dynamic> map = {
      'Email': email,
      'uID': uId,
      'Number': number,
      'Subject': subject
    };
    return await teacherList.doc(uId).set(map);
  }

   

  
}
