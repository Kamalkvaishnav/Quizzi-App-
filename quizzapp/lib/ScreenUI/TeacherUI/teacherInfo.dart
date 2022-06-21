import 'package:flutter/material.dart';
import 'package:quizzapp/ScreenUI/TeacherUI/teacherHomepage.dart';
import '../../DataBase/databaseManager.dart';

class TeacherInfo extends StatefulWidget {
  String email;
  String uID;

  TeacherInfo({Key? key, required this.email, required this.uID})
      : super(key: key);

  @override
  State<TeacherInfo> createState() => _TeacherInfoState();
}

class _TeacherInfoState extends State<TeacherInfo> {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
                color: const Color.fromARGB(
                  255,
                  137,
                  0,
                  161,
                ),
                borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.all(20),
            child: Column(children: [
              const SizedBox(
                height: 60,
              ),
              Text(
                "Welcome, ${widget.email}",
                style: const TextStyle(
                    fontSize: 32.0,
                    color: Color.fromARGB(255, 254, 187, 86),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: subjectController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Subject',
                      hintText: 'Choose your department'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: numberController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone No.',
                      hintText: 'Add your number'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    DatabaseManager().createTeacher(
                        widget.email,
                        widget.uID,
                        numberController.text.trim(),
                        subjectController.text.trim());
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TeacherHomePage(teacherEmail: widget.email)));
                  },
                  child: const Text('Save'))
            ]),
          ),
        ),
      ),
    );
  }
}
