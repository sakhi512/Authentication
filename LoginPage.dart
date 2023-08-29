import 'main.dart';
import 'package:untitled14/ForgetPassword.dart';
import 'package:untitled14/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:untitled14/HomePage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'main.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final gSignIn = GoogleSignIn();
  var auth=FirebaseAuth.instance;
  //var auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://cdn.pixabay.com/photo/2016/08/15/01/29/instagram-1594387_960_720.png'),
                    ),
                  ),
                ),
              ),
              Container(
                width: 300,
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Phone number,username,or email",
                      labelStyle: TextStyle(fontSize: 12),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff353b48)),
                          borderRadius: BorderRadius.circular(5)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff353b48)),
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Container(
                width: 300,
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff353b48)),
                        borderRadius: BorderRadius.circular(5)),
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 12),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff353b48)),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 280,
                child: MaterialButton(

                  onPressed: () async {
                    setState((){

                    });

                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text, password: passwordController.text)
                        .then((value) {
                      setState((){

                      });

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage()));
                    }).onError((error, stackTrace) {

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Invalid Email or Password"),
                      ));
                    });
                  },
                  child: Text(
                    "Signin",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(
                height: 10,
              ),

              ElevatedButton(onPressed: () async {
                final GoogleSignInAccount? googleSignInAccount =
                await gSignIn.signIn();
                if (googleSignInAccount != null) {
                  final GoogleSignInAuthentication
                  googleSignInAuthentication =
                  await googleSignInAccount.authentication;
                  final AuthCredential authCredential =
                  GoogleAuthProvider.credential(
                      accessToken:
                      googleSignInAuthentication.accessToken,
                      idToken:
                      googleSignInAuthentication.idToken);
                  await auth.signInWithCredential(authCredential);
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage()));
              }, child: Text("Sign in using gmail"),),
              ElevatedButton(onPressed: () async{


              }, child: Text("upload image")),

              SizedBox(
                height: 10,
              ),



              MaterialButton(
                  child: Text("Forgot Password"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassword()));
                  })
            ],
          ),
        ),
    );
  }
}