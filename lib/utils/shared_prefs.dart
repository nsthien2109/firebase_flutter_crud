import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


dynamic setLogin(key, value) async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  var res = prefs.setBool(key, value);
  debugPrint('Set Login : $value');
  return res;
}

dynamic getLogin(key) async {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  var res = prefs.getBool(key);
  debugPrint('Get Login : $res');
  return res;
}

Future<bool> removeLogin(key) async{
  SharedPreferences preferences  =  await SharedPreferences.getInstance();
  return preferences.remove(key);
}


dynamic setKeyString(key, value) async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  var res = prefs.setString(key, value);
  debugPrint('Set Key String : $value');
  return res;
}

dynamic getKeyString(key) async {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  var res = prefs.getString(key);
  debugPrint('Get Key String : $res');
  return res;
}

Future reset() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
}