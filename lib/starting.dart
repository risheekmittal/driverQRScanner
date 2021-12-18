import 'package:driver_qr/success.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  _StartingScreenState createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;

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
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    void _onQRViewCreated(QRViewController controller) {
      this.controller = controller;
      controller.scannedDataStream.listen((scanData) async {
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
        controller.pauseCamera();
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Success()));
      });
    }

    return  Scaffold(
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }
}
