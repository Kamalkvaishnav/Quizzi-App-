import 'package:flutter/material.dart';

class OldQuizzes extends StatefulWidget {
  const OldQuizzes({Key? key}) : super(key: key);

  @override
  State<OldQuizzes> createState() => _OldQuizzesState();
}

class _OldQuizzesState extends State<OldQuizzes> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [Text("All the old quizzes are here!!")],
    );
  }
}
