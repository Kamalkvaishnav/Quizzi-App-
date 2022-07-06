import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Services/Databasemanager.dart';
import 'QuizPage.dart';


class QuizcardStudentSide extends StatefulWidget {
  List<dynamic> questionList;
  String quizName;
  String quizSubject;
  Timestamp dateTime;
  String batch;
  QuizcardStudentSide(
      {required this.batch,
      required this.dateTime,
      required this.questionList,
      required this.quizName,
      required this.quizSubject});

  @override
  State<QuizcardStudentSide> createState() => _QuizcardStudentSideState();
}

class _QuizcardStudentSideState extends State<QuizcardStudentSide> {
  DatabaseManager databaseManager = new DatabaseManager();

  //onclick a chatroom is created and user is taken to the messagebox is inside
  void _showdialog(int count) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            // // insetAnimationCurve: ,
            // backgroundColor: Color.fromARGB(255, 114, 236, 240),
            title: Text('Your marks is $count'),
            content: Text('Click for more info'),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Back'),
              )
            ],
          );
        });
  }

  //for fetching total marks
  List quizlist = [];
  bool isloading = false;
  getQuizList() async {
    List results = await DatabaseManager().getQuizans(widget.quizName);
    print('This is quizz List');
    // print(results);

    for (int i = 0; i < results.length; i++) {
      {
        quizlist.add(results[i]);
      }
    }

    if (mounted) {
      setState(() {
        isloading = true;
      });
    }
    return quizlist;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuizList();
  }

  bool attention = false;
  @override
  Widget build(BuildContext context) {
    

    return Card(
      borderOnForeground: attention,
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () async {
            int marks = await DatabaseManager().fetchquizmarks(widget.quizName);
          
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Quizpage(
                          ourquestionList: widget.questionList,
                          ourbatch: widget.batch,
                          ourdateTime: widget.dateTime,
                          ourquizName: widget.quizName,
                          ourquizSubject: widget.quizSubject,
                        )));
          },
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

             
              Container(
                padding: EdgeInsets.all(10),
                 decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                 
                ),
                child: Image.asset('assets/speedlabsLogo.png', height: 100, width:  100,)),
              // Icon( Icons.quiz_rounded, size: 70,color: Color.fromARGB(255, 43, 42, 39), ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(195, 235, 199, 120),
                      Color.fromARGB(192, 126, 81, 10)
                    ],
                  ),
                ),
                margin: EdgeInsets.all(2),
                // color: Color.fromARGB(255, 67, 116, 84),
                child: Text(
                  widget.quizName,
                  style: TextStyle(
                      decorationColor: Colors.blue[200],
                      fontFamily: 'RobotoMono',
                      fontSize: 25,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

