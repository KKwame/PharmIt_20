import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_spy/Utilities/symptoms.dart';
import 'detailedsymptomchoice.dart';
import 'location.dart';
// this is the pane that displays the list of symptoms with the buttons
// it takes the list from the utilities folder under symptoms.dart
// on press on each list sends you to the detailedsymptomchoice.dart file

// Here the (data) variable in the function at the down will be the
//variable that should pass the array of 18 values to the model for
//prediction.

class DiagnosisPane1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diagnosis Pane1'),
      ),
    );
  }
}

class DiagnosisPane extends StatefulWidget {
  @override
  _DiagnosisPaneState createState() => _DiagnosisPaneState();
}

class _DiagnosisPaneState extends State<DiagnosisPane> {
  List<Symptom> _symptoms;
  //BernoulliNB bernulli;

  // void initState(){
  //   super.initState();
  //   initBernulli();
  //   WidgetsBinding.instance.addPostFrameCallback((_)=> _refreshIndicatorKey.currentState.show());
  // }

  @override
  void initState() {
    super.initState();
    //initBernulli();
    _symptoms = Symptoms.initializeSymptoms().getSymptoms;
  }

  _handleDetailedSymptomChoiceData(int index) async {
    bool data = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailedSymptomChoice(_symptoms[index])));
    this.setState(() {
      _symptoms[index].setCheckState = data;
    });
  }

  _handleIconDisplay(int index) {
    bool readStatus = _symptoms[index].getSymptomCheck ?? false;
    return Icon(
      (readStatus ? Icons.check_circle : Icons.cancel),
      color: (readStatus) ? Colors.green : Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Symptoms'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _symptoms.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.blueAccent, width: 1.0),
                    ),
                  ),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_symptoms[index].getTitle),
                        _handleIconDisplay(index),
                      ],
                    ),
                    onTap: () {
                      _handleDetailedSymptomChoiceData(index);
                    },
                  ),
                );
              },
            ),
          ),
          // This is the make diagnosis button that take the arrayList from the function below.
          FlatButton(
            onPressed: _onMakeDiagnosisPressed,
            onLongPress: (){Navigator.push(context,
          MaterialPageRoute(builder: (context)=>LocationPane()),);},
            color: Colors.blue,
            child: Text('Make Diagnosis'),
          ),
        ],
      ),
    );
  }


    // this is the function for getting the arrays from the selected list
    //so the (data variable is the arraylist)
    // selected ones will be 1's and unselected 0's
  void _onMakeDiagnosisPressed() async {
    final data = _symptoms.map((symptom) {
      return (symptom.getSymptomCheck ?? false) ? 1 : 0;
    }).toList();
    print('current data ${data}');
    // Just printing the data to the console but not displaying anything to the app
    // You can use the variouscure.dart file for further display or the viewstatspane
    // they are just initialized not used
  }

  // Future<void> initBernulli() async{
  //   var model = await loadModel("assets/modelj.json");
  //   this.bernulli = BernoulliNB.fromMap(jsonDecode(model));
  //   print(bernulli);
  // }

}

