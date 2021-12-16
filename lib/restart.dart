import 'package:driver_qr/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Restart extends StatefulWidget {
  const Restart({Key? key}) : super(key: key);

  @override
  _RestartState createState() => _RestartState();
}

class _RestartState extends State<Restart> {
  late DateTime now;
  @override
  void initState() {
    getSalary();
    super.initState();
  }
  void getSalary() async {
    now = DateTime.now();
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('myTimestampKey', timestamp);
  }
  @override
  Widget build(BuildContext context) {

    return Material(
      child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.blue,
            child: const Padding(
              padding: EdgeInsets.only(bottom: 28.0),
              child: Align(alignment: Alignment.bottomCenter,
                child: Text("You're Scan Was Successful",style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20
                ),),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,width: 250,
                    child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyHomePage()));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                                side: const BorderSide(color: Colors.red))
                        ),
                        child: const Text("Return to Scan Again",)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
