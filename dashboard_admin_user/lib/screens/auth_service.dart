import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?>signUp(String email,String password,String name)async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //Add to Firestore with admin role
      if(userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'name': name,
          'email': email,
          'role': 'Admin'
          //'createdAt': FieldValue.serverTimestamp(),
        });
        //save login state and role using SharedPreference
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('uid', userCredential.user!.uid);
        await prefs.setString('role', 'admin');
      }
      return userCredential.user;
    }catch (e) {
      print('Error during sign up: $e');
      return null;
    }
  }
  Future<User?> login(String email,String password)async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if(userCredential.user != null) {
        final userDoc = await _firestore.collection('users').doc(userCredential.user!.uid).get();
        //return userCredential.user;
        // String uid = userCredential.user!.uid;
        // //fetch user role from firestore
        // DocumentSnapshot userDoc = await _firestore.collection('users')
        //     .doc(uid)
        //     .get();

      if(userDoc.exists) {
        final role = userDoc.data()!['role'];
        //save login state and role using SharedPerferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('uid', userCredential.user!.uid);
        await prefs.setString('role', role);
        return userCredential.user;
      }
      // }else{
      //   throw Exception('User document does not exist');
       }
      //return userCredential.user;
    }catch (e){
      print('Error during login $e');
      return null;
    }
  }
  Future<void>addUser(String email,String name,String password)async{
    try {
      //Create user in firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //Add 'User' role to firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'role': 'User'

      });
      print('User added succefully!');
    }catch (e){
      print('Error adding user:$e');
    }
  }
  Future<String?>getRole(String uid)async {
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
    return userDoc['role'];
  }
}