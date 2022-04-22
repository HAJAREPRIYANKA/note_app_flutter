import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget{
  @override 

  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
     padding: EdgeInsets.zero,
     children: <Widget>[
       DrawerHeader( 
          child: Text(
              'Hello XYZ !',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
       ),
       ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),

            ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),

           ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
     ],   
      ),
    );
  }
}