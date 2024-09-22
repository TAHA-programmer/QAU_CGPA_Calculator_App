import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CgpaCalculateScreen extends StatefulWidget {
  final int noOfSemesters;
  const CgpaCalculateScreen({super.key, required this.noOfSemesters});

  @override
  State<CgpaCalculateScreen> createState() => _CgpaCalculateScreenState();
}

class _CgpaCalculateScreenState extends State<CgpaCalculateScreen> {
  final List<TextEditingController> semGpaController = [];
  final List<TextEditingController> semCreditHrsController = [];
  String? _errorMssg, errorMssg2;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.noOfSemesters; i++) {
      semGpaController.add(TextEditingController());
      semCreditHrsController.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in semGpaController) {
      controller.dispose();
    }
    for (var controller in semCreditHrsController) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyanAccent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_rounded),
          ),
          title: Text(
            "CGPA CALCULATOR",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  "assets/images/qau_logo.jpg",
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade50,
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widget.noOfSemesters,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              constraints: BoxConstraints(
                                maxHeight: 80,
                              ),
                              child: TextField(
                                controller: semGpaController[index],
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Semester ${index + 1} GPA",
                                  hintText: "Enter Semester ${index + 1} GPA",
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                                  errorText: _errorMssg,
                                ),
                                inputFormatters: [
                                  // Allow up to 4 decimal places for GPA
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,4}')),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    final doubleValue = double.tryParse(value);
                                    if (doubleValue == null || doubleValue < 1.0 || doubleValue > 4.0) {
                                      _errorMssg = "between 1 and 4";
                                    } else {
                                      _errorMssg = null; // Clear the error message if valid
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              constraints: BoxConstraints(
                                maxHeight: 80,
                              ),
                              child: TextField(
                                controller: semCreditHrsController[index],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Credit Hours",
                                  hintText: "Enter Credit Hours of Semester ${index + 1}",
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                                  errorText: errorMssg2,
                                ),
                                inputFormatters: [
                                  // Restrict to integers only
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    final intValue = int.tryParse(value);
                                    if (intValue == null || intValue < 1 || intValue > 20) {
                                      errorMssg2 = "between 1 and 20";
                                    } else {
                                      errorMssg2 = null; // Clear the error message if valid
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  bool allFieldsFilled=true;
                  double totalGpa = 0.0;
                  int totalCredits = 0;
                  for (int i = 0; i < widget.noOfSemesters; i++) {
                    final gpaText = semGpaController[i].text;
                    final creditHrsText = semCreditHrsController[i].text;

                    if (gpaText.isEmpty || creditHrsText.isEmpty) {
                      allFieldsFilled = false;
                      break;
                    }

                    final gpa = double.tryParse(gpaText) ?? 0.0;
                    final credits = int.tryParse(creditHrsText) ?? 0;

                    if (gpa < 1.0 || gpa > 4.0 || credits < 1 || credits > 20) {
                      allFieldsFilled = false;
                      break;
                    }

                    totalGpa += gpa * credits;
                    totalCredits += credits;
                  }
                  if(!allFieldsFilled){
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title: Text("Input Error",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Text("Please fill out all fields properly",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                          },
                              child: Text("OK",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))
                        ],
                      );
                    },);
                    return;
                  }

                  double CGPA = totalCredits > 0 ? totalGpa / totalCredits : 0.0;

                  showDialog(context: context, builder: (context) {
                    return AlertDialog(title: Text("CGPA RESULT",
                      style: TextStyle(color: Colors.black,fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                      content: Text("YOUR CGPA IS: ${CGPA.toStringAsFixed(4)}", style: TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold),),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("OK",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                      ],
                    );
                  },);
                },
                child: Text(
                  "Calculate CGPA",
                  style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}