import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'sections.dart';
import 'stream.dart';

class Year extends StatefulWidget {
  @override
  _YearState createState() => _YearState();
}

class _YearState extends State<Year> {
  List<String> years = [
    "First Year",
    "Second Year",
    "Third Year",
    "Fourth Year"
  ];

  Future<void> getSem() async {
    CollectionReference timetable =
        FirebaseFirestore.instance.collection('timetable');
    DocumentSnapshot documentSnapshot = await timetable.doc("sem").get();
    Map<String, dynamic> semMap = documentSnapshot.data();
    int sem = int.parse(semMap["sem"]);
    List<String> yearSem = years;
    for (int i = 0; i < years.length; i++) {
      yearSem[i] = yearSem[i] + " -sem ${2 * i + 1 + sem}";
    }
    setState(() {
      years = yearSem;
    });
  }

  void initState() {
    getSem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          DynamicTheme.of(context).themeId == 1 ? Colors.black : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              }),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Choose Your Year',
                            style: TextStyle(
                                fontFamily: "Nexa-Bold",
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.055,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: InkWell(
                      onTap: () {
                        if (index == 0)
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (ctxt) => Sections()));
                        else
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctxt) => Stream(index + 1)));
                      },
                      child: Container(
                        child: Center(
                          child: Text(
                            "${years[index]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              color:
                                  Colors.deepOrangeAccent //Color(0xFFE5E5E5),
                              ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
