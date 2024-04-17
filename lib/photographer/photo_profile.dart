import 'package:captura_lens/about_us.dart';
import 'package:captura_lens/forgot_password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../complaints_page.dart';
import '../help_page.dart';
import '../services/database.dart';
import '../support_page.dart';

class PhotoProfile extends StatefulWidget {
  bool isPhoto;

  PhotoProfile({super.key, required this.isPhoto});

  @override
  State<PhotoProfile> createState() => _PhotoProfileState();
}

class _PhotoProfileState extends State<PhotoProfile> {
  Stream? photoProfileStream;

  getOnTheLoad() async {
    photoProfileStream = await DataBaseMethods().getPhotographerDetails();
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }



  final List<Widget> _pages = <Widget>[
    const AboutUs(),
    const ForgotPassword(),
    const SupportPage(),
    const HelpPage(),
    const ComplaintsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey, border: Border.all(color: Colors.white)),
              child: Row(
                children: [
                  Container(
                    color: Colors.white,
                    width: 90,
                    height: 100,
                    child: Center(child: Text("Photo")),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email Address"),
                      SizedBox(height: 3,),
                      Text("Phone Number"),
                      SizedBox(height: 3,),
                      Text("Place"),
                    ],
                  ),
                  const Spacer(),
                  Expanded(
                    child: Column(
                      children: [
                        PopupMenuButton<int>(
                          onSelected: (int index) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    _pages[index], // Use the selected index
                              ),
                            );
                          },
                          itemBuilder: (BuildContext context) {
                            return List.generate(
                              _pages.length,
                              (index) => PopupMenuItem(
                                value: index, // Set the value to the index
                                child: Text(_pages[index].toString()),
                              ),
                            ).toList();
                          },
                        ),
                      ],
                    ),
                  )
                ],
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
                      child: const Center(child: Text("Post by Grapher")),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
