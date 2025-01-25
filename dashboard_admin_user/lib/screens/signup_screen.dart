import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard_admin_user/screens/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'admin_panel_screen.dart';
import 'dashboard_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool isLoading = false;
   void _signup() async {
     String email = emailController.text.toString();
     String password = passwordController.text.toString();
     String name = nameController.text.toString();
       setState(() {
         isLoading = true;
       });

     try {
       //call your AuthService to create the user
       User? user = await _authService.signUp(
           email, password, name);
       if (user != null) {
         Navigator.push(
           context, MaterialPageRoute(builder: (context) => DashboardScreen()),
         );
       }else{
         print('Signup failed');
       }
       }catch (e){
       print('Error during signup $e');
     }finally{
       setState(() {
         isLoading = false;
       });
     }
     //     //Save user data to Firestore
     //     await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
     //         {
     //           'name': name,
     //           'email': email,
     //           'role': 'admin',
     //           'createdAt': FieldValue.serverTimestamp(),
     //         });
     //     //Navigate to admin panel
     //     Navigator.push(context,
     //         MaterialPageRoute(builder: (context) => DashboardScreen())
     //     );
     //   } else {
     //     print('Signup failed');
     //   }
     // } catch (e) {
     //   print('Error $e');
     // }
   }

   //   var user = await _authService.signUp(email, password, name);
   //   if(user != null){
   //     Navigator.push(context, MaterialPageRoute(
   //         builder: (context)=>AdminPanelScreen())
   //     );
   //
   //   }else{
   //     print('Signup failed');
   //   }
   // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Signup Screen',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),)),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Padding(
             padding: const EdgeInsets.all(10),
             child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: 'Name',
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
                controller: emailController,
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
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: 'password',
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
              onTap:isLoading? null: _signup,
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: isLoading?
                Center(
                  child: const CircularProgressIndicator(
                    color: Colors.white,

                  ),
                ) :
                Center(child: Text('SignUp',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),))
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account?"),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

              },
                  child: Text("Login"))
            ],
          ),
        ],
      ),
    );
  }
}
