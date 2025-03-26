import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_note/app_const.dart';
import 'package:firebase_note/note_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firestore =FirebaseFirestore.instance;
  String? uid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Future<QuerySnapshot<Map<String,dynamic>>> collectionData = firestore.collection("Users").doc(uid).collection("Notess").get();
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String,dynamic>>>(future: collectionData,
        builder: (context, snapshot) {

        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        if(snapshot.hasError){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${snapshot.error}")));
        }
        if(snapshot.hasData){
          return snapshot.data!.docs.isNotEmpty?ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index].data();
              var eachNote = NoteModel.fromMap(snapshot.data!.docs[index].data());
            return ListTile(
              title: Text(data['title']),
              subtitle: Text(eachNote.description.toString()),
            );
          },):Center(child: Text("No Notes Yet"),);
        }
        return Container();

      },),
      floatingActionButton: FloatingActionButton(onPressed: () async{
        var createaTime = DateTime.now().millisecondsSinceEpoch;
        SharedPreferences prefe =await SharedPreferences.getInstance();
        uid=prefe.getString(AppConst.USER_ID_KEY);
       await firestore.collection("Users").doc(uid).collection("Notess").doc(createaTime.toString()).set(NoteModel(title: "Note Title",description: "Note description",createAt: createaTime.toString()).toMap()).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data is Add")));
        },);
       setState(() {});
      },child: Icon(Icons.add),),
    );
  }
}
