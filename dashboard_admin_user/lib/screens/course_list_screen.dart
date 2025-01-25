import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard_admin_user/screens/add_course_screen.dart';
import 'package:dashboard_admin_user/screens/course_detail_screen.dart';
import 'package:dashboard_admin_user/screens/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  bool isAdmin = false;
  bool isLoading = true;
  @override
  void initState(){
    super.initState();
    _checkUserRole();
  }
  Future<void> _checkUserRole() async{
    try{
      //Get the currently logged-in user
      final User? user = FirebaseAuth.instance.currentUser;
      print('Current user:${user?.uid}');
      if(user != null){
        //fetch user data from firestore
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users')
            .doc(user.uid).get();
        print('User Document:${userDoc.data()}');
        if(userDoc.exists){
          setState(() {
            isAdmin = userDoc['role'] == 'Admin';
          });
        }
      }
    }catch (e) {
      print('Error checking user role: $e');
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.shade200,
      appBar: AppBar(
        title: Center(child: Text('Courses',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),)),
        backgroundColor: Colors.blue,
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));
        },
            icon: Icon(Icons.arrow_back), ),
      ),
      body: isLoading
        ?const Center(child: CircularProgressIndicator(),):
      StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('courses').snapshots(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
              return const Center(
                child: Text("No courses available"),
              );

            }
            final courses = snapshot.data!.docs;
            return ListView.builder(
              itemCount: courses.length,
                itemBuilder: (context,index){
                final course = courses[index];
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(

                    child: ListTile(

                      title: Text(course['name'],style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                     // subtitle: Text(course['description'],style: TextStyle(fontSize: 18),),
                      trailing: Text(course['duration'],style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),

                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CourseDetailScreen(
                          courseName:course['name'],
                          courseDescription: course['description'],
                        ),
                        ),
                        );
                      },
                    ),
                  ),
                );
                });
          }),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCourseScreen()));
          },
      child: Icon(Icons.add),)
          :null,
    );
  }
}
