import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key});

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final durationController = TextEditingController();
  bool isLoading = false;

  void _addCourse() async{
    String name = nameController.text.toString();
    String description = descriptionController.text.toString();
    String duration = durationController.text.toString();

    if(name.isEmpty || description.isEmpty||duration.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }
    setState(() {
      isLoading = true;
    });
    try{
      // Save course data to Firestore
      await FirebaseFirestore.instance.collection('courses').add({
        'name':name,
        'description':description,
        'duration':duration,
        'createdAt':FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Course added successfully!'))
      );
      //Clear input fields
      nameController.clear();
      descriptionController.clear();
      durationController.clear();
    }catch(e){
      print('Error adding course:$e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add course")),
      );
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Add Course',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: 'Title',
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
            SizedBox(height: 20,),
            TextFormField(
              maxLines: 6,
                minLines: 2,
                controller: descriptionController,
                decoration: InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black,width: 5),
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
                validator:(value){
                  if(value!.isEmpty){
                    return 'Enter Description';
                  }
                  return null;
                }

            ),
            SizedBox(height: 20,),
            TextFormField(
                controller: durationController,
                decoration: InputDecoration(
                    hintText: 'Duration',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black,width: 5),
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
                validator:(value){
                  if(value!.isEmpty){
                    return 'Enter duration';
                  }
                  return null;
                }

            ),
            SizedBox(height: 30,),
            GestureDetector(
              onTap: isLoading? null: _addCourse,

              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)

                  ),
                  child:isLoading?
                  Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ):
                  Center(child: Text('Add Course',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),)),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
