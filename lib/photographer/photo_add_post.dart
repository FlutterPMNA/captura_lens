import 'dart:io';

import 'package:captura_lens/photographer/photo_home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class PhotoAddPost extends StatefulWidget {
  const PhotoAddPost({super.key});

  @override
  State<PhotoAddPost> createState() => _PhotoAddPostState();
}

class _PhotoAddPostState extends State<PhotoAddPost> {
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
          TextButton(onPressed: () {}, child: Text("Edit")),
          TextButton(
              onPressed: () async {

                String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
                ImagePicker imagePicker = ImagePicker();
                    await imagePicker.pickImage(source: ImageSource.camera).then((value) {
                      print(File(value!.path));
                    });
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImage =  referenceRoot.child('images');
                    Reference referenceImageToUpload = referenceDirImage.child(uniqueFileName);


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
