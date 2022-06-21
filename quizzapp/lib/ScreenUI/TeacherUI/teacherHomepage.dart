import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzapp/ScreenUI/LoginUI/signIn.dart';
import 'package:quizzapp/ScreenUI/TeacherUI/Quizzes/newQuizzes.dart';
import 'package:quizzapp/ScreenUI/TeacherUI/Quizzes/oldQuizzes.dart';

import '../../Authantication/authantication_service.dart';

class TeacherHomePage extends StatefulWidget {
  String teacherEmail;
  TeacherHomePage({Key? key, required this.teacherEmail}) : super(key: key);

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  int _selectedIndex = 0;
  late String tEmail;
  List<Widget> quizpages = <Widget>[
    const OldQuizzes(),
    NewQuizzes()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      tEmail = widget.teacherEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Teacher Portal'),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueGrey)),
                  onPressed: (() {
                    context.read<AuthService>().signOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInPage()));
                  }),
                  child: const Text('Log out'))
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.label),
              label: 'Old',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'New',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        body: Center(
          child: quizpages.elementAt(_selectedIndex),
        ));
  }
}
