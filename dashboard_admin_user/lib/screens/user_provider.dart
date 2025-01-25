
import 'package:dashboard_admin_user/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier{
  String? _role;
  String? _uid;

  String? get role => _role;
  String? get uid => _uid;

  Future<void> saveUser(String role,String email)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);
    await prefs.setString('uid', email);

    _role = role;
    _uid = email;
    notifyListeners();
  }
  Future<void>loadUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _role = prefs.getString('role');
    _uid = prefs.getString('uid');
    notifyListeners();
  }
  Future<void>clearUser()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    await prefs.remove('role');
    await prefs.remove('uid');

    _role = null;
    _uid = null;
    notifyListeners();
  }
  bool get isloggedIn => _role != null && _uid != null;
}
Future<void>logout(BuildContext context) async {
  try{
    //Sign out from firebase
    await FirebaseAuth.instance.signOut();
    // clear SharedPreference
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  }catch (e){
    print('Error during logout: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to logout')),
    );
  }
}