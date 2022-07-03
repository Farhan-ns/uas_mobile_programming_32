import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:uas_mobile_programming_32/components/appbar.dart';
import 'package:uas_mobile_programming_32/components/cButton.dart';
import 'package:uas_mobile_programming_32/components/cTextField.dart';
import 'package:uas_mobile_programming_32/models/user.dart';
import 'package:uas_mobile_programming_32/repository.dart';
import 'package:uas_mobile_programming_32/shared_prefs.dart';

class CustomerForm extends StatefulWidget {
  const CustomerForm({Key? key}) : super(key: key);

  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

enum Gender { laki, perempuan }

class _CustomerFormState extends State<CustomerForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _fileNameController = TextEditingController();
  final DateTime _selectedDate = DateTime.now();

  Gender? _gender = Gender.laki;
  SharedPref prefs = SharedPref();
  Repository repo = Repository();
  User user = User('', '', '', '', '', '', '', '', '');

  getPrefs() async {
    var obj = await prefs.read(User.obj);
    user = User.fromJson(obj);

    _nameController.text = user.name;
    _birthPlaceController.text = user.birthPlace;
    _birthDateController.text = user.birthDate;
    _addressController.text = user.address;
    _fileNameController.text = user.uploadedFile;
    setState(() {});
  }

  @override
  void initState() {
    getPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const screenPadding = EdgeInsets.symmetric(horizontal: 12, vertical: 12);
    const boxPadding = SizedBox(height: 12);

    return Scaffold(
        appBar: CAppBar('Edit Biodata'),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await repo.editData(
                user.id,
                jsonEncode({
                  'name': _nameController.text,
                  'birthPlace': _birthPlaceController.text,
                  'birthDate': _birthDateController.text,
                  'address': _addressController.text,
                  'uploadedFile': _fileNameController.text
                }));
          },
          child: Icon(Icons.check_rounded),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CTextField('Nama Lengkap', _nameController),
                  boxPadding,
                  Row(
                    children: [
                      Expanded(
                          child: CTextField(
                              'Tempat Lahir', _birthPlaceController)),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: CTextField('Tanggal Lahir', _birthDateController,
                            onTap: () async {
                          String date = await _selectDate(context);
                          debugPrint(date);
                          _birthDateController.text = date;
                        }),
                      ),
                    ],
                  ),
                  boxPadding,
                  boxPadding,
                  Text('Jenis Kelamin'),
                  RadioListTile(
                      title: Text('Laki-Laki'),
                      value: Gender.laki,
                      groupValue: _gender,
                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value;
                        });
                      }),
                  RadioListTile(
                      title: Text('Perempuan'),
                      value: Gender.perempuan,
                      groupValue: _gender,
                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value;
                        });
                      }),
                  boxPadding,
                  CTextField('Alamat Lengkap', _addressController),
                  boxPadding,
                  Row(
                    children: [
                      Expanded(
                          child: CTextField(
                        'Lampiran',
                        _fileNameController,
                      )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CButton('Upload', () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();

                          if (result != null) {
                            PlatformFile file = result.files.first;
                            _fileNameController.text = file.name;
                            // print(file.name);
                            // print(file.bytes);
                            // print(file.size);
                            // print(file.extension);
                            // print(file.path);
                          }
                        }),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future<String> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2023));
    if (picked != null && picked != _selectedDate) {
      return picked.year.toString() +
          '-' +
          picked.month.toString() +
          '-' +
          picked.day.toString();
    }
    return '';
  }
}
