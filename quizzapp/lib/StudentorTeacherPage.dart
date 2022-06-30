import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'Student Folder/StudentMain.dart';
import 'Teacher Folder/TeachersMain.dart';






class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 194, 186, 196),
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.all(20),
                child: Column(children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Text(
                      "Welcome to QuizApp",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Color.fromARGB(255, 83, 11, 79),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 20,
                    thickness: 1,
                    indent: 5,
                    endIndent: 5,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Container(
                         alignment: Alignment.center,
                        child: ElevatedButton(
                         
                          onPressed: (() {
                            Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                         StudentMain()));
                          }),
                          child: Text("Student"),
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Container(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TeacherMain()));
                          }),
                          child: Text("Teacher"),
                        )),
                  ),
                ]),
              ),
            ),
          ),
        ));
  }
}
