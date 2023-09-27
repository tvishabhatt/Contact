import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Screen1 extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Screen1State();
  }

}
List<String> ln = [];
List<String> fi=[];
List<String> con=[];
List co=[];


TextEditingController fname = TextEditingController();
TextEditingController lname = TextEditingController();
TextEditingController number = TextEditingController();
class Screen1State extends State<Screen1> {
  bool a = true;
  Modal modal=Modal(name: '', lastname: '', phonenumber: '');


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    co.add(modal);
    final removeprovider=Provider.of<delet>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Contcts', style: TextStyle(color: Colors.white, fontSize: 20),),
        centerTitle: true,
      ),
      body:Consumer(
        builder: (context,adddata ad,child) {
          return  ad.LIST();
        },
      ),

      // SingleChildScrollView(
      //   child: Column(mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       for(int i=0;i<contact.length;i++)...
      //       [
      //         Padding(
      //           padding: const EdgeInsets.all(10),
      //           child: Row(
      //             children: [
      //               Padding(
      //                 padding: EdgeInsets.only(left: 30),
      //                 child: SizedBox(
      //                   width: 230,
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.start,
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Text('${contact[i]['name']}   ${contact[i]['lastname']}',style: TextStyle(color: Colors.black,fontSize: 20),),
      //                       Text('+91 ${contact[i]['phonenumber']}',style: TextStyle(color: Colors.black,fontSize: 20),),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //               IconButton(onPressed: () {
      //
      //               }, icon: Icon(Icons.phone,color: Colors.green.shade500,size: 20,))
      //             ],
      //           ),
      //         )
      //       ]
      //
      //     ],
      //   ),
      // ),
      floatingActionButton: Consumer(
        builder: (context,adddata ad,child) {
          return FloatingActionButton(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),

            ),
            onPressed: () {
              fname.clear();
              lname.clear();
              number.clear();
              showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    Dialog(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Add Contact ',
                                style: TextStyle(color: Colors.black, fontSize: 20),),
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
                              Container(
                                child: TextField(keyboardType: TextInputType.number,
                                  controller: number,
                                  decoration: const InputDecoration(
                                    label: Text('Phone Number', style: TextStyle(
                                        color: Colors.black, fontSize: 20),),
                                    border: UnderlineInputBorder(),

                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(onPressed: () {

                                    }, child: Text('Cancle')),
                                    TextButton(onPressed: () async {
                                       modal.name=fname.text;
                                       modal.lastname=lname.text;
                                       modal.phonenumber=number.text;
                                       co.add(modal);
                                      SharedPreferences sp=await SharedPreferences.getInstance();
                                      // sp.setStringList('contant',);



                                    }, child: Text('Save')),
                                  ],
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                    ),);
            },
            child: Icon(Icons.add, size: 20, color: Colors.white,),
          );
        }
      ),);
  }





}
class adddata extends ChangeNotifier {


  void add() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final cont=co.map((Modal){
      return '${Modal.name},${Modal.lastname},${Modal.phonenumber}';
    }).toList();
    prefs.setStringList('co', cont);
    prefs.getStringList('co');
    print(co);



    //  prefs.setString('firstname', fname.text);
   //  prefs.setString('lastname', lname.text);
   //  prefs.setString('phonenumber', number.text);
   //
   //
   //  String? first = prefs.getString('firstname');
   //  String? last = prefs.getString('lastname');
   //  String? num = prefs.getString('phonenumber');
   //  print(first);
   //  print(last);
   //  print(num);
   //
   //  String firstname=first.toString();
   //  String lastname= last.toString();
   //  String phonenumber= num.toString();
   //  print(firstname);
   //  print(lastname);
   //  print(phonenumber);
   //
   // fi.add(firstname);
   // ln.add(lastname);
   // con.add(phonenumber);
   // print(fi);
   // print(ln);
   // print(phonenumber);
   //  prefs.setStringList('firstnamelist', fi);
   //  prefs.setStringList('lastnamelist', ln);
   //  prefs.setStringList('phonenumberlist',con);
   //  List<String>? FI=prefs.getStringList('firstnamelist');
   //  List<String>? LA=prefs.getStringList('lastnamelist');
   //  List<String>? PH=prefs.getStringList('phonenumberlist');
   //  print(FI);
   //  print(LA);
   //  print(PH);


    notifyListeners();




  }
  Widget LIST()
  {
   return co.isEmpty ?
    Center(
      child: Text('You Have no contacts yet', style: TextStyle(
          color: Colors.grey, fontWeight: FontWeight.w800, fontSize: 20),),
    ) :ListView.builder(itemBuilder: (context, index) {
      return
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(Icons.person,color: Colors.grey,size: 20,),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: SizedBox(width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${co[index]}  ${co[index]}',
                        style: TextStyle(color: Colors.black, fontSize: 20),),
                      Text('+91 ${co[index]}',
                        style: TextStyle(color: Colors.black, fontSize: 20),),
                    ],),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: IconButton(onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>
                        Dialog(
                          child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Edit',style: TextStyle(color: Colors.black,fontSize: 20),),
                                    IconButton(onPressed: () {

                                    }, icon:Icon(Icons.edit,color: Colors.black,size: 20,),),
                                  ],
                                ),
                                Consumer(
                                  builder: (context,adddata ad,child) {
                                    return Row(
                                      children: [      Text('Delet',style: TextStyle(color: Colors.black,fontSize: 20),),
                                        IconButton(onPressed: () {

                                        }, icon:Icon(Icons.delete,color: Colors.black,size: 20,)),
                                      ],
                                    );
                                  }
                                ),
                              ],
                            ),
                          ),
                        ),);



                }, icon:Icon(Icons.more_vert,color: Colors.black,size: 20,)),
              ),
            ],
          ),
        );
    },
      itemCount: co.length,);

  }

}
class Modal{
  String name;
  String lastname;
  String phonenumber;

  Modal({required this.name,required this.lastname,required this.phonenumber,});
}
class delet extends ChangeNotifier{
  void remove(int i)
  {
    fi.removeAt(i);
    ln.removeAt(i);
    con.removeAt(i);
    notifyListeners();
  }
}
