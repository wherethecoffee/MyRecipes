import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool vegeterianSwitch = false; //track vegeterian switch state
  bool veganSwitch = false; //track vegan switch state
  var prefs; //shared preferences instance
  Future<void> getSwitchStates() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      vegeterianSwitch = prefs.getBool('vgt') ?? false; //get vegeterian switch state from shared preferences else show false
      veganSwitch = prefs.getBool('veg') ?? false; //get vegan switch state from shared preferences else show false
    });
  }

  Future<void> updateVGTinPref(val) async {
    prefs.setBool('vgt', val);
  } //update vegeterian switch state in shared preferences

  Future<void> updateVEGinPref(val) async {
    prefs.setBool('veg', val);
  } //update vegan switch state in shared preferences

  @override
  void initState() {
    getSwitchStates();
    super.initState();
  } //initialize the state of switches when the screen is loaded

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Column(
        children: [
          SwitchListTile(
            title: Text('Vegeterian only'),
            subtitle: Text('switch to allow only vegeterian meals'),
            value: vegeterianSwitch,
            onChanged: (val) {
              setState(() {
                vegeterianSwitch = val;
                updateVGTinPref(val);
              });
            },
          ),
          SwitchListTile(
            title: Text('Vegan only'),
            subtitle: Text('switch to allow only vegan meals'),
            value: veganSwitch,
            onChanged: (val) {
              setState(() {
                veganSwitch = val;
                updateVEGinPref(val);
              });
            },
          ),
        ],
      ),
    );
  }
}
