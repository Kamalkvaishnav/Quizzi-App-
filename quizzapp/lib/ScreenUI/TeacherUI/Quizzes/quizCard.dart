import 'package:flutter/material.dart';

import '../../../DataBase/databaseManager.dart';

class ChatList extends StatefulWidget {
  List<dynamic> questionList;
  String quizName;
  String quizSubject;
  String teacherEmail;
  DateTime dateTime;
  String batch;

  ChatList(
      {required this.batch, required this.dateTime, required this.questionList, required this.quizName, required this.quizSubject, required this.teacherEmail});

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  //for fetching database manager methods
  DatabaseManager databaseManager = new DatabaseManager();

  //onclick a chatroom is created and user is taken to the messagebox is inside


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // message(widget.sender, widget.receiver, widget.chatroomId);
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Text("${widget.dateTime}"),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.quizName,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(widget.batch)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
