import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_note/home_page.dart';
import 'package:firebase_note/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 15,
        children: [
          Text("Login"),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Email"
            ),
          ),
          TextField(
            controller: passController,
            decoration: InputDecoration(
              hintText: "Password"
            ),
          ),
          InkWell(
              onTap: (){
                var fpassword = FirebaseAuth.instance;
                
                fpassword.sendPasswordResetEmail(email: emailController.text).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Check you email",style: TextStyle(color: Colors.white),),backgroundColor: Colors.green));

                },).timeout(Duration(minutes:1));
              },
              child: Text("Forget password")),
          ElevatedButton(onPressed: (){
            var userLogin = FirebaseAuth.instance;
            userLogin.signInWithEmailAndPassword(email: emailController.text, password: passController.text).then((value) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
            },).onError((error, stackTrace) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString(),style: TextStyle(color: Colors.white),)));
            },);
          }, child: Text("Login")),
          TextButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) => RegisterPage(),));
          }, child: Text("new user"))
        ],
      ),
    );
  }
}
