import 'package:contact/ContactListScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    final provider=Provider.of<ContactListProvider>(context);
    final d = MediaQuery.of(context).platformBrightness;
    return Consumer(
      builder:(context, ThemeModal themeNotifiter, child){
        return Scaffold(

          appBar: AppBar(
            backgroundColor: themeNotifiter.isDark?Colors.black:Colors.white,
            title: Text(
              'Settings', style: TextStyle(color: themeNotifiter.isDark?Colors.white:Colors.black, fontSize: 20),),
            centerTitle: true,

          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Authentication",style: TextStyle(color: Colors.black,fontSize: 18),),
                    Consumer(
                      builder: (context, ContactListProvider, child){
                        return   Switch(
                          value:provider.isswi,
                          onChanged: (value){
                            provider.toggleSwitchValue();
                            },);},
                    )],),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (themeNotifiter.isDark) {

                      } else {
                        themeNotifiter.isDark = true;
                      }
                      print(d);
                    });
                  },
                  child: Container(
                    height: 60,
                    width: 380,
                    color:Colors.grey,
                    child: Center(child: Text("Dark Mode", style: TextStyle(
                        color: Colors.black, fontSize: 20),)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (themeNotifiter.isDark) {
                        themeNotifiter.isDark = false;
                      }
                    });
                  },
                  child: Container(
                    height: 60,
                    width: 380,
                    color: Colors.grey,
                    child: Center(
                        child: Text("Light Mode", style: TextStyle(
                            color: Colors.black, fontSize: 20),)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (d == Brightness.light) {
                        themeNotifiter.isDark = false;
                      }
                      else {
                        themeNotifiter.isDark = true;
                      }
                    });
                  },
                  child: Container(
                    height: 60,
                    width: 380,
                    color: Colors.grey,
                    child: Center(
                        child: Text("Device Mode", style: TextStyle(
                            color: Colors.black, fontSize: 20),)),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }


}
