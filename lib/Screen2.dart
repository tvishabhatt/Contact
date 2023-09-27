import 'package:contact/Screen1.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class Screen2 extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Screen2State();
  }


}
class Screen2State extends State<Screen2>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(onPressed: () {
             abc();
            }, child:Text('Cilk me')),
          ),
        ],
      ),
    );
  }
  void abc ()
  async {
    final LocalAuthentication authentication=LocalAuthentication();
    final bool canAuthentication = await authentication.canCheckBiometrics;
    final bool canAuthenticate=canAuthentication||await authentication.isDeviceSupported();


    print(canAuthentication);
    print(canAuthenticate);


    if(canAuthenticate)
      {
        final  bool didAuthenticate = await authentication.authenticate(localizedReason: 'Test',);
        // options: AuthenticationOptions(biometricOnly: true));
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Screen1(),));
      }
  }
}
