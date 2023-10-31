import 'package:contact/Screen2.dart';
import 'package:contact/Settings.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'EditContactScreen.dart';
import 'main.dart';
class ContactListScreen extends StatefulWidget {
  @override
  ContactListScreenState createState() => ContactListScreenState();
}

class ContactListScreenState extends State<ContactListScreen> {


  @override
  void initState() {
    super.initState();
    Provider.of<ContactListProvider>(context, listen: false).loadContacts();
    Provider.of<Steps>(context,listen: false).savedata();
  }
  @override
  Widget build(BuildContext context) {

    return Consumer(
      builder: (context, ThemeModal themeNotifiter, child) {
        return Scaffold(

          appBar: AppBar(
            backgroundColor: themeNotifiter.isDark?Colors.black:Colors.white,
            title: Text(
              'Contcts', style: TextStyle(color: themeNotifiter.isDark?Colors.white:Colors.black, fontSize: 20),),
            centerTitle: true,
            actions: [
              IconButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder:(context) => Settings(), ));
              }, icon: Icon(Icons.settings,color: themeNotifiter.isDark?Colors.white:Colors.black,)),
            ],
          ),

          body: Consumer<ContactListProvider>(
            builder: (context, provider, child) {
              final contacts = provider.contacts;
              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return ListTile(
                    title: Text("${contact.name}  ${contact.lastname}",style: TextStyle(color: themeNotifiter.isDark? Colors.white:Colors.black)),
                    subtitle: Text(contact.phoneNumber,style: TextStyle(color: themeNotifiter.isDark? Colors.white:Colors.black)),
                    leading: CircleAvatar(
                      backgroundColor: themeNotifiter.isDark?Colors.white:Colors.black,
                      child: Icon(Icons.person,color: Colors.grey,size: 20,),
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: TextButton.icon(
                            label: Text('Edit',style: TextStyle(color: themeNotifiter.isDark? Colors.white:Colors.black)),
                            icon: Icon(Icons.edit,color: themeNotifiter.isDark?Colors.white:Colors.black,),
                            onPressed: () async {
                              final editedContact = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditContactScreen(index: index),
                                  settings: RouteSettings(
                                    arguments: contact,
                                  ),
                                ),
                              );
                              if (editedContact != null) {
                                provider.updateContact(index, editedContact as MainContact);
                              }
                            },
                          ),
                        ),
                        PopupMenuItem(
                          child: TextButton.icon(
                            label: Text('Delete',style: TextStyle(color: themeNotifiter.isDark? Colors.white:Colors.black),),
                            icon: Icon(Icons.delete,color: themeNotifiter.isDark?Colors.white:Colors.black,),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(

                                    title: Text('Delete Contact',style: TextStyle(color: themeNotifiter.isDark? Colors.white:Colors.black),),
                                    content: Text('Are you sure you want to delete this contact?',style: TextStyle(color: themeNotifiter.isDark? Colors.white:Colors.black)),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancel',style: TextStyle(color: themeNotifiter.isDark? Colors.white:Colors.black)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          provider.deleteContact(index);
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Delete',style: TextStyle(color: themeNotifiter.isDark? Colors.white:Colors.black)),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: themeNotifiter.isDark?Colors.white:Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: () {
              Navigator.pushNamed(context, '/addContact').then((newContact) {
                if (newContact != null) {
                  Provider.of<ContactListProvider>(context, listen: false).addContact(newContact as MainContact);
                }
              });
            },
            child: Icon(Icons.add,color: themeNotifiter.isDark?Colors.black:Colors.white,),
          ),
        );
      },

    );
  }
}

class ContactListProvider extends ChangeNotifier {
  List<MainContact> contacts = [];
  bool _swi=false;
  bool get isswi =>_swi;

  void loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final contactsData = prefs.getStringList('contacts');

    if (contactsData != null) {
      contacts = contactsData.map((data) {
        final parts = data.split(',');
        return MainContact(parts[0], parts[1],parts[2]);
      }).toList();
      notifyListeners();
    }
  }
  void addContact(MainContact newContact) {
    contacts.add(newContact);
    saveContacts();
    notifyListeners();
  }
  void updateContact(int index, MainContact updatedContact) {
    contacts[index] = updatedContact;
    saveContacts();
    notifyListeners();
  }
  void deleteContact(int index) {
    contacts.removeAt(index);
    saveContacts();
    notifyListeners();
  }
  void saveContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final contactsData = contacts.map((contact) {
      return '${contact.name},${contact.phoneNumber},${contact.lastname}';
    }).toList();
    prefs.setStringList('contacts', contactsData);
  }
  Future saveboolvalue(bool value)async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setBool("isSwitchOn", value);}
  Future toggleSwitchValue()async{
    _swi=!_swi;
    notifyListeners();
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setBool("isswi", _swi);
  }
  // loadBool() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   swi = preferences.getBool('isChecked')!;
  //   notifyListeners();
  // }
  // saveBool() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   await preferences.setBool('isChecked', swi);
  //   print(swi);
  //   notifyListeners();
  // }
}