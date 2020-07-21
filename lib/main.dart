import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Simple Interest',
          home: SIForm(),
          theme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.indigo,
              accentColor: Colors.indigoAccent)) //Material App

      ); //runApp
} //main

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIForm();
  } //createState()
} //SIForm

class _SIForm extends State<SIForm> {
  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  final _minPadding = 5.0;
  var _currentItemSelected = 'Rupees';
  var _displayresult = '';
  var _formkey = GlobalKey<FormState>();

  void iniState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  TextEditingController principalControlled = TextEditingController();
  TextEditingController rateControlled = TextEditingController();
  TextEditingController timeControlled = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: AppBar(title: Text('Simple Interest Calculator')),
        body: Form(
            key: _formkey,
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                    padding:
                        EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: principalControlled,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'This field cannot be empty';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Principal',
                            hintText: 'Enter Principal Eg 10000',
                            errorStyle: TextStyle(color: Colors.yellowAccent),
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))))),
                Padding(
                    padding:
                        EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: timeControlled,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Time',
                          hintText: 'Enter Time in Years',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(color: Colors.yellowAccent),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                  padding:
                      EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: rateControlled,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'This field cannot be empty';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Rate of Interest',
                            hintText: 'Enter Rate in Percentage',
                            labelStyle: textStyle,
                            errorStyle: TextStyle(color: Colors.yellowAccent),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                      Container(width: _minPadding * 5),
                      Expanded(
                        child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(), //value
                          value: _currentItemSelected,

                          onChanged: (String newValueSelected) {
                            _onDropDownItemChanged(newValueSelected);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding:
                        EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                    child: Row(children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          child: Text(
                            "Calculate",
                            textScaleFactor: 1.5,
                          ),
                          elevation: 6.0,
                          onPressed: () {
                            setState(() {
                              if (_formkey.currentState.validate()) {
                                this._displayresult =
                                    _onCalculateTotalReturns();
                              }
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            "Reset",
                            textScaleFactor: 1.5,
                          ),
                          elevation: 6.0,
                          onPressed: () {
                            setState(() {
                              _reset();
                            });
                          },
                        ),
                      )
                    ])),
                Padding(
                    padding: EdgeInsets.all(_minPadding * 2),
                    child: Text(
                      _displayresult,
                      style: textStyle,
                    ))
              ],
            )));
  } //Widget
//_SIForm

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.jpg');
    Image image = Image(image: assetImage, width: 200.0, height: 200.0);
    return Container(
      child: image,
      margin: EdgeInsets.all(50.0),
    );
  }

  void _onDropDownItemChanged(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _onCalculateTotalReturns() {
    double principal = double.parse(principalControlled.text);
    double rate = double.parse(rateControlled.text);
    double time = double.parse(timeControlled.text);

    double amount = principal + (principal * rate * time) / 100;
    String result =
        'After $time years, your investment will be worth $amount $_currentItemSelected';
    return result;
  }

  void _reset() {
    principalControlled.text = '';
    rateControlled.text = '';
    timeControlled.text = '';
    _displayresult = '';
    _currentItemSelected = _currencies[0];
  }
}
