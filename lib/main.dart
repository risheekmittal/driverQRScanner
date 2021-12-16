import 'dart:ui';
import 'package:driver_qr/record_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:driver_qr/starting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String id1;
  int counter=0;
  int index=0;
  List<String> ids = [];
  List<int> mList = [];
  List<int> hours = [];
  List<String> finalHourList = [];

  @override
  void initState() {
    addIDs();
    super.initState();
  }

  void addIDs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringsList=  mList.map((i)=>i.toString()).toList();
    prefs.setStringList("ids3",ids);
    await prefs.setStringList("dates2",stringsList);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
          width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/abcd.jpg"),fit: BoxFit.cover),
                ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Hello",style: TextStyle(fontSize: 70,fontWeight: FontWeight.bold)),
              const Text("Enter your ID",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300)),
              const SizedBox(height: 50,),
              SizedBox(width: 300,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      id1=value;
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15),
                      hintText: "Enter here",
                      hintStyle: TextStyle(
                        color: Colors.white
                      ),
                      border: InputBorder.none,
                      fillColor: Colors.blue,
                    ),

                  ),
                ),
              ),
              const SizedBox(height: 50,),
              SizedBox(
                height: 45,width: 150,
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const StartingScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                          side: const BorderSide(color: Colors.red))
                    ),
                    child: const Text("Scan Now",)),
              ),
              const SizedBox(height: 50,),
              SizedBox(
                height: 45,width: 250,
                child: ElevatedButton(
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      List<String> dates = prefs.getStringList('dates2') ?? List<String>.generate(0, (index) => "add");
                      List<int> mOriginalList = dates.map((i)=> int.parse(i)).toList();
                      int timestamp = DateTime.now().millisecondsSinceEpoch;
                      mOriginalList.add(timestamp);
                      List<String> finalList=  mOriginalList.map((i)=>i.toString()).toList();
                      print(finalList[0]);
                      await prefs.setStringList('dates2', finalList);
                      if(counter==1) {
                        // int index = ids2.indexOf(id1);
                        // print(ids2[index]);
                        // print(index);
                        int repeatedTime = mOriginalList[index-1];
                        DateTime before = DateTime.fromMillisecondsSinceEpoch(repeatedTime);
                        print(before);
                        DateTime now =DateTime.now();
                        print(now);
                        Duration timeDifference = now.difference(before);
                        int hours = timeDifference.inSeconds;
                        List<int> hourList = [];
                        hourList.add(hours);
                        finalHourList=  mOriginalList.map((i)=>i.toString()).toList();
                        await prefs.setStringList('hours', finalHourList);
                        print(hours);
                        counter=0;
                      }
                      else{
                        // ids2.add(id1);
                        // print(ids2[0]);
                        // print(ids2.length);
                        // prefs.setStringList('ids3', ids2);
                        counter+=1;
                      }
                      index+=1;
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RecordScreen(dates: dates,hours: finalHourList)));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                            side: const BorderSide(color: Colors.red))
                    ),
                    child: const Text("View Previous Records",)),
              )

            ],
          ),
        )
      );
  }
}
