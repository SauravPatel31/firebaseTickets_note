import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_note/app_const.dart';
import 'package:firebase_note/note_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomesPage extends StatefulWidget {
  @override
  State<HomesPage> createState() => _HomePageState();
}

class _HomePageState extends State<HomesPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? uid;
  Future<QuerySnapshot<Map<String, dynamic>>>? collectionData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    SharedPreferences prefe = await SharedPreferences.getInstance();
    uid = prefe.getString(AppConst.USER_ID_KEY);

    if (uid != null) {
      setState(() {
        collectionData = firestore.collection("Users").doc(uid).collection("Notess").get();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: collectionData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (snapshot.hasData) {
            return snapshot.data!.docs.isNotEmpty
                ? ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index].data();
                var eachNote = NoteModel.fromMap(data);
                return ListTile(
                  title: Text(data['title']),
                  subtitle: Text(eachNote.description ?? ""),
                );
              },
            )
                : Center(child: Text("No Notes Yet"));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var createTime = DateTime.now().millisecondsSinceEpoch;
          if (uid == null) {
            SharedPreferences prefe = await SharedPreferences.getInstance();
            uid = prefe.getString(AppConst.USER_ID_KEY);
          }

          if (uid != null) {
            await firestore
                .collection("Users")
                .doc(uid)
                .collection("Notess")
                .doc(createTime.toString())
                .set(NoteModel(
                title: "Note Title",
                description: "Note description",
                createAt: createTime.toString())
                .toMap())
                .then((value) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Data is Added")));
            });

            // Refresh Data
            fetchUserData();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
