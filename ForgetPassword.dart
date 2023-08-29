
import 'package:untitled14/SignUp.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var emailController = TextEditingController();

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

            SizedBox(
              height: 10,
            ),
            Container(
              width: 280,
              child: MaterialButton(

                onPressed: () async {
                  await FirebaseAuth.instance.sendPasswordResetEmail(
                      email: emailController.text)
                      .then((value) {

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()));
                  }).onError((error, stackTrace) {

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("unable to create a user"),
                    ));
                  });
                },
                child: Text(
                  "Get Email",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}