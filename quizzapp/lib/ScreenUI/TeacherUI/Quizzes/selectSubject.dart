import 'package:flutter/material.dart';

import 'createQuiz.dart';

class SelectSubject extends StatefulWidget {
  String teacherEmail;
  SelectSubject({Key? key, required this.teacherEmail}) : super(key: key);
  

  @override
  State<SelectSubject> createState() => _SelectSubjectState();
}

class _SelectSubjectState extends State<SelectSubject> {
  String dropdownvalue = 'Maths';

  var items = ['Maths', 'Physics', 'Chemistry'];
  void _cancel() {
    Navigator.pop(context);
  }

 void _submit()  {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateQuiz(subject: dropdownvalue ,teacherEmail: widget.teacherEmail)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
                  // Initial Value
                  value: dropdownvalue,
    
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),
    
                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                   
                      dropdownvalue = newValue!;
                
                  },
            ),
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: _cancel,
            ),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
