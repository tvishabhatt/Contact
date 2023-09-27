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
  final LocalAuthentication localAuth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    Provider.of<ContactListProvider>(context, listen: false).loadContacts();
  if(b==true)
    {
      authenticate();
    }
  }

  Future<void> authenticate() async {

       final bool canAuthenticateWithBiometrics = await localAuth.canCheckBiometrics;
       final bool canAuthenticate =
           canAuthenticateWithBiometrics || await localAuth.isDeviceSupported();
       if (canAuthenticate) {
         await localAuth.authenticate(localizedReason: 'check');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Contcts', style: TextStyle(color: Colors.white, fontSize: 20),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder:(context) => Settings(), ));
          }, icon: Icon(Icons.settings,color: Colors.white,)),
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
                title: Text("${contact.name}  ${contact.lastname}"),
                subtitle: Text(contact.phoneNumber),
                leading: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(Icons.person,color: Colors.grey,size: 20,),
                ),
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: TextButton.icon(
                        label: Text('Edit',style: TextStyle(color: Colors.black),),
                        icon: Icon(Icons.edit,color: Colors.black,),
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
                            provider.updateContact(index, editedContact as mainContact);
                          }
                        },
                      ),
                    ),
                    PopupMenuItem(
                      child: TextButton.icon(
                        label: Text('Delete',style: TextStyle(color: Colors.black),),
                        icon: Icon(Icons.delete,color: Colors.black,),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Delete Contact'),
                                content: Text('Are you sure you want to delete this contact?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      provider.deleteContact(index);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Delete'),
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
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () {
          Navigator.pushNamed(context, '/addContact').then((newContact) {
            if (newContact != null) {
              Provider.of<ContactListProvider>(context, listen: false).addContact(newContact as mainContact);
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ContactListProvider extends ChangeNotifier {
  List<mainContact> contacts = [];

  void loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final contactsData = prefs.getStringList('contacts');

    if (contactsData != null) {
      contacts = contactsData.map((data) {
        final parts = data.split(',');
        return mainContact(parts[0], parts[1],parts[2]);
      }).toList();
      notifyListeners();
    }
  }

  void addContact(mainContact newContact) {
    contacts.add(newContact);
    saveContacts();
    notifyListeners();
  }

  void updateContact(int index, mainContact updatedContact) {
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
  void auth ()async
  {
    b=!b;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', b);
    prefs.getBool('auth');

  }
}