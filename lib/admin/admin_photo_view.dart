import 'package:captura_lens/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminPhotoView extends StatefulWidget {
  const AdminPhotoView({super.key});

  @override
  State<AdminPhotoView> createState() => _AdminPhotoViewState();
}

class _AdminPhotoViewState extends State<AdminPhotoView> {
  Stream? photoStream;

  getOnTheLoad()async{
    photoStream = await DataBaseMethods().getPhotographerDetails();
    setState(() {

    });
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  Widget allPhotographerDetails(){
    return StreamBuilder(
        stream: photoStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 5),
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 30,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ds["Email Address"],
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                ds["Phone Number"],
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                ds["Place"],
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                ds["Type of Photography"],
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white),
                            child: const Text(
                              "Accepted",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await DataBaseMethods()
                                  .rejectBooking(ds["id"]);
                            },
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white),
                            child: const Text(
                              "Remove",
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "View Photographers",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ],
              ),
            ),
            Expanded(child: allPhotographerDetails()),
          ],
        ),
      ),
    );
  }
}
