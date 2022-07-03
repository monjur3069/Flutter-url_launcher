import 'dart:io';

import 'package:day19/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeeDetailsPage extends StatefulWidget {
  static const String routeName = '/details';
  const EmployeeDetailsPage({Key? key}) : super(key: key);

  @override
  State<EmployeeDetailsPage> createState() => _EmployeeDetailsPageState();
}

class _EmployeeDetailsPageState extends State<EmployeeDetailsPage> {
  late EmployeeModel employee;


  @override
  void didChangeDependencies() {
    employee = ModalRoute.of(context)!.settings.arguments as EmployeeModel;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee.name),
      ),
      body: ListView(
        children: [
          Image.file(File(employee.img),width: double.maxFinite,height: 300,fit: BoxFit.cover,),
          ListTile(
            title: Text(employee.mobileNumber),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: _callEmployee, icon: Icon(Icons.call)),
                IconButton(onPressed: _msgEmployee, icon: Icon(Icons.sms)),
              ],
            ),
          ),
          ListTile(
            title: Text(employee.email),
            trailing: IconButton(onPressed: _emailEmployee, icon: Icon(Icons.email)),
          ),
          ListTile(
            title: Text(employee.streetAddress),
            trailing: IconButton(onPressed: _addressOfEmployee, icon: Icon(Icons.maps_home_work_outlined)),
          ),
          ListTile(
            title: Text(employee.desingnation),
            trailing: Text('BDT ${employee.salary}')
          ),
        ],
      ),
    );
  }

  void _callEmployee() async{
    final uri = Uri.parse('tel: ${employee.mobileNumber}');
    if(await canLaunchUrl(uri)){
      await launchUrl(uri);
    }
    else{
      throw 'could not launce url';
    }
  }

  void _msgEmployee() async{
    final msgUri = Uri.parse('sms: ${employee.mobileNumber}');
    if(await canLaunchUrl(msgUri)){
    await launchUrl(msgUri);
    }
    else{
    throw 'could not launce url';
    }
  }

  void _emailEmployee() async{
    final emailUri = Uri.parse('mailto: ${employee.email}?subject=Nothing&body=$dumyText');
    if(await canLaunchUrl(emailUri)){
    await launchUrl(emailUri);
    }
    else{
    throw 'could not launce url';
    }
  }

  void _addressOfEmployee() async{
    if(Platform.isAndroid == true){
      final mapUri = Uri.parse('geo:0,0?q=${employee.streetAddress}');
      if(await canLaunchUrl(mapUri)){
        await launchUrl(mapUri);
      }
      else{
        throw 'could not launce url';
      }
    }
    if(Platform.isIOS == true){
      final mapUri = Uri.parse('http://maps.apple.com/?q=${employee.streetAddress}');
      if(await canLaunchUrl(mapUri)){
        await launchUrl(mapUri);
      }
      else{
        throw 'could not launce url';
      }
    }
  }


}

const String dumyText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sapien et ligula ullamcorper malesuada proin libero. Porttitor rhoncus dolor purus non enim. Massa tincidunt nunc pulvinar sapien. Mattis ullamcorper velit sed ullamcorper morbi tincidunt ornare massa.';
