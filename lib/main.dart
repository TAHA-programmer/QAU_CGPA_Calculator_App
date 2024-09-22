import 'package:flutter/material.dart';
import 'package:qau_gpa_calculator/cgpa_sem_screen.dart';
import 'package:qau_gpa_calculator/gpa_sem_screen.dart';
import 'package:qau_gpa_calculator/splash_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      // Define the default font family.
      fontFamily: 'Poppins',
      // Customize text themes.
      textTheme: TextTheme(
        headlineSmall: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodySmall: TextStyle(fontSize: 14.0, fontFamily: 'Poppins'),
      ),
      // Customize ElevatedButton theme to use Poppins.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
    ),
    home: Splash_screen(),
  ));
}

class QAU_gpa_calculator extends StatefulWidget {
  const QAU_gpa_calculator({super.key} );

  @override
  State<QAU_gpa_calculator> createState() => _QAU_gpa_calculatorState();
}

class _QAU_gpa_calculatorState extends State<QAU_gpa_calculator> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "QAU GPA CALCULATOR",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.cyanAccent,
          leading: Icon(Icons.calculate),
        ),
        backgroundColor: Colors.green.shade50,
        body: SingleChildScrollView(child:Center(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center ,
            children:
            [
              SizedBox(height: 150,),
              ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child:
                    Image.asset(
                      "assets/images/qau_logo.jpg",
                      height: 250,
                      width: 250,
                    ),
                  ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 30),
                child:ElevatedButton( child: Text("Calculate GPA",
                  style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color:Colors.black),),
                    style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GpaSemScreen(noOfSubjects: 5,),));
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                child:ElevatedButton( child: Text("Calculate CGPA",
                  style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color:Colors.black),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CgpaSemScreen(noOfSemesters: 5,),));
                    }),
              ),
            ],),),
          ),)
    );
  }
}
