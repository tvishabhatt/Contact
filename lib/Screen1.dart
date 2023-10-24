import 'dart:async';

import 'package:contact/Screen2.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ContactListScreen.dart';

class Screen1 extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Screen1State();
  }

}
class Screen1State extends State<Screen1>
{
  static const String KEYLOGIN="Login";
  static const String KEYAUTH="auth";
  final LocalAuthentication localAuth = LocalAuthentication();

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    wheretigo();
    authenticate();
  }
  Future<bool> authenticate() async {
    final contactprovider=Provider.of<ContactListProvider>(context,listen: false);
    final bool canAuthenticateWithBiometrics = await localAuth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await localAuth.isDeviceSupported();
     return contactprovider.isswi?await localAuth.authenticate(localizedReason: ''):false;
    if (canAuthenticate) {
      bool result = await localAuth.authenticate(localizedReason: 'check');
    }

    if (!canAuthenticate) {
      // Handle authentication failure, e.g., show a message and exit the app
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Authentication Failed'),
            content: Text('Authentication is required to access the app.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                },
                child: Text('OK'),

              ),
            ],
          );
        },
      );
    }
  }
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Icon(Icons.contacts,color: Colors.black,size: 80,),
          ),
          Center(child: Padding(padding: EdgeInsets.only(top: 50,),
              child:Text("Contact app",style: TextStyle(color: Colors.black,fontSize: 23),) ,) ),
        ],
      ),
    );
  }
void wheretigo()async
{
  var Prefs=await SharedPreferences.getInstance();
  var isloggedIn = Prefs.getBool(KEYLOGIN);

  Timer(Duration(seconds: 3), () {
    if(isloggedIn!=null)
    {
      if(isloggedIn)
      {
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>ContactListScreen()),);

      }
      else{
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>Screen2()),);
      }
    }
    else{
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>Screen2()),);
    }
  });



}


}