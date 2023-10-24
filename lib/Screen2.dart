import 'package:contact/ContactListScreen.dart';
import 'package:contact/Screen1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class Screen2 extends StatefulWidget
{
  @override

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Screen2State();
  }

}
var MYNAME;
int  CurrentStep=0;
TextEditingController myname=TextEditingController();
TextEditingController mysurname=TextEditingController();
TextEditingController myphonenumber=TextEditingController();
TextEditingController myemail=TextEditingController();



class Screen2State extends State<Screen2> with ChangeNotifier
{ Steps s=Steps();
String MYNAME="";
  @override
void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Steps>(context,listen: false).savedata();
  }
  Widget build(BuildContext context) {
    final dataprovider=Provider.of<Steps>(context);

    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Log in ",style: TextStyle(color: Colors.white,fontSize: 25),),
        centerTitle: true,
      ),
            body: Stepper(
              type: StepperType.horizontal,
              steps: getSteps(),
              currentStep: CurrentStep,

              onStepContinue: () {
                final laststep=CurrentStep==getSteps().length-1;
                if(laststep)
                  {
                    print("Completed");
                  }
                else{
                  dataprovider.oncontinue();
                }
              },
              onStepCancel: CurrentStep==0?null :() => dataprovider.oncancle(),
            ),


    );
  }


}
  List<Step> getSteps()=>[

    Step(
      state: CurrentStep>0 ?StepState.complete:StepState.indexed,
      isActive: CurrentStep>=0,
      title: Text("Account"),
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: myname,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                label: Text("FirstName",style: TextStyle(color: Colors.black,fontSize: 20),),

              ),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: mysurname,
              decoration: InputDecoration(
                prefix: Text(" ",style: TextStyle(color: Colors.black,fontSize: 20),),
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                label: Text("LastName",style: TextStyle(color: Colors.black,fontSize: 20),),

              ),),
          ),
        ],
      )
    ),
    Step(
        state: CurrentStep>1 ?StepState.complete:StepState.indexed,
      isActive: CurrentStep>=1,
      title: Text("Address"),
      content:  Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: myphonenumber,
              decoration: InputDecoration(

                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                label: Text("Phone Number",style: TextStyle(color: Colors.black,fontSize: 20),),

              ),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: myemail,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                label: Text("Email Address",style: TextStyle(color: Colors.black,fontSize: 20),),

              ),),
          ),
        ],
      )
    ),
    Step(
      state: CurrentStep>2 ?StepState.complete:StepState.indexed,
      isActive: CurrentStep>=2,
      title: Text("Complete"),
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
             children: [
               Text( "First Name : ",
                 style: TextStyle(color: Colors.black,fontSize: 18),),
               Column(
                   children: [
                     Text(
                       "${myname.text}",
                       style:  TextStyle(color: Colors.black,fontSize: 18,),
                     ),
                     Divider(
                       color: Colors.black,height: 2, thickness: 2,
                     ),
                   ]
               )

             ],
         ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text( "Last Name : ",
                  style: TextStyle(color: Colors.black,fontSize: 18),),
                Column(
                    children: [
                      Text(
                        "${mysurname.text}",
                        style:  TextStyle(color: Colors.black,fontSize: 18,),
                      ),
                      Divider(
                        color: Colors.black,height: 2, thickness: 2,
                      ),
                    ]
                )],),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text( "Phone Number : ",
                  style: TextStyle(color: Colors.black,fontSize: 18),),
                Column(
                    children: [
                      Text(
                        "${myphonenumber.text}",
                        style:  TextStyle(color: Colors.black,fontSize: 18,),
                      ),
                      Divider(
                        color: Colors.black,height: 2, thickness: 2,
                      ),
                    ]
                )

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text( "Email Address : ",
                  style: TextStyle(color: Colors.black,fontSize: 18),),
                Column(
                    children: [
                      Text(
                        "${myemail.text}",
                        style:  TextStyle(color: Colors.black,fontSize: 18,),
                      ),
                      Divider(
                        color: Colors.black,height: 2, thickness: 2,
                      ),
                    ]
                )

              ],
            ),
          ),
          Center(
            child: Consumer<Steps>(
              builder: (context, provider, child){
                return ElevatedButton(
                  onPressed: () async{

                             final name = myname.text;
                             final phoneNumber = myphonenumber.text;
                              final lastname=mysurname.text;
                              if (name.isNotEmpty && phoneNumber.isNotEmpty) {
                              final newContact = mainContact(name, phoneNumber,lastname);
                              if (newContact != null) {
                                Provider.of<ContactListProvider>(context, listen: false).addContact(newContact as mainContact);
                              }
                              }
                    final prefs=await SharedPreferences.getInstance();
                    prefs.setBool(Screen1State.KEYLOGIN, true);

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContactListScreen(),));
                  },
                  child: Text("Submit"),
                );
              }
            ),
          )

        ],
      ),
    ),
  ];

class Steps extends ChangeNotifier{
  String MYNAME="My name";
  void oncontinue()
  {
    CurrentStep+=1;
    notifyListeners();
  }
  void oncancle() {
    CurrentStep -= 1;
    notifyListeners();
  }
  void  savedata () async{
   final prefs=await SharedPreferences.getInstance();
   prefs.getString("MyName");
   notifyListeners();

 }
}