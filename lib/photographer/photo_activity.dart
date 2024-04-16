import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoActivity extends StatefulWidget {
  const PhotoActivity({super.key});

  @override
  State<PhotoActivity> createState() => _PhotoActivityState();
}

class _PhotoActivityState extends State<PhotoActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Booking",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ],
            ),
            Expanded(child: ListView.builder(itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(backgroundColor: Colors.grey, radius: 30,),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "5465646",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Details",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Time Duration",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white),
                            child: const Text(
                              "Accept",
                              style: TextStyle(color: Colors.black),
                            ),),
                        ElevatedButton(
                            onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white),
                            child: const Text(
                              "Reject",
                              style: TextStyle(color: Colors.black),
                            ),)
                      ],
                    )
                  ],
                ),
              );
            }))
          ],
        ),
      ),
    );
  }
}
