import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_note/home_page.dart';
import 'package:firebase_note/login_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController firstnameController = TextEditingController();

  TextEditingController lastnameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  registerUser()async{
    final userRegister = FirebaseAuth.instance;

    userRegister.createUserWithEmailAndPassword(email: emailController.text, password: passController.text).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Register Done",style: TextStyle(color: Colors.white),),backgroundColor: Colors.green));
      
    },).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$error",style: TextStyle(color: Colors.white),),backgroundColor: Colors.red));

    },);
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 15,
        children: [
          Text("Register"),
          SizedBox(height: 10,),
          TextField(
            controller: firstnameController,
            decoration: InputDecoration(
              hintText: "First Name"
            ),
          ),
          TextField(
            controller: lastnameController,
            decoration: InputDecoration(
              hintText: "Last Name"
            ),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Email"
            ),
          ),
          TextField(
            controller: passController,
            decoration: InputDecoration(
              hintText: "password"
            ),
          ),
          ElevatedButton(onPressed: (){
          registerUser();

          }, child: Text("Register"))
        ],
      ),
    );
  }
}
