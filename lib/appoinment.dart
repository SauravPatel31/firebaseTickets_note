import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_note/app_const.dart';
import 'package:firebase_note/special_in_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Appointment extends StatefulWidget {
  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  String? uid;
  FirebaseFirestore firestore =FirebaseFirestore.instance;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  DateTime selecteDate = DateTime.now();

  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  bool isReadme=false;
  List<String> category = ['Mens suit','Women','kids '];
  String? selectedCategory;

  Future<void> selectTime({required bool isStartTime}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          startTime = pickedTime;
          endTime = null; // Reset end time if start time changes
        } else {
          if (startTime == null) {
            Get.snackbar(
              "Error",
              "Please select a start time first!",
              backgroundColor: Colors.red.withOpacity(0.6),
              colorText: Colors.white,
            );
            return;
          }
          if (!isEndTimeValid(pickedTime)) {
            Get.snackbar(
              "Error",
              "End time must be after start time!",
              backgroundColor: Colors.red.withOpacity(0.6),
              colorText: Colors.white,
            );
            return;
          }
          endTime = pickedTime;
        }
      });
    }
  }
  // Helper function to validate end time
  bool isEndTimeValid(TimeOfDay selectedEndTime) {
    if (startTime == null) return false;

    final int startMinutes = startTime!.hour * 60 + startTime!.minute;
    final int endMinutes = selectedEndTime.hour * 60 + selectedEndTime.minute;

    return endMinutes > startMinutes; // Ensures end time is after start time
  }

  // Helper function to format TimeOfDay
  String formatTime(TimeOfDay? time) {
    if (time == null) return "Select Time";
    final now = DateTime.now();
    final formattedTime = DateFormat.jm().format(
      DateTime(now.year, now.month, now.day, time.hour, time.minute),
    );
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: "Enter Name"),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descController,
              decoration: InputDecoration(hintText: "Enter Description"),
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: ()async{
                DateTime? pickedDate =await showDatePicker(
                    context: context,
                    firstDate: DateTime(2022),
                    lastDate: DateTime.now(),
                  initialDate: selecteDate
                );
                if(pickedDate!=null){
                  selecteDate=pickedDate;
                  setState(() {

                  });
                }
              },
              child: Container(
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                  
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DateFormat('dd/MM/yyyy').format(selecteDate)),
                    Icon(Icons.date_range)
                  ],
                ),
              ),
            ),
           Row(
             children: [
               // Start Time Selection

               Expanded(
                 child: InkWell(
                   onTap: () => selectTime(isStartTime: true),
                   child: Container(
                     padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                     decoration: BoxDecoration(
                       border: Border.all(width: 2, color: Colors.grey),
                       borderRadius: BorderRadius.circular(20),
                     ),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(startTime!=null?formatTime(startTime):"Start Time"),
                         Icon(Icons.access_time),
                       ],
                     ),
                   ),
                 ),
               ),
               
               // End Time Selection

               Expanded(
                 child: InkWell(
                   onTap: () => selectTime(isStartTime: false),
                   child: Container(
                     padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                     decoration: BoxDecoration(
                       border: Border.all(width: 2, color: Colors.grey),
                       borderRadius: BorderRadius.circular(20),
                     ),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(formatTime(endTime)),
                         Icon(Icons.access_time),
                       ],
                     ),
                   ),
                 ),
               ),
             ],
           ),
            Switch(value: isReadme, onChanged: (value){
              isReadme=value;
              print(isReadme);
              setState(() {

              });
            }),
            Text("Select Category"),
            Wrap(
              children:category.map((e) {
                return InkWell(
                  onTap: (){
                    selectedCategory=e;
                    print(e);
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: 104,
                    height: 44,
                    color: Colors.grey,
                    child: Center(child: Text(e)),
                  ),
                );
              },).toList() ,
            ),
            ElevatedButton(onPressed: ()async{
              SharedPreferences pref =await SharedPreferences.getInstance();
              uid= pref.getString(AppConst.USER_ID_KEY);
              var currentTime = DateTime.now().millisecondsSinceEpoch;
              if(nameController.text.isNotEmpty&&descController.text.isNotEmpty&&startTime!=null&&endTime!=null&&selectedCategory!=null){
               await firestore.collection("Users").doc(uid).collection("Appoinments").doc(currentTime.toString()).set({
                  "name":nameController.text,
                  "description":descController.text,
                  "date":selecteDate.toIso8601String(),
                  "starttime":startTime!.hour.toString().padLeft(2, '0') + ":" + startTime!.minute.toString().padLeft(2, '0'),
                  "endtime":endTime!.hour.toString().padLeft(2,'0')+":"+endTime!.minute.toString().padLeft(2,'0'),
                  "reminds":isReadme,
                  "category":selectedCategory
                }).then((value) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SpecialPage(),));
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data is add",style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,));
                },).onError((error, stackTrace) {
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$error",style: TextStyle(color: Colors.white),),backgroundColor: Colors.red,));
                },);
              }else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All field are required!!")));
              }

            }, child: Text("Book"))
            
          ],
        ),
      ),
    );
  }
}
