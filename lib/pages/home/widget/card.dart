import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardNote extends StatelessWidget {
  Function()? onTap;
  QueryDocumentSnapshot? doc;
   CardNote({Key? key,this.onTap,  this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(8.0)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(doc!['create_date'],),
            const SizedBox(
              height: 10,
            ),
            Text(doc!['notes_titel'],),
            const SizedBox(
              height: 4,
            ),
           
            Text(doc!['notes_content'],overflow: TextOverflow.ellipsis,),
          ],
        ),
      ),


    );
  }
}