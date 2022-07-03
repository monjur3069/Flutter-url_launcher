import 'dart:io';

import 'package:day19/employee_model.dart';
import 'package:day19/pages/employee_details_page.dart';
import 'package:day19/pages/new_employee_page.dart';
import 'package:flutter/material.dart';

class EmployeeListPage extends StatefulWidget {
  static const String routeName = '/';
  const EmployeeListPage({Key? key}) : super(key: key);

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employee List'),),
      body: ListView.builder(
          itemCount: employeeList.length,
          itemBuilder: (context,index){
            final emp = employeeList[index];
            return ListTile(
              onTap: ()=>Navigator.pushNamed(context, EmployeeDetailsPage.routeName,arguments: emp),
              leading: CircleAvatar(
                backgroundImage: FileImage(File(emp.img)),
              ),
              title: Text(emp.name),
              subtitle: Text(emp.desingnation),
            );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> Navigator.pushNamed(context, NewEmployeePage.routeName).then((value) => setState((){})),
        child: const Icon(Icons.add),
      ),
    );
  }
}
