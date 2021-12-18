import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//ignore: must_be_immutable
class RecordScreen extends StatefulWidget {
  const RecordScreen({Key? key}) : super(key: key);


  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  String id1 = "";
  int counter=0;
  List<String> dates2 = [];
  List<int> mOriginalList = [];
  List<DateTime> dateTime = [];

  @override
  void initState() {

    getString();
    super.initState();
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 3));
    getString();
    getList();
  }

  void getString() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dates2 = prefs.getStringList('dates2') ?? List<String>.generate(0, (index) => "add");
    mOriginalList = dates2.map((i)=> int.parse(i)).toList();
    for (var i in mOriginalList) {
      DateTime before = DateTime.fromMillisecondsSinceEpoch(i);
      dateTime.add(before);
      counter+=1;
    }
   
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        color: Colors.white,
        child: Material(
          child: RefreshIndicator(onRefresh: _refresh,child: getList()),
        ),
      ),
    );
  }

  Widget getList() {
    return FutureBuilder(
            future: Future?.delayed(const Duration(seconds: 1)),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }
             return ListView.builder(
                  itemCount: dateTime.length,
                  itemBuilder: (context, index) {
                    return  ListTile(
                  title: Text("${dateTime[index]}")

          );}
        );
      },
    );
  }
}