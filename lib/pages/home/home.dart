import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note/constants/app_style.dart';
import 'package:note/pages/add_new_note.dart';
import 'package:note/pages/detailes_note/detailes_note.dart';
import 'package:note/pages/home/widget/card.dart';

class HomeSreeen extends StatefulWidget {
  const HomeSreeen({Key? key}) : super(key: key);

  @override
  State<HomeSreeen> createState() => _HomeSreeenState();
}

class _HomeSreeenState extends State<HomeSreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewNote(),));
          }, label: const Text("Add Note"),
          icon: const Icon(Icons.add),
          ),
      backgroundColor: AppStyle.mainAppColor,
      // appBar: AppBar(
      //   title: const Text("Note"),
      //   backgroundColor: Colors.black12,
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              const Text(
                "Your Notes",
                style: TextStyle(
                    color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance.collection("notes").snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      return GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          children: snapshot.data!.docs
                              .map((note) => CardNote(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailesNote(doc: note,),));
                                    },
                                    doc: note,
                                  ))
                              .toList());
                    }
                    return const Center(
                      child: Text(
                        "ther's no notes",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
