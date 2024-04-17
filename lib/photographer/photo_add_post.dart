import 'dart:io';
import 'dart:typed_data';

import 'package:captura_lens/photographer/photo_home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

import '../services/database.dart';

class PhotoAddPost extends StatefulWidget {

  const PhotoAddPost({super.key});

  @override
  State<PhotoAddPost> createState() => _PhotoAddPostState();
}

class _PhotoAddPostState extends State<PhotoAddPost> {
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
    Navigator.of(context).pop(); //Close the model-sheet
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

  File? imageFilePlace;

  final firebaseStorage = FirebaseStorage.instance;

  Future addPlaceImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    if (pickedFile != null) {
      final currentTime = TimeOfDay.now();
      imageFilePlace = File(pickedFile.path);
      UploadTask uploadTask = firebaseStorage
          .ref()
          .child("placeImage/Admin$currentTime")
          .putFile(imageFilePlace!, metadata);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Post"),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PhotoHome()));
          },
          icon: Icon(Icons.close),
        ),
        actions: [
          TextButton(
              onPressed: () {
                imageURL= addPlaceImage().toString();
                print(imageURL);
              },
              child: Text("Edit")),
          TextButton(
              onPressed: () async {
                String uniqueFileName =
                    DateTime.now().microsecondsSinceEpoch.toString();
                ImagePicker imagePicker = ImagePicker();
                await imagePicker
                    .pickImage(source: ImageSource.camera)
                    .then((value) {
                  print(File(value!.path));
                });
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImage = referenceRoot.child('images');
                Reference referenceImageToUpload = referenceDirImage.child(uniqueFileName);
                try{
                  await referenceImageToUpload.putFile(selectedImage!);
                  imageURL = await referenceImageToUpload.getDownloadURL();
                }catch(error){
                  print(error);
                }
                String id = randomAlphaNumeric(10);
                Map<String, dynamic> postInfoMap = {
                  "Image": imageURL,
                  "id": id
                };
                await DataBaseMethods()
                    .photoAddPost(postInfoMap, id)
                    .then((value) {
                  Fluttertoast.showToast(
                      msg: "Image Uploaded Successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 16.0);
                });
              },
              child: const Text("Next"))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey, border: Border.all(color: Colors.white)),
              child: const Center(child: Text("Selected Photo")),
            ),
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: const Center(child: Text("Photos")),
                  );
                }),
          )
        ],
      ),
    );
  }
}
