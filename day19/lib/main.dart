
import 'package:day19/pages/employee_details_page.dart';
import 'package:day19/pages/employee_list_page.dart';
import 'package:day19/pages/new_employee_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: EmployeeListPage.routeName,
      routes: {
        EmployeeListPage.routeName : (context) => EmployeeListPage(),
        NewEmployeePage.routeName : (context) => NewEmployeePage(),
        EmployeeDetailsPage.routeName : (context) => EmployeeDetailsPage(),
      },
    );
  }
}