import 'package:flutter/material.dart';
import 'package:qau_gpa_calculator/cgpa_calculate_screen.dart';

class CgpaSemScreen extends StatefulWidget {
  final int noOfSemesters;
  const CgpaSemScreen({super.key,required this.noOfSemesters});

  @override
  State<CgpaSemScreen> createState() => _CgpaSemScreenState();
}

class _CgpaSemScreenState extends State<CgpaSemScreen> {
  final TextEditingController gsemController=TextEditingController();
  String? gErrorMssg;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
        title: Text("CGPA CALCULATOR",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
        actions: [
          Padding(padding: const EdgeInsets.only(right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset("assets/images/qau_logo.jpg",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),),
          ),
        ],
      ),
      body: SingleChildScrollView(
    child: Center(
    child: Column(
      mainAxisAlignment:MainAxisAlignment.center ,
      children: [
        SizedBox(height: 100,),
        ClipRRect(
          borderRadius: BorderRadius.circular(150),
          child:
          Image.asset(
            "assets/images/qau_logo.jpg",
            height: 250,
            width: 250,
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: gsemController,
            maxLength: 2,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Semester(s)",
              border: OutlineInputBorder(),
              hintText: "Enter Number Of Semester(s)(max 10)",
              prefixIcon: Icon(Icons.checklist),
              errorText: gErrorMssg, // Display error message
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: ElevatedButton(
            child: Text(
              "Submit",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              final value = gsemController.text.trim();

              setState(() {
                gErrorMssg = null; // Reset the error message
              });

              if (value.isEmpty) {
                setState(() {
                  gErrorMssg = "Please enter number of semesters";
                });
              } else {
                int? semesterNumber = int.tryParse(value);
                if (semesterNumber == null || semesterNumber < 1 || semesterNumber > 10) {
                  setState(() {
                    gErrorMssg = "Semester number must be in the range of 1-10";
                  });
                } else {
                  // If valid, navigate to the next screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CgpaCalculateScreen(noOfSemesters: semesterNumber,),
                    ),
                  );
                }
              }
            },
          ),
        ),
      ],
    ),
    ),
    )));
  }
}
