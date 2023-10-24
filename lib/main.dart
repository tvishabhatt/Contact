import 'package:contact/ContactListScreen.dart';
import 'package:contact/Screen1.dart';
import 'package:contact/Screen2.dart';



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AddContactScreen.dart';
import 'EditContactScreen.dart';


void main() async{
  // final provider=ContactListProvider();
  //  await  provider.loadBool();
  // SharedPreferences preferences = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => ContactListProvider(),),
        ChangeNotifierProvider(create: (context) => Steps() ,),
    ],
    child:const MyApp(),)
     );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeModal(),
      child: Consumer(
        builder: (context, ThemeModal themeNotifier, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            home:Screen1(),
            theme:themeNotifier .isDark?ThemeData.dark():ThemeData.light(),
            routes: {
              '/addContact': (context) => AddContactScreen(),
              '/editContact': (context) => EditContactScreen(index: 0,),
            },
          );
        },

      ),
    );
  }
}


class mainContact {
  String name;
  String phoneNumber;
  String lastname;

  mainContact(this.name, this.phoneNumber,this.lastname);
}
class ThemePreferances {
  static const  PREF_KEY = 'perf-key';
  setTheme(bool value) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(PREF_KEY, value);
  }
  getTheme() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return  sharedPreferences.getBool(PREF_KEY);

  }
}
class ThemeModal extends ChangeNotifier {
  bool _isDark = false;
  ThemePreferances _preferances = ThemePreferances();

  bool get isDark => _isDark;

  ThemeModal() {
    _isDark = false;
    _preferances = ThemePreferances();
    getPreferances();
  }

  getPreferances() async {
    _isDark = await _preferances.getTheme();
    notifyListeners();
  }

  set isDark(bool value) {
    _isDark = value;
    _preferances.setTheme(value);
    notifyListeners();
  }
}