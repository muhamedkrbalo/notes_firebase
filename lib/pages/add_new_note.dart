import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note/constants/app_style.dart';


class AddNewNote extends StatefulWidget {
  const AddNewNote({Key? key}) : super(key: key);

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _mainController = TextEditingController();
  String date = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: ()async{
        FirebaseFirestore.instance.collection("notes").add({
 "notes_titel":_titleController.text,
 "create_date":date,
 "notes_content":_mainController.text,
  
}).then((value){
 print(value.id);
 Navigator.pop(context);
}).catchError(
   (error)=>print("Failed to add new Note due to$error"));
      },
      backgroundColor: AppStyle.accentColor,
      child:const Icon(Icons.save)
      ),
      
      
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Add a new titel",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Date"),
                Text(date),
                
              ],
            ),
            const SizedBox(
              height: 28.0,
            ),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title',
              ), // Input Decoration
            ), // TextField
            const SizedBox(
              height: 8.0,
            ),
            
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                
                border: InputBorder.none,
                hintText: 'Note Content',
              ), // Input Decoration
            ), // Te
          ],
        ),
      ),
    );
  }
}
