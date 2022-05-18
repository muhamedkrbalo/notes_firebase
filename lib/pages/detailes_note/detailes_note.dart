import 'dart:core';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note/constants/app_style.dart';
import 'package:share_plus/share_plus.dart';

class DetailesNote extends StatefulWidget {
  QueryDocumentSnapshot? doc;
  DetailesNote({Key? key,this.doc}) : super(key: key);

  @override
  State<DetailesNote> createState() => _DetailesNoteState();
}

class _DetailesNoteState extends State<DetailesNote> {
 String date = DateTime.now().toString();

 
 // 2016-01-25
  String? titel;
  String? content;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: FloatingActionButton(onPressed: ()async{
        FirebaseFirestore.instance.collection("notes").doc(widget.doc!.id).update({
 "notes_titel":titel ?? widget.doc!['notes_titel'],
 "create_date":date,
 "notes_content":content?? widget.doc!['notes_content']
  
}).then((value){

 Navigator.pop(context);
}).catchError(
   (error)=>print("Failed to add new Note due to$error"));
      },
      backgroundColor: AppStyle.accentColor,
      child:const Icon(Icons.save)
      ),
    
      appBar: AppBar( 
        actions:  [
          IconButton(onPressed: (){
            Share.share( widget.doc!['notes_content']);
          }, icon: const Icon(Icons.share),color: Colors.white,)
        ],
        backgroundColor: Colors.black,),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: Column(
            
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             
                 Text(widget.doc!['create_date'],),
                const SizedBox(
                  height: 28,
                ),
                  
            TextFormField(
              initialValue:widget.doc!['notes_titel'],
              onChanged: (titelName){
                titel=titelName;
              },
              decoration: const InputDecoration(

                border:  InputBorder.none,
                
                
              ),

            ),

              // Text(widget.doc!['notes_titel'],style: const TextStyle(color: Colors.white),),
                const SizedBox(
                  height: 4,
                ),
               
                  TextFormField(
              initialValue:widget.doc!['notes_content'],
              onChanged: (contentName){
                content=contentName;
              },
              decoration: const InputDecoration(

                border:  InputBorder.none,
                
                
              ),

            ),
           //     Text(widget.doc!['notes_content'],style: const TextStyle(color: Colors.white),),
              ],
            ),
        ),
      ),
    );
  }
}