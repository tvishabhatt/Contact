import 'package:flutter/material.dart';
import 'main.dart';

class AddContactScreen extends StatelessWidget {
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Add Contcts', style: TextStyle(color: Colors.white, fontSize: 20),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(keyboardType: TextInputType.name,
                controller: fname,
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
                controller: lname,
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
                controller: number,
                decoration: const InputDecoration(
                  label: Text('Phone Number', style: TextStyle(
                      color: Colors.black, fontSize: 20),),
                  border: UnderlineInputBorder(),

                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                final name = fname.text;
                final phoneNumber = number.text;
                final lastname=lname.text;
                if (name.isNotEmpty && phoneNumber.isNotEmpty) {
                  final newContact = mainContact(name, phoneNumber,lastname);
                  Navigator.pop(context, newContact);
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}