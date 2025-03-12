import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'login_page.dart';

class Auth extends ChangeNotifier{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading=false;
  userRegister({required String  fName,required String lName,required String email,required String pass,required context })async{
   try{
     isLoading=true;
     notifyListeners();
     if(fName.isNotEmpty&&lName.isNotEmpty&&email.isNotEmpty&&pass.isNotEmpty){

     UserCredential userCred =  await auth.createUserWithEmailAndPassword(email: email, password: pass);

     firestore.collection("Users").doc(userCred.user!.uid).set({
       "fname":fName,
       "lname":lName,
       "email":email,
       "password":pass
     });
     if(userCred.user!=null){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>LoginPage (),));
     }

     }
     notifyListeners();
   }catch(e){}
    finally{
     isLoading=false;
     notifyListeners();
    }
  }
}
