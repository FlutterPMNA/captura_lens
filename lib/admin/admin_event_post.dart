import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:captura_lens/constants.dart';
import 'package:captura_lens/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AdminEventPost extends StatefulWidget {
  const AdminEventPost({super.key});

  @override
  State<AdminEventPost> createState() => _AdminEventPostState();
}

class _AdminEventPostState extends State<AdminEventPost> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController prizeController = TextEditingController();
  TextEditingController placeController = TextEditingController();

  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime(2021, 7, 25);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2022),
    );
    if (newSelectedDate != null) {
      setState(() {
        dateController.text = newSelectedDate.toString().split(" ")[0];
      });
    }
  }

  void showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.lightBlueAccent,
        context: context,
        builder: (builder) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      _pickImageFromGallery();
                    },
                    icon: Icon(
                      Icons.image,
                      size: 50,
                    )),
                IconButton(
                    onPressed: () {
                      _pickImageFromCamera();
                    },
                    icon: Icon(
                      CupertinoIcons.camera,
                      size: 50,
                    ))
              ],
            ),
          );
        });
  }

  Uint8List? _image;
  File? selectedImage;
  String imageURL = '';

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }

  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }

  String uniqueImageName = DateTime.now().microsecondsSinceEpoch.toString();

  DataBaseMethods methods = DataBaseMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                Container(
                  width: 350,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black, // Border color
                      width: 1, // Border width
                      style: BorderStyle.solid, // Dotted border style
                    ),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: _image != null
                      ? Container(
                          decoration: BoxDecoration(
                              image:
                                  DecorationImage(image: MemoryImage(_image!))),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Drop your image here"),
                            const SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple),
                                onPressed: () {
                                  showImagePickerOptions(context);
                                },
                                child: const Text(
                                  "Upload Files",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ))
                          ],
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: titleController,
                  validator: (title){
                    if (title== null || title.isEmpty){
                      return 'Please enter a Title';
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: dateController,
                  validator: (date){
                    if (date== null || date.isEmpty){
                      return 'Please enter a Deadline';
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Deadline in YYYY-MM-DD',
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      suffixIcon: IconButton(
                          onPressed: () => _selectDate(context),
                          icon: const Icon(
                            CupertinoIcons.calendar,
                            color: CustomColors.buttonGreen,
                          ))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: prizeController,
                  validator: (prize){
                    if (prize== null || prize.isEmpty){
                      return 'Please enter Prize and description';
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Prize and Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: placeController,
                  validator: (place){
                    if (place== null || place.isEmpty){
                      return 'Specify the place';
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Place of contest Conducted',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      Reference referenceDirImage =
                      methods.reference.child('images');
                      Reference referenceImageToUpload =
                      referenceDirImage.child(uniqueImageName);
                      try{
                        await referenceImageToUpload.putFile(selectedImage!);
                        imageURL = await referenceImageToUpload.getDownloadURL();
                      }catch(error){
                        log(error as num);
                      }
                      String id = randomAlphaNumeric(10);
                      Map<String, dynamic> competitionInfoMap = {
                        "Image": imageURL,
                        "Title": titleController.text,
                        "Deadline": dateController.text,
                        "Prize and Description": prizeController.text,
                        "Place": placeController.text,
                        "id": id
                      };
                      await DataBaseMethods()
                          .addAdminCompetition(competitionInfoMap, id)
                          .then((value) {
                        Fluttertoast.showToast(
                            msg: "Data Uploaded Successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.buttonGreen,
                      foregroundColor: Colors.white),
                  child: const Text("Upload"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
