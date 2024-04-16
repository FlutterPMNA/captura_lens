import 'package:captura_lens/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../photographer/photo_event_details.dart';

class AdminHomeDetails extends StatefulWidget {
  const AdminHomeDetails({super.key});

  @override
  State<AdminHomeDetails> createState() => _AdminHomeDetailsState();
}

class _AdminHomeDetailsState extends State<AdminHomeDetails> {

  Stream? CompetitionStream;
  getOnTheLoad() async {
    CompetitionStream = await DataBaseMethods().getCompetitionDetails();
    setState(() {

    });
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }


  Widget allCompetitionDetails() {
    return StreamBuilder(
        stream: CompetitionStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasError?  Text(snapshot.error.toString()):
           snapshot.hasData
              ? ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Container(
                  height: 130,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey)),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          children: [
                            Container(
                              color: Colors.grey,
                              width: 50,
                              height: 70,
                              child: Center(child: Text("Photo")),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Paid/Unpaid",
                              style: TextStyle(fontSize: 8),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              ds["Title"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              ds["Prize and Description"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              ds["Deadline"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              ds["Place"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
                        )
              : Container(color: Colors.grey,height: 400,width: 300,);
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(CupertinoIcons.search),
                      hintText: "Search",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            child:Expanded(child:allCompetitionDetails() ,) ,
          ),
        ],
      ),
    );
  }
}
