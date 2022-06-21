import 'package:flutter/material.dart';
import 'package:quizzapp/DataBase/databaseManager.dart';

class CreateQuiz extends StatefulWidget {
  String subject;
  String teacherEmail;
  CreateQuiz({Key? key, required this.teacherEmail, required this.subject})
      : super(key: key);

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  List<dynamic> questionList = [];
  List<dynamic> selectedquestion = [];
  TextEditingController quizNameController = TextEditingController();

  void _itemChange(dynamic itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedquestion.add(itemValue);
      } else {
        selectedquestion.remove(itemValue);
      }
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  _submit() {
    print("Quizz Created !!");
    print(selectedquestion);
    DatabaseManager().createQuiz(
        quizNameController.text.trim(), widget.subject, widget.teacherEmail, selectedquestion);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchQuestionList(widget.subject);
  }

  fetchQuestionList(String subject) async {
    if (subject == "Maths") {
      dynamic results = await DatabaseManager().getMathsQuestionList();
      setState(() {
        questionList = results;
      });
    }
    if (subject == "Physics") {
      dynamic results = await DatabaseManager().getPhysicsQuestionList();
      setState(() {
        questionList = results;
      });
    }
    if (subject == "Chemistry") {
      dynamic results = await DatabaseManager().getChemistryQuestionList();
      setState(() {
        questionList = results;
      });
    }
    print('This is question list ===>>' + questionList.toString());
    return questionList;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
          child: Column(
        children: [
          Text('Create New Quizz of ${widget.subject}'),
          TextField(
            controller: quizNameController,
            decoration: const InputDecoration(hintText: 'Quizz Name'),
          )
        ],
      )),
      content: SingleChildScrollView(
        child: ListBody(
          children: questionList
              .map((question) => CheckboxListTile(
                    value: selectedquestion.contains(question),
                    title: Text(question['Question']),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(question, isChecked!),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
