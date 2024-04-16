import 'package:captura_lens/user/user_categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserHomeDetails extends StatefulWidget {
  const UserHomeDetails({super.key});

  @override
  State<UserHomeDetails> createState() => _UserHomeDetailsState();
}

class _UserHomeDetailsState extends State<UserHomeDetails> {

  // SearchController _searchController = SearchController();
  TextEditingController _searchController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIcon:Icon(Icons.search, color: CupertinoColors.black,) ,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Search",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.grey,),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UserCategories()));
                        },
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey,
                          ),
                          child: const Center(
                              child: Text(
                            "Category",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          height: 300,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey)),
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.grey,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "User Name",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      border: Border.all(color: Colors.white)),
                                  child: const Center(child: Text("Photo")),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(CupertinoIcons.heart_fill)),
                                  IconButton(
                                      onPressed: () {},
                                      icon:
                                          const Icon(CupertinoIcons.chat_bubble)),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(CupertinoIcons.paperplane)),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(CupertinoIcons.bookmark))
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
