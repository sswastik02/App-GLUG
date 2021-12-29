import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:glug_app/resources/routine_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String section;
int year;

class TimeTable extends StatefulWidget {
  TimeTable(String x, int y) {
    section = x;
    year = y;
  }

  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  var color = {};
  dynamic data = {};

  Future getData() async {
    CollectionReference timetable =
        FirebaseFirestore.instance.collection('timetable');
    QuerySnapshot querySnapshot = await timetable.get();
    List<QueryDocumentSnapshot> lqds = querySnapshot.docs;
    DocumentSnapshot documentSnapshot =
        await timetable.doc(lqds[year - 1].id).get();
    setState(() {
      data = documentSnapshot.data();
    });
  }

  void colorSc() {
    RoutineData routineData = RoutineData();
    var set = <String>{};
    for (var i = 0; i < 11; i++) {
      for (var j = 0; j < 6; j++) {
        if (data[section]["${i}"][j] != "" &&
            data[section]["${i}"][j].toString().length == 5)
          set.add(data[section]["${i}"][j].toString());
      }
    }
    // print(color);
    int c = 1;
    set.forEach((element) {
      setState(() {
        color[element] = routineData.colorScheme[c];
        c++;
      });
    });
  }

  Future<int> allFutureCalls() async {
    await getData();
    colorSc();
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
        future: allFutureCalls(),
        builder: (context, snapshot) {
          return (!snapshot.hasData)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(9, 0, 9, 7),
                  child: Container(
                      child: GridView.count(
                          crossAxisCount: 6,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: List.generate(
                            66,
                            (index) {
                              return Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: (data[section]
                                                      ["${(index / 6).toInt()}"]
                                                  [index % 6] !=
                                              null)
                                          ? color[data[section]
                                                  ["${(index / 6).toInt()}"]
                                              [index % 6]]
                                          : DynamicTheme.of(context).themeId ==
                                                  1
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                    child: Center(
                                        child: Transform(
                                      alignment: FractionalOffset.center,
                                      transform: new Matrix4.identity()
                                        ..rotateZ(0 * 3.1415927 / 180),
                                      child: Text(
                                        "${data[section]["${(index / 6).toInt()}"][index % 6]}",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.046,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),
                                  ));
                            },
                          ))),
                );
        });
  }
}
