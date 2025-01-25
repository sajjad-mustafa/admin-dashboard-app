import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard_admin_user/screens/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminPanelScreen extends StatefulWidget {
  
   AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  void addUser() async {
    String email = emailController.text.toString();
    String password = passwordController.text.toString();
    String name = nameController.text.toString();

    if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
      try {
        //Create user in firebase Authentication
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(
            email: email, password: password,);
        //Save user data in fireStore
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'name': name,
          'email': email,
          'password': password,
          'role': 'user',
          'createdAt': FieldValue.serverTimestamp()
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User added successfully!')),

        );
        //Clear field after success
        emailController.clear();
        passwordController.clear();
        nameController.clear();
      } catch (error) {
        print(error.toString());
      }
    }
  }

  void _addUser(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          TextEditingController emailController = TextEditingController();
          TextEditingController nameController = TextEditingController();
          TextEditingController passwordController = TextEditingController();
          return AlertDialog(
            title: Text('Add User'),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          hintText: 'Name',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black, width: 5),
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter name';
                        }
                        return null;
                      }

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black, width: 5),
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter name';
                        }
                        return null;
                      }

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black, width: 5),
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter name';
                        }
                        return null;
                      }

                  ),
                ),

              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    await _authService.addUser(
                        emailController.text.toString(),
                        nameController.text.toString(),
                    passwordController.text.toString());
                    Navigator.pop(context);
                  },
                  child: Text('Add'))
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () => _addUser(context),
            child: Text('Add User')),
      ),
    );
  }
}
