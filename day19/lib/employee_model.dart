import 'package:flutter/material.dart';

class EmployeeModel {
  int? empId;
  String name;
  String dob;
  String img;
  String desingnation;
  String mobileNumber;
  String email;
  String streetAddress;
  num salary;
  String gender;

  EmployeeModel(
      {this.empId,
      required this.name,
      required this.dob,
      required this.img,
      required this.desingnation,
      required this.mobileNumber,
      required this.email,
      required this.streetAddress,
      required this.salary,
      required this.gender});
}

final List<EmployeeModel> employeeList = [
  EmployeeModel(
      name: 'Monjur Ahmed',
      dob: '30/07/1998',
      img:
          '/data/user/0/com.example.day19/cache/19042185-c86e-4c84-8160-d76dce571626-421999667.jpg',
      desingnation: 'CEO',
      mobileNumber: '01725402748',
      email: 'monjurahmed.cse@gmail.com',
      streetAddress: 'Kaundia,Savar,Dhaka',
      salary: 50000,
      gender: 'Male'),
];
final designationList = <String>[
  'Director',
  'CEO',
  'CTO',
  'Sales Manager',
  'Project Manager',
  'Senior Developer',
  'Software Engineer'
];
