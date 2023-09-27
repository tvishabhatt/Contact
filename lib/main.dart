import 'package:contact/ContactListScreen.dart';



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AddContactScreen.dart';
import 'EditContactScreen.dart';


void main() {

  runApp(
    MultiProvider(providers: [
        ChangeNotifierProvider(
        create: (context) => ContactListProvider(),)
    ],
    child:const MyApp(),)
     );
}
bool b=true;
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
      home:ContactListScreen(),
      routes: {
        '/addContact': (context) => AddContactScreen(),
        '/editContact': (context) => EditContactScreen(index: 0,),
      },
    );
  }
}


class mainContact {
  String name;
  String phoneNumber;
  String lastname;

  mainContact(this.name, this.phoneNumber,this.lastname);
}