import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GpaCalculateScreen extends StatefulWidget {
  final int noOfSubjects;
  const GpaCalculateScreen({super.key, required this.noOfSubjects});

  @override
  State<GpaCalculateScreen> createState() => _GpaCalculateScreenState();
}

class _GpaCalculateScreenState extends State<GpaCalculateScreen> {
  final List<TextEditingController> subjectNameController = [];
  final List<TextEditingController> subjectNoController = [];
  final List<TextEditingController> creditsController = [];
  List<int?> credits = [];
  String? _errorMssg;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.noOfSubjects; i++) {
      subjectNameController.add(TextEditingController());
      subjectNoController.add(TextEditingController());
      creditsController.add(TextEditingController());
      credits.add(null); // Initialize with null
    }
  }

  @override
  void dispose() {
    for (var controller in subjectNameController) {
      controller.dispose();
    }
    for (var controller in subjectNoController) {
      controller.dispose();
    }
    for (var controller in creditsController) {
      controller.dispose();
    }
    super.dispose();
  }

  double CalculateGpa(double marks, int credits) {
    if (marks >= 80) {
      return 4.0 * credits;
    } else if (marks >= 76 && marks <= 79) {
      return 3.8 * credits;
    } else if (marks >= 72 && marks <= 75) {
      return 3.5 * credits;
    } else if (marks >= 68 && marks <= 71) {
      return 3.0 * credits;
    } else if (marks >= 64 && marks <= 67) {
      return 2.8 * credits;
    } else if (marks >= 60 && marks <= 63) {
      return 2.5 * credits;
    } else if (marks >= 55 && marks <= 59) {
      return 2.0 * credits;
    } else if (marks >= 50 && marks <= 54) {
      return 1.0 * credits;
    } else {
      return 0.0 * credits;
    }
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
            "GPA CALCULATOR",
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
                  itemCount: widget.noOfSubjects,
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
                                controller: subjectNameController[index],
                                maxLength: 20,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Subject Name",
                                  hintText: "Enter Subject Name",
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                                ),
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
                                controller: subjectNoController[index],
                                maxLength: 3,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Marks",
                                  hintText: "Enter Marks",
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              constraints:const BoxConstraints(
                                maxHeight: 80,
                              ),
                              child: DropdownButtonFormField<int>(
                                value: credits[index],
                                items: [1, 2, 3, 4].map((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Center(child: Text('$value')),
                                  );
                                }).toList(),
                                onChanged: (int? newValue) {
                                  setState(() {
                                    credits[index] = newValue;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: "Credit Hours",
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue, width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                hint: Center(child: Text('Select Credits Hours')),
                                isExpanded: true,
                              ),
                            ),
                          ),
                        ],),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  bool allFieldsFilled = true;
                  double totalGpa = 0.0;
                  int totalCredits = 0;

                  for (int i = 0; i < widget.noOfSubjects; i++) {
                    double marks = double.tryParse(subjectNoController[i].text) ?? 0.0;
                    int? creditsValue = credits[i];

                    if (subjectNameController[i].text.isEmpty ||
                        subjectNoController[i].text.isEmpty ||
                        creditsValue == null) {
                      allFieldsFilled = false;
                      break;
                    }

                    if (marks < 0 || marks > 100) {
                      allFieldsFilled = false;
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Input Error",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Text("Marks must be between 0 and 100",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("OK",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }

                    totalGpa += CalculateGpa(marks, creditsValue);
                    totalCredits += creditsValue;
                  }

                  if (!allFieldsFilled) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Input Error",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: Text("Please fill out all fields and ensure marks are between 0 and 100",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("OK",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }

                  double GPA = totalCredits > 0 ? totalGpa / totalCredits : 0.0;

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("GPA RESULT",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Text("YOUR GPA IS: ${GPA.toStringAsFixed(4)}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("OK",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  "Calculate GPA",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
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
