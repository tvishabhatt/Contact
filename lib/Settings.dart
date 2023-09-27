import 'package:contact/ContactListScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ContactListScreen.dart';
import 'ContactListScreen.dart';
import 'main.dart';

class Settings extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SettingsState();
  }

}
class SettingsState extends State<Settings>
{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final c=Provider.of<ContactListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Settings', style: TextStyle(color: Colors.white, fontSize: 20),),
        centerTitle: true,

      ),
      body: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Authentication"),
          Consumer(
            builder: (context, ContactListProvider, child){
              return   Switch(value: b, onChanged: (value) {
                c.auth();

              },);
            },

          )
        ],
      ),
    );
  }

}
