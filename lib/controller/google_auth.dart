import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;

// Create storage or initialize flutter_secure_package
final storage = new FlutterSecureStorage();

// this is reference to user collection that we have
CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<void> signInWithGoogle(BuildContext context) async{

  try{
    // this gives us google signin account
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  if(googleSignInAccount != null){

    // after signin done we get googlesignin account and then we can call authentication which will give use one token and that token we can use to cvreate firebase user
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    // to authenticate google user & to get auth credential to create user (once we have these credentials we can signin a user)
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken!,
      idToken: googleSignInAuthentication.idToken!
    );

   

    // to signin user to firebase without google credentials which we get in above line 
    // it will return user credentials  we can get user from this auth result
    
    final UserCredential authResult = await auth.signInWithCredential(
     credential
    );

     Future<void> storeTokenAndData(UserCredential userCredential) async {
    // value parameter can take only strig so we have converted token into string from int
    // to store the token
    await storage.write(key: "token", value: userCredential.credential!.token.toString()); 
    // to store user credentials
     await storage.write(key: "userCredentials", value: userCredential.toString());   
  }
   

    
    storeTokenAndData(authResult);
    // we can get user from  auth result this creates user only in authentication pannel
    final User user = authResult.user!;

    // to save user data in databse
    var UserData = {
      'name': googleSignInAccount.displayName,
      'provider': 'google',
      'photoUrl': googleSignInAccount.photoUrl,
      'email': googleSignInAccount.email,
    };

    users.doc(user.uid).get().then((doc) {
      if(doc.exists){
        // old user , so only update the data
        doc.reference.update(UserData);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen(),
          ),
    );
      }else{
        // this is new user add data to UserData
        users.doc(user.uid).set(UserData);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen(),
          ),
        );
      }
    });
  }

  }catch(PlatformException){
    print(PlatformException);
    print("Sign in not successful !");
  }
  
   
}



