import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizzapp/DataBase/databaseManager.dart';
import 'package:quizzapp/ScreenUI/TeacherUI/Quizzes/quizCard.dart';

class OldQuizzes extends StatefulWidget {
  const OldQuizzes({Key? key}) : super(key: key);

  @override
  State<OldQuizzes> createState() => _OldQuizzesState();
}

class _OldQuizzesState extends State<OldQuizzes> {
  List<dynamic> oldQuizList = [];
  bool isLoading = true;

  getOldQuizList() async {
    List results = await DatabaseManager().getQuizList();
    print('This is quizz List');
    print(results);

    for (int i = 0; i < results.length; i++) {
      Timestamp quizDateTime =
          results[i]['QuizzInfo']['QuizzInfo']['Date & Time'];
      DateTime dateTime = DateTime.now();
      if ((dateTime.isAfter(quizDateTime.toDate()))) {
        if (this.mounted) {
          // check whether the state object is in tree
          setState(() {
            oldQuizList.add(results[i]);
          });
        }
        
      }
    }
    isLoading = false;
    return oldQuizList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOldQuizList();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(width: 30, height: 40, child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListView.builder(
                  itemCount: oldQuizList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 16),
                  itemBuilder: (context, index) {
                    return QuizListCard(
                        batch: oldQuizList[index]['QuizzInfo']['QuizzInfo']
                            ['Batch'],
                        dateTime: oldQuizList[index]['QuizzInfo']['QuizzInfo']
                            ['Date & Time'],
                        questionList: oldQuizList[index]['QuizzQuestions'],
                        quizName: oldQuizList[index]['QuizName']['QuizName'],
                        quizSubject: oldQuizList[index]['QuizzInfo']['Subject'],
                        teacherEmail: oldQuizList[index]['QuizzInfo']
                            ['TeacherEmail']);
                  },
                )
              ],
            ),
          );
  }
}
