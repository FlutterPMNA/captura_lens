import 'package:captura_lens/admin/admin_event_post.dart';
import 'package:captura_lens/admin/admin_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../forgot_password.dart';
import '../constants.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: CupertinoColors.white,
        ),
        backgroundColor: CupertinoColors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: CupertinoColors.black,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30,),
                        Text('Go ahead and setup Your account', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        Text('Sign in-up to enjoy the best managing experience', style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: size.height * .8,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.mail_outline,
                          color: CustomColors.buttonGreen,
                        ),
                        hintText: 'Email Address',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20.0),
                  const TextField(
                    decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: CustomColors.buttonGreen,
                        ),
                        border: OutlineInputBorder()),
                    obscureText: true,
                  ),
                  Row(
                      children: [
                        Checkbox(
                            value: _isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            }),
                        const Text(
                          "Remember Me",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgotPassword()));
                            },
                            child: Text("Forgot Password?"))
                      ],
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          foregroundColor: Colors.white,
                          backgroundColor: CustomColors.buttonGreen),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AdminHome()));
                      },
                      child: Text('Login'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
