import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqf_db2_32/pages/new_student.dart';
import 'package:sqf_db2_32/pages/student_details.dart';
import 'package:sqf_db2_32/pages/student_list.dart';
import 'package:sqf_db2_32/provider/student_contact_provider.dart';

void main() {
  runApp(
    MultiProvider(
     providers: [
      ChangeNotifierProvider(create: (context)=>StudentContactProvider() ..getAllContacts())
     ], 
      child: const MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: StudentList.routeName,
      routes: {
        NewStudent.routeName: (context) => NewStudent(),
        StudentList.routeName: (context) => StudentList(),
        StudentDetails.routeName: ((context) => StudentDetails()
        
        ),
      },
    );
  }
}
