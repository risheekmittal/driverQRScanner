import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//ignore: must_be_immutable
class RecordScreen extends StatefulWidget {
  RecordScreen({required this.dates, required this.hours});
  final List<String> dates;
  final List<String> hours;

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  String id1 = "";
  List<int> mOriginalList = [];
  List<DateTime> dateTime = [];

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      getString();
    });
    getString();
    super.initState();
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 3));
    getString();
    getList();
  }

  void getString() {
        List<String>.generate(0, (index) => "add");
    mOriginalList = widget.dates.map((i) => int.parse(i)).toList();

    for (var i in mOriginalList) {
      DateTime before = DateTime.fromMillisecondsSinceEpoch(i);
      dateTime.add(before);
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        color: Colors.white,
        child: Material(
          child: RefreshIndicator(onRefresh: _refresh,child: getList()),
        ),
      ),
    );
  }

  Widget getList() {
    return ListView.builder(
      itemCount: widget.dates.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(widget.dates[index]),
        );
      },
    );
  }
}