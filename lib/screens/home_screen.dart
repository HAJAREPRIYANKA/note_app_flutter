import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/screens/add_note.dart';
import 'package:note_app/screens/menu_screen.dart';
import 'package:note_app/screens/view_note.dart';
import 'package:note_app/screens/menu_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('notes');

  List<Color> myColors = [
    Colors.yellowAccent,
    Colors.redAccent,
    Colors.lightGreenAccent,
    Colors.deepPurpleAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => AddNote(),
            ),
          )
              .then((value) {
            //calling setstate
            setState(() {});
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white70,
        ),
        backgroundColor: Colors.grey[700],
      ),
      appBar: AppBar(
        toolbarHeight: 100.0,
        flexibleSpace: SafeArea(
            child: Column(
          children: [
            Row(
              children: [
                FloatingActionButton(onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NavDrawer(),
                        ),
                        );
                  
                },
                 child: const Icon(
                    Icons.menu,
                    color: Colors.grey,
                  ),
                
                 backgroundColor: Colors.black87,
                ),

                 const SizedBox(
                  width: 30.0,
                ),

                  const Text("Notes",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: "lato",
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                    ),
              ],
            )
          ],
        )),
        elevation: 0.0,
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<QuerySnapshot>(
        // it will get data from reference named 'ref
        future: ref.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                Random random = new Random();
                Color bg = myColors[random.nextInt(4)];
                Map data = snapshot.data!.docs[index].data();
                DateTime mydateTime = data['created'].toDate();
                String formattedTime =
                    DateFormat.yMMMd().add_jm().format(mydateTime);
                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => ViewNote(data, formattedTime,
                            snapshot.data!.docs[index].reference),
                      ),
                    )
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: Card(
                    color: bg,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data['title']}",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "lato",
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              formattedTime,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "lato",
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("Loading..."),
            );
          }
        },
      ),
    );
  }
}
