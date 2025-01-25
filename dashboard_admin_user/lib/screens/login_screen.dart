import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard_admin_user/screens/auth_service.dart';
import 'package:dashboard_admin_user/screens/course_list_screen.dart';
import 'package:dashboard_admin_user/screens/dashboard_screen.dart';
import 'package:dashboard_admin_user/screens/signup_screen.dart';
import 'package:dashboard_admin_user/screens/user_provider.dart';
import 'package:dashboard_admin_user/screens/user_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin_panel_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool isLoading = false;

  void _login()async {
    String email = _emailController.text.toString();
    String password = _passwordController.text.toString();
   setState(() {
     isLoading = true;
   });
   try{
     final user = await _authService.login(email, password);
     if(user != null){
       final prefs = await SharedPreferences.getInstance();
       final role = prefs.getString('role');
       //Update provider state
       final authProvider = Provider.of<UserProvider>(context,listen: false);
       authProvider.saveUser(user.uid,role!);
   //     if(role == 'admin'){
   //       Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));
   //     }
   //   }else{
   //     print('login failed');
   //   }
   // }catch (e) {
   //   print('Error during login: $e');
   // }
   // setState(() {
   //   isLoading = false;
   // });
   // if(email.isEmpty || password.isEmpty){
   //   ScaffoldMessenger.of(context).showSnackBar(
   //     SnackBar(content: Text('please fill all fields ')),
   //   );
   //   return;
   // }
   // setState(() {
   //   isLoading = true;
   // });
   // try{
   //   AuthService authService = AuthService();
   //   String? role =
   //   (await authService.login(email, password)) as String?;
   //   if(role != null){
       // Save role and email in UserProvider
       final userProvider = Provider.of<UserProvider>(context,listen: false);
       userProvider.saveUser(role, email);
       if(role == 'admin'){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen()),
         );
       }else{
         Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));
       }
     }else{
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Login failed')),
       );
     }
   }catch (e){
     print('Error during login:$e');
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('An error occurred')),
     );
   }finally{
     setState(() {
       isLoading = false;
     });
   }

    // try {
    //   User? user = await _authService.login(email, password);
    //   if (user != null) {
    //     //fetch the user role from Firestore
    //     DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection(
    //         'users').doc(user.uid).get();
    //     if (userDoc.exists) {
    //       String role = userDoc['role'];
    //       //Navigate based on role
    //       if (role == 'Admin') {
    //         Navigator.push(context,
    //             MaterialPageRoute(builder: (context) => DashboardScreen())
    //         );
    //       } else if (role == 'User') {
    //         Navigator.push(
    //           context, MaterialPageRoute(builder: (context) => CourseListScreen()),
    //         );
    //       } else {
    //         print('Unknown role');
    //       }
    //     } else {
    //       print('user document does not exist.');
    //     }
    //   } else {
    //     print('Login failed');
    //   }
    // } catch (e) {
    //   print('Error during login: $e');
    //
    // }finally{
    //   setState(() {
    //     isLoading = false;
    //   });
    // }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login Screen',style: TextStyle(fontSize:24,fontWeight: FontWeight.bold,color: Colors.white ),)),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black,width: 5),
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
                validator:(value){
                  if(value!.isEmpty){
                    return 'Enter name';
                  }
                  return null;
                }

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black,width: 5),
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
                validator:(value){
                  if(value!.isEmpty){
                    return 'Enter name';
                  }
                  return null;
                }

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap:isLoading? null: _login,
              child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:isLoading?
                  Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ):
                  Center(child: Text('Login',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),))
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account?"),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));

              },
                  child: Text("Sign up"))
            ],
          ),

        ],
      ),
    );
  }
}
