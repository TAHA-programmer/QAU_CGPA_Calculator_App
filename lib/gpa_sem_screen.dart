import 'package:flutter/material.dart';
import 'package:qau_gpa_calculator/gpa_calculate_screen.dart';

class GpaSemScreen extends StatefulWidget {
  //for passing value of text field to next screen
  final int noOfSubjects;
  const GpaSemScreen({super.key,required this.noOfSubjects});

  @override
  State<GpaSemScreen> createState() => _GpaSemScreenState();
}

class _GpaSemScreenState extends State<GpaSemScreen> {
  final TextEditingController semController = TextEditingController();
  String? errorMssg;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green.shade50,
        appBar: AppBar(
          backgroundColor: Colors.cyanAccent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_rounded),
          ),
          title: Text("GPA CALCULATOR",
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
                    controller: semController,
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Total Subject(s)",
                      border: OutlineInputBorder(),
                      hintText: "Enter Number of Subject(s)(max 10)",
                      prefixIcon: Icon(Icons.checklist),
                      errorText: errorMssg, // Display error message
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
                      final value = semController.text.trim();

                      setState(() {
                        errorMssg = null; // Reset the error message
                      });

                      if (value.isEmpty) {
                        setState(() {
                          errorMssg = "Please enter number of subjects";
                        });
                      } else {
                        int? semesterNumber = int.tryParse(value);
                        if (semesterNumber == null || semesterNumber < 1 || semesterNumber > 10) {
                          setState(() {
                            errorMssg = "Subject number must be in the range of 1-10";
                          });
                        } else {
                          // If valid, navigate to the next screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GpaCalculateScreen(noOfSubjects:semesterNumber),
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
        ),
      ),
    );
  }
}
