import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:sqf_db2_32/pages/student_model.dart';
import 'package:sqf_db2_32/provider/student_contact_provider.dart';

class NewStudent extends StatefulWidget {
  static const String routeName = '/';
  @override
  State<NewStudent> createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final instituteController = TextEditingController();
  final isFavController = TextEditingController();
  String? _dob;
  String? _genderGroupValue;
  String? _imagePath;
  ImageSource _imageSource = ImageSource.camera;
  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    instituteController.dispose();
    isFavController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Student'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person), labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Name can not be Empty";
                }
                if (value.length > 20) {
                  return "Name can be 20";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person), labelText: 'Phone'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Phone can not be Empty";
                }
                if (value.length > 10) {
                  return "Phone can be 10";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person), labelText: 'Address'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Address can not be Empty";
                }
                if (value.length > 20) {
                  return "Address can be 20";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: instituteController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person), labelText: 'Institute'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Institute can not be Empty";
                }
                if (value.length > 20) {
                  return "Institute can be 20";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: _selectedDate,
                      child: Text('Select Date of Birth')),
                  Text(_dob == null ? 'No Date Selected' : _dob!)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Select Gender '),
                  Radio<String>(
                      value: 'Male',
                      groupValue: _genderGroupValue,
                      onChanged: (value) {
                        setState(() {
                          _genderGroupValue = value;
                        });
                      }),
                  Text('Male'),
                  Radio<String>(
                      value: 'Female',
                      groupValue: _genderGroupValue,
                      onChanged: (value) {
                        setState(() {
                          _genderGroupValue = value;
                        });
                      }),
                  Text('Female'),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    child: _imagePath == null
                        ? Image.asset(
                            'images/Dipu.jpg',
                            height: 180,
                            width: 200,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(
                              _imagePath!,
                            ),
                            height: 180,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _imageSource = ImageSource.camera;
                            _getImage();
                          },
                          child: Text('Camera')),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _imageSource = ImageSource.gallery;
                            _getImage();
                          },
                          child: Text('Gallery')),
                    ],
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: saveData, child: Text('Save Data')),
          ],
        ),
      ),
    );
  }

  saveData() async {
    if (formKey.currentState!.validate()) {
      final contact = StudentModel(
        st_name: nameController.text,
        phone: phoneController.text,
        address: addressController.text,
        institute: instituteController.text,
        dob: _dob,
        gender: _genderGroupValue,
        image: _imagePath,
      );
      // print(contact.toString());
      //final rowId =await DBHelpers.insertStContact(contact);

      // Now We will use provider

      final status =
          await Provider.of<StudentContactProvider>(context, listen: false)
              .insertContact(contact);
      if (status) {
        Navigator.pop(context);
      } else {}
    }
  }

  void _selectedDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (selectedDate != null) {
      setState(() {
        _dob = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  void _getImage() async {
    final selectedImage = await ImagePicker().pickImage(source: _imageSource);
    if (selectedImage != null) {
      setState(() {
        _imagePath = selectedImage.path;
      });
    }
  }
}
