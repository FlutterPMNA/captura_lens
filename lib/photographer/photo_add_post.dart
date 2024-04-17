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
  }

  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
  }

  File? imageFilePlace;

  final firebaseStorage = FirebaseStorage.instance;
  String uniqueImageName = DateTime.now().microsecondsSinceEpoch.toString();
  DataBaseMethods methods = DataBaseMethods();

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
                _pickImageFromGallery();
              },
              child: const Text("Gallery")),
          TextButton(
              onPressed: () async {
                Reference referenceDirImage = methods.reference.child('images');
                Reference referenceImageToUpload =
                    referenceDirImage.child(uniqueImageName);
                try {
                  await referenceImageToUpload.putFile(selectedImage!);
                  imageURL = await referenceImageToUpload.getDownloadURL();
                } catch (error) {
                  print(error);
                }
                String id = randomAlphaNumeric(10);
                Map<String, dynamic> photoPostInfo = {
                  "Image": imageURL,
                  "id": id
                };
                await DataBaseMethods()
                    .photoPost(photoPostInfo, id)
                    .then((value) {
                  Fluttertoast.showToast(
                      msg: "Data Photo Successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 16.0);
                });
              },
              child: const Text("Camera"))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
              height: 300,
              child: _image != null
                  ? Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(image: MemoryImage(_image!))),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(color: Colors.white)),
                      child: const Center(child: Text("Selected Photo")),
                    )),
          Expanded(
            child: Container(
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Brightness",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 8),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.sunny,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Contrast",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 8),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    CupertinoIcons.circle_righthalf_fill,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Structure",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 8),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    CupertinoIcons.triangle,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Warmth",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 8),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    CupertinoIcons.thermometer,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Shadows",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 8),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.wb_shade,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Color",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 8),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    CupertinoIcons.color_filter,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Saturation",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 8),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.water_drop,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Fade",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 8),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.cloud_outlined,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          Reference referenceDirImage =
          methods.reference.child('images');
          Reference referenceImageToUpload =
          referenceDirImage.child(uniqueImageName);
          try{
            await referenceImageToUpload.putFile(selectedImage!);
            imageURL = await referenceImageToUpload.getDownloadURL();
          }catch(error){
            print(error);
          }
          String id = randomAlphaNumeric(10);
          Map<String, dynamic> competitionInfoMap = {
            "Image": imageURL,
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
        },
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
        child: Text("Done"),
      ),
    );
  }
}
