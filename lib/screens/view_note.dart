import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewNote extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  ViewNote(this.data, this.time, this.ref);
  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  late String title;
  late String des;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.grey[700]),
                             padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 8.0,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: delete,
                     child: Icon(Icons.delete_forever),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red[300]),
                             padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 8.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // to display title
                    Text(
                     "${widget.data['title']}",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: "lato",
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      
                    ),

                    // to display date and time
                       Padding(
                         padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                         child: Text(
                     widget.time,
                      style: TextStyle(
                          fontSize: 24.0,
                          fontFamily: "lato",
                          color: Colors.grey,
                      ),
                      
                    ),
                       ),

                    // textfield for notes description.
                    Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      alignment: Alignment.topLeft,
                      child: Text(
                        "${widget.data['description']}",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                       
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void delete() async {
    // delete from db
    await widget.ref.delete();
    Navigator.pop(context);
  }
}
