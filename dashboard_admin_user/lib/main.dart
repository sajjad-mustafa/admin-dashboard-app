import 'dart:io';

import 'package:dashboard_admin_user/screens/admin_panel_screen.dart';
import 'package:dashboard_admin_user/screens/course_list_screen.dart';
import 'package:dashboard_admin_user/screens/dashboard_screen.dart';
import 'package:dashboard_admin_user/screens/login_screen.dart';
import 'package:dashboard_admin_user/screens/signup_screen.dart';
import 'package:dashboard_admin_user/screens/user_provider.dart';
import 'package:dashboard_admin_user/screens/user_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
      await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAhf_eNoDP-aHnXG0VrIJ4wYBDkgd-G_us",
            appId: "1:489219775434:android:ebf1b1a6d3b3b3116ccd33",
            messagingSenderId: "489219775434",
            projectId: "adim-panel-app")
      )

 : await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()..loadUser()),
        ],
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        // initialRoute: '/',
        // routes: {
        //   '/':(context) => LoginScreen(),
        //   '/signup':(context) => SignupScreen(),
        //   '/adminPanel':(context) => AdminPanelScreen(),
        //   '/userDashboard':(context) => UserScreen()
        // },
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
         home: Consumer<UserProvider>(
            builder: (context , userProvider, _) {
              // Redirect based on user role
              if(userProvider.isloggedIn){
                return userProvider.role == 'admin'?
                    const DashboardScreen():
                    const DashboardScreen();
              }
              return const LoginScreen();
            })

      ),
    );

  }
}

