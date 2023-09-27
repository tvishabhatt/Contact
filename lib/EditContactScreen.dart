import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'ContactListScreen.dart';
import 'main.dart';
class EditContactScreen extends StatefulWidget {
  final int index;

  EditContactScreen({required this.index});

  @override
  _EditContactScreenState createState() => _EditContactScreenState(index: index);
}

class _EditContactScreenState extends State<EditContactScreen> {
  late TextEditingController nameController;
  late TextEditingController lastnameController;
  late TextEditingController phoneNumberController;
  final int index;

  _EditContactScreenState({required this.index});

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneNumberController = TextEditingController();
    lastnameController=TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final contact = ModalRoute.of(context)!.settings.arguments as mainContact;

    // Initialize the text controllers with the contact's information.
    nameController.text = contact.name;
    lastnameController.text = contact.lastname;
    phoneNumberController.text = contact.phoneNumber;

    return Scaffold(
     appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Edit Contcts', style: TextStyle(color: Colors.white, fontSize: 20),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(keyboardType: TextInputType.name,
                controller: nameController,
                decoration: const InputDecoration(
                  label: Text('First Name', style: TextStyle(
                      color: Colors.black, fontSize: 20),),
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(keyboardType: TextInputType.name,
                controller: lastnameController,
                decoration: const InputDecoration(
                  label: Text('Last Name', style: TextStyle(
                      color: Colors.black, fontSize: 20),),
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(keyboardType: TextInputType.number,
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  label: Text('Phone Number', style: TextStyle(
                      color: Colors.black, fontSize: 20),),
                  border: UnderlineInputBorder(),

                ),
              ),
            ),

            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final lastname = lastnameController.text;
                final phoneNumber = phoneNumberController.text;
                if (name.isNotEmpty && phoneNumber.isNotEmpty && lastname.isNotEmpty) {
                  final updatedContact = mainContact(name, phoneNumber,lastname);
                  Provider.of<ContactListProvider>(context, listen: false).updateContact(index, updatedContact);
                  Navigator.pop(context, updatedContact);
                } else {
                  Navigator.pop(context, null);
                }
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}