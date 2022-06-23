import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference teacherList =
      FirebaseFirestore.instance.collection('Teachers');
  final CollectionReference maths =
      FirebaseFirestore.instance.collection('Maths');
  final CollectionReference physics =
      FirebaseFirestore.instance.collection('Physics');
  final CollectionReference chemistry =
      FirebaseFirestore.instance.collection('Chemistry');
  final CollectionReference quizzes =
      FirebaseFirestore.instance.collection('Quizzes');
  final CollectionReference batches =
      FirebaseFirestore.instance.collection('Batches');

  Future<void> createTeacher(
      String email, String uId, String number, String subject) async {
    Map<String, dynamic> map = {
      'Email': email,
      'uID': uId,
      'Number': number,
      'Subject': subject
    };
    return await teacherList.doc(email).set(map);
  }

  Future<void> addBatch(String studentemail, String batchName) async {
    List<dynamic> studentEmailList = [];

    // await batches.doc(batchName).get().then((value) {
    //   studentEmailList = value['Students'];
    // });
    studentEmailList.add(studentemail);

    return await batches
        .doc(batchName)
        .set({'Batch Name': batchName, 'Students': studentEmailList});
  }

  Future<void> createquestion(String subject, String question, String option1,
      String option2, String option3, String option4, String answer) async {
    Map<String, dynamic> map = {
      'Question': question,
      'Subject': subject,
      'Option 1': option1,
      'Option 2': option2,
      'Option 3': option3,
      'Option 4': option4,
      'Answer': answer
    };
    return await chemistry.doc(question).set(map);
  }

  Future<void> createQuiz(String quizName, String subject, String teacherEmail,
      List<dynamic> questionList, DateTime dateTime) async {
    Map<String, dynamic> infoMap = {
      'TeacherEmail': teacherEmail,
      'Subject': subject,
      'QuizName': quizName,
      'Date & Time': dateTime
    };

    await quizzes
        .doc(quizName)
        .collection('QuizzInfo')
        .doc(teacherEmail)
        .set(infoMap);
    await teacherList
        .doc(teacherEmail)
        .collection("Quizzes")
        .doc(quizName)
        .collection('QuizzInfo')
        .doc(subject)
        .set(infoMap);

    for (int i = 0; i < questionList.length; i++) {
      Map<String, dynamic> questionMap = {
        'Question': questionList[i]["Question"],
        'Option 1': questionList[i]["Option 1"],
        'Option 2': questionList[i]["Option 2"],
        'Option 3': questionList[i]["Option 3"],
        'Option 4': questionList[i]["Option 4"],
        "Answer": questionList[i]["Answer"],
        'Subject': questionList[i]['Subject']
      };

      quizzes
          .doc(quizName)
          .collection('QuizzQuestions')
          .doc(questionList[i]["Question"])
          .set(questionMap);
      teacherList
          .doc(teacherEmail)
          .collection("Quizzes")
          .doc(quizName)
          .collection('QuizzQuestions')
          .doc(questionList[i]["Question"])
          .set(questionMap);
    }
  }

  Future<List<dynamic>> getMathsQuestionList() async {
    List<dynamic> mathsquestions = [];
    await maths.get().then((value) {
      value.docs.forEach((element) {
        mathsquestions.add(element.data());
      });
    });
    return mathsquestions;
  }

  Future<List<dynamic>> getPhysicsQuestionList() async {
    List<dynamic> physicsquestions = [];
    await physics.get().then((value) {
      value.docs.forEach((element) {
        physicsquestions.add(element.data());
      });
    });
    return physicsquestions;
  }

  Future<List<dynamic>> getChemistryQuestionList() async {
    List<dynamic> chemistryquestions = [];
    await chemistry.get().then((value) {
      value.docs.forEach((element) {
        chemistryquestions.add(element.data());
      });
    });
    return chemistryquestions;
  }
}