import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzapp/ScreenUI/TeacherUI/Quizzes/selectSubject.dart';

class NewQuizzes extends StatefulWidget {

  NewQuizzes({Key? key}) : super(key: key);

  @override
  State<NewQuizzes> createState() => _NewQuizzesState();
}

class _NewQuizzesState extends State<NewQuizzes> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Here are future quizzes!!'),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          SelectSubject(teacherEmail: context.watch<User?>()!.email!)));
            },
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
