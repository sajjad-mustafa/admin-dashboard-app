import 'package:dashboard_admin_user/screens/add_course_screen.dart';
import 'package:dashboard_admin_user/screens/admin_panel_screen.dart';
import 'package:dashboard_admin_user/screens/course_list_screen.dart';
import 'package:dashboard_admin_user/screens/profile_screen.dart';
import 'package:dashboard_admin_user/screens/user_provider.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,

      body: SafeArea(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      IconButton(onPressed: () async{
                        await logout(context);
                      },
                          icon: Icon(Icons.login_outlined,size: 30,color: Colors.white,)),
                      // Icon(Icons.menu,size: 40,color: Colors.white,),
                      InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminPanelScreen()));
                          },
                          child: Icon(Icons.account_circle_rounded,size: 40,color: Colors.white,)),

                    ],

                  ),
                  SizedBox(height: 30,),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dashboard',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.white),),
                      Text('Last Update 15 jan 2025',style: TextStyle(color: Colors.white70),)
                    ],
                  )
                ],
              ),
            ),

            Expanded(
              child: Container(
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.only(topRight:Radius.circular(30),topLeft: Radius.circular(30) )
                ),

                child: Padding(
                  padding: const EdgeInsets.only(top: 30,left: 15,right: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            elevation: 5.0,
                            borderRadius:BorderRadius.circular(20) ,
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>CourseListScreen()));
                              },
                              child: Container(
                                height:150,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset('images/mcqs.png'),
                                    Text('Courses',style: TextStyle(fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height:150,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                borderRadius:BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Image.asset('images/quiz.png',width: 100,height: 120,),
                                  SizedBox(height: 5,),
                                  Text('QUIZ',style: TextStyle(fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height:150,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                borderRadius:BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Image.asset('images/paper.png',width: 100,height: 120,),
                                  SizedBox(height: 5,),
                                  Text('Papers',style: TextStyle(fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          ),
                          Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height:150,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                borderRadius:BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Image.asset('images/pdf.png',width: 100,height: 120,),
                                  SizedBox(height: 5,),
                                  Text('PDF',style: TextStyle(fontWeight: FontWeight.bold),)
                                ],
                              )
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height:150,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                borderRadius:BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Image.asset('images/jobs.png',width: 100,height: 120,),
                                  Text('Jobs',style: TextStyle(fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          ),
                          Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height:150,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white24,
                                borderRadius:BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Image.asset('images/about.jpg',width: 120,height: 120,),
                                  Text('About')
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
