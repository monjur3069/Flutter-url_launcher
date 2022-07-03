import 'dart:io';

import 'package:day19/employee_model.dart';
import 'package:day19/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class NewEmployeePage extends StatefulWidget {
  static const String routeName = '/new_employee';

  const NewEmployeePage({Key? key}) : super(key: key);

  @override
  State<NewEmployeePage> createState() => _NewEmployeePageState();
}

class _NewEmployeePageState extends State<NewEmployeePage> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final streetAddressController = TextEditingController();
  final salaryController = TextEditingController();

  String? dob;
  String? imagePath;
  ImageSource source = ImageSource.camera;
  String genderGroupValue = 'Male';
  String? designation;


  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    streetAddressController.dispose();
    salaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee'),
        actions: [
          IconButton(onPressed: saveEmployee, icon: Icon(Icons.done))
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(6),
        children: [
          TextField(
            keyboardType: TextInputType.name,
            controller: nameController,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.red,
              ),
              filled: true,
              border: InputBorder.none,
              labelStyle: TextStyle(color: Colors.red),
              labelText: 'Employee Name',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.phone,
            controller: mobileController,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.phone,
                color: Colors.green,
              ),
              filled: true,
              border: InputBorder.none,
              labelStyle: TextStyle(color: Colors.green),
              labelText: 'Employee Mobile Number',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: Colors.purple,
              ),
              filled: true,
              border: InputBorder.none,
              labelStyle: TextStyle(color: Colors.purpleAccent),
              labelText: 'Employee  Email',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.streetAddress,
            controller: streetAddressController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: const Icon(
                Icons.maps_home_work_outlined,
                color: Colors.orange,
              ),
              filled: true,
              labelStyle: TextStyle(color: Colors.orangeAccent),
              labelText: 'Employee Street Address',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.phone,
            controller: salaryController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: const Icon(
                Icons.attach_money,
                color: Colors.green,
              ),
              filled: true,
              labelStyle: TextStyle(color: Colors.green),
              labelText: 'Employee Salary',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: selectDate,
                child: const Text('Select Date of Birth'),
              ),
              Chip(
                label: Text(dob == null ? 'No Date Chosen' : dob!),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                elevation: 10,
                child: imagePath == null
                    ? Image.asset(
                  'images/person.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )
                    : Image.file(
                  File(imagePath!),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        source = ImageSource.camera;
                        getImage();
                      },
                      icon: const Icon(Icons.camera),
                      label: const Text('Capture')),
                  TextButton.icon(
                      onPressed: () {
                        source = ImageSource.gallery;
                        getImage();
                      },
                      icon: const Icon(Icons.photo),
                      label: const Text('Gallery'))
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          DropdownButton(
              hint: Text('Select Designation'),
              value: designation,
              isExpanded: true,
              items: designationList.map((e) =>
                  DropdownMenuItem(
                      value: e,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(e),
                      )
                  )).toList(),
              onChanged: (value) {
                setState(() {
                  designation = value as String?;
                });
              }
          ),
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.elliptical(100, 200))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Select Gender'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(
                        value: 'Male',
                        groupValue: genderGroupValue,
                        onChanged: (value) {
                          setState(() {
                            genderGroupValue = value!;
                          });
                        }),
                    const Text('Male'),
                    Radio<String>(
                        value: 'Female',
                        groupValue: genderGroupValue,
                        onChanged: (value) {
                          setState(() {
                            genderGroupValue = value!;
                          });
                        }),
                    const Text('Female')
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        dob = DateFormat('dd/mm/yyyy').format(selectedDate);
      });
    }
    print('hello');
  }

  void getImage() async {
    final selectedImage = await ImagePicker().pickImage(source: source);
    if (selectedImage != null) {
      setState(() {
        imagePath = selectedImage.path;
        print(imagePath);
      });
    }
  }

  void saveEmployee() {
    if (nameController.text.isEmpty) {
      showMessage(context, 'Please Provide a name');
      return;
    }
    if (mobileController.text.isEmpty) {
      showMessage(context, 'Please Provide a Mobile Number');
      return;
    }
    if (emailController.text.isEmpty) {
      showMessage(context, 'Please Provide a Email Address');
      return;
    }
    if (salaryController.text.isEmpty) {
      showMessage(context, 'Please Provide a Salary');
      return;
    }
    if (streetAddressController.text.isEmpty) {
      showMessage(context, 'Please Provide a Street Address');
      return;
    }
    if (designation == null) {
      showMessage(context, 'Please select a designation');
      return;
    }
    if (imagePath == null) {
      showMessage(context, 'Please select a image');
      return;
    }
    if (dob == null) {
      showMessage(context, 'Please Enter Date_Of_Birth');
      return;
    }

    final employee = EmployeeModel(name: nameController.text,
        dob: dob!,
        img: imagePath!,
        desingnation: designation!,
        mobileNumber: mobileController.text,
        email: emailController.text,
        streetAddress: streetAddressController.text,
        salary: num.parse(salaryController.text),
        gender: genderGroupValue);

    employeeList.add(employee);
    Navigator.pop(context);
  }
}
