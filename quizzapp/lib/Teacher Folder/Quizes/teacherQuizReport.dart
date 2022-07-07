import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../Services/Teacher_DatabaseManager.dart';

class QuizReportTeacher extends StatefulWidget {
  String quizName;
  String quizSubject;
  List questionList;
  List QuizMarks ;
  List<MarksData> data;
  QuizReportTeacher(
      {Key? key,
      required this.quizName,
      required this.quizSubject,
      required this.questionList,
      required this.QuizMarks,
      required this.data})
      : super(key: key);

  @override
  State<QuizReportTeacher> createState() => _QuizReportTeacherState();
}

class _QuizReportTeacherState extends State<QuizReportTeacher> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Report"),
          backgroundColor: Colors.deepPurpleAccent,
          elevation: 3,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.4), BlendMode.dstATop),
              image: AssetImage('assets/${widget.quizSubject}.jpg'),
              fit: BoxFit.cover,
            )),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(widget.quizName.toUpperCase(),
                      style: TextStyle(
                          backgroundColor: Colors.white70,
                          fontSize: 40,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold)),
                  Text('Quiz Report',
                      style: TextStyle(
                          backgroundColor: Colors.white70,
                          fontSize: 40,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const Divider(
            height: 20,
            color: Color.fromARGB(183, 115, 66, 250),
            thickness: 6,
          ),
          Column(
            children: [
              ExpansionTile(
                backgroundColor: Colors.white60,
                collapsedBackgroundColor: Colors.black12,
                leading: const Icon(Icons.wine_bar_outlined),
                title: Text('Ranks',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold)),
                subtitle:
                    Text('${widget.QuizMarks.length} students attempted the quiz.'),
                // Contents
                children: [
                  (widget.QuizMarks.isNotEmpty)
                      ? ListView.builder(
                          itemCount: widget.QuizMarks.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 2,
                              shadowColor:
                                  const Color.fromARGB(255, 213, 200, 249),
                              margin: const EdgeInsets.all(10),
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.deepPurpleAccent,
                                      width: 1)),
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                height: 50,
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                          child: Row(
                                        children: <Widget>[
                                          const Icon(
                                            Icons.wine_bar_rounded,
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Text('${index + 1}.'),
                                          Expanded(
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    widget.QuizMarks[index]
                                                        ['StudentEmail'],
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors
                                                            .grey.shade600,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    "Marks: ${widget.QuizMarks[index]['Marks']}",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors
                                                            .grey.shade600,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ))
                                    ]),
                              ),
                            );
                          })
                      : Center(
                          child: Container(
                              child:
                                  Text('No one have attempted the quiz yet!')),
                        )
                ],
              ),
              Divider(),
              ExpansionTile(
                backgroundColor: Colors.white60,
                collapsedBackgroundColor: Colors.black12,
                leading: const Icon(Icons.grade),
                title: Text('Graph',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold)),
                subtitle: Text('Expand this tile to see its contents'),
                // Contents
                children: [
                  widget.data.isNotEmpty
                      ? SafeArea(
                          child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              // Chart title
                              title: ChartTitle(text: 'Marks analysis'),
                              // Enable legend
                              legend: Legend(isVisible: true),
                              // Enable tooltip
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <ChartSeries<MarksData, String>>[
                                LineSeries<MarksData, String>(
                                    dataSource: widget.data,
                                    xValueMapper: (MarksData marks, _) =>
                                        marks.email,
                                    yValueMapper: (MarksData marks, _) =>
                                        marks.marks,
                                    name: 'Marks',
                                    // Enable data label
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true))
                              ]),
                        )
                      : Center(
                          child: Container(
                              child:
                                  Text('No one have attempted the quiz yet!')),
                        )
                ],
              ),
              Divider(),
              ExpansionTile(
                backgroundColor: Colors.white60,
                collapsedBackgroundColor: Colors.black12,
                leading: const Icon(Icons.question_answer),
                title: Text('Questions',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold)),
                subtitle: Text('Expand this tile to see its contents'),
                // Contents
                children: [
                  ListView.builder(
                      itemCount: widget.questionList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          backgroundColor: Colors.white60,
                          collapsedBackgroundColor: Colors.black12,
                          leading: Text('${index+1}'),
                          title: Text(widget.questionList[index]['Question'],
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold)),
                          subtitle:
                              Text(widget.questionList[index]['Subject']),
                          // Contents
                          children: [
                            Text(widget.questionList[index]['Option 1']),
                            Text(widget.questionList[index]['Option 2']),
                            Text(widget.questionList[index]['Option 3']),
                            Text(widget.questionList[index]['Option 4']),
                            Text(widget.questionList[index]['Answer']),
                          ],
                        );
                      })
                ],
              ),
              Divider(),
            ],
          )
        ])));
  }
}

class MarksData {
  MarksData(this.email, this.marks);

  final String email;
  final double marks;
}
