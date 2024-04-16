import 'package:captura_lens/about_us.dart';
import 'package:captura_lens/change_password.dart';
import 'package:captura_lens/complaints_page.dart';
import 'package:captura_lens/help_page.dart';
import 'package:captura_lens/support_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 250,
            color: Colors.grey,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(backgroundColor: Colors.white, radius: 35,),
                      Text("User Name"),
                    ],
                  ),
                ],
              )
          ),
          Container(
            color: Colors.black,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => AboutUs()));
                        },
                        child: const Text("About Us")),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SupportPage()));
                        },
                        child: const Text("Support")),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => HelpPage()));
                        },
                        child: const Text("Help")),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ChangePassword()));
                        },
                        child: const Text("Change Password")),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ComplaintsPage()));
                        },
                        child: const Text("Complains")),
                    ElevatedButton(
                        onPressed: () {},
                        child: const Row(
                          children: [Icon(Icons.logout), Text("Log Out")],
                        ))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
