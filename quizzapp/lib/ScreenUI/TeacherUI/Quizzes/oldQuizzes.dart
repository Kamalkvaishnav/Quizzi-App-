import 'package:flutter/material.dart';
import 'package:quizzapp/DataBase/databaseManager.dart';

class OldQuizzes extends StatefulWidget {
  const OldQuizzes({Key? key}) : super(key: key);

  @override
  State<OldQuizzes> createState() => _OldQuizzesState();
}

class _OldQuizzesState extends State<OldQuizzes> {
  List<dynamic> oldQuizList = [];

  getOldQuizList() async {
    dynamic results = await DatabaseManager().getQuizList();
    DateTime datetime = DateTime.now();
    print('This is quizz List');
    print(results);
    // bool check = datetime.isBefore(results)
    // if()
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOldQuizList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [Text("All the old quizzes are here!!")],
    );
  }
}
