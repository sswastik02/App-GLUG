import 'package:flutter/material.dart';
import 'package:glug_app/resources/database_provider.dart';
import 'package:glug_app/resources/firestore_provider.dart';
import 'package:glug_app/blocs/attendance_bloc.dart';

class SubjectForm extends StatefulWidget {
  @override
  _SubjectFormState createState() => _SubjectFormState();
}

class _SubjectFormState extends State<SubjectForm> {
  final _formKey = GlobalKey<FormState>();
  FirestoreProvider _provider;
  TextEditingController _ctrl1, _ctrl2, _ctrl3;
  DatabaseProvider _databaseProvider;

  @override
  void initState() {
    super.initState();
    _provider = FirestoreProvider();
    _ctrl1 = TextEditingController();
    _ctrl2 = TextEditingController();
    _ctrl3 = TextEditingController();
    _databaseProvider= DatabaseProvider.databaseProvider;
  }

  @override
  void dispose() {
    super.dispose();
    _provider = null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Subject",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),

          SizedBox(
            width: 180.0,
            child: TextFormField(
              controller: _ctrl1,
              decoration: InputDecoration(hintText: "Subject name",
              hintStyle: TextStyle(fontSize: 13)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),

          SizedBox(
            width: 180.0,
            child: TextFormField(
              controller: _ctrl2,
              decoration: InputDecoration(hintText: "Initial Total Classes",
                  hintStyle: TextStyle(fontSize: 13)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a valid number';
                }
                return null;
              },
                keyboardType: TextInputType.number
            ),
          ),

          SizedBox(
            width: 180.0,
            child: TextFormField(
              controller: _ctrl3,
              decoration: InputDecoration(hintText: "Initial presents",
                  hintStyle: TextStyle(fontSize: 13)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a valid number';
                }
                return null;
              },
                keyboardType: TextInputType.number
            ),
          ),


         /* Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subj",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),

            ],
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [



            ],
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Classes Attended:",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),

            ],
          ),*/
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                color: Colors.deepOrangeAccent,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FlatButton(
                color: Colors.deepOrangeAccent,
                onPressed: () {
                  if (_formKey.currentState.validate()) {

                    _databaseProvider.addNewSubject( _ctrl1.text.toString(), int.parse(_ctrl2.text.toString()), int.parse(_ctrl3.text.toString()), 0, 0);


                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
