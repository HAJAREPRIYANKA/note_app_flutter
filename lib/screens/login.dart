import 'package:flutter/material.dart';
import 'package:note_app/controller/google_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  "assets/images/cover.png",
                ),
              )),
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 12.0
            ),
          child: Text("Create and manage your notes",
          style: TextStyle(fontSize: 30.0, fontFamily: "lato", fontWeight: FontWeight.bold),
          ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0),
            child: ElevatedButton(
                onPressed: () {
                  signInWithGoogle(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   
                    Text("Continue with google",
                    style: TextStyle(fontSize: 15.0, fontFamily: "lato", fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                
                ),
          ),
              SizedBox(
                height: 15.0,
              )
        ],
      ),
    ));
  }
}
