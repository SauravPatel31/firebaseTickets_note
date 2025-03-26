import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification_service.dart';

class AppointmentProvider extends ChangeNotifier {
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  DateTime selectedDate = DateTime.now();
  bool isReminderOn = false;
  String? selectedCategory;
  String? uid;

  Future<void> selectTime({required BuildContext context, required bool isStartTime}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      if (isStartTime) {
        startTime = pickedTime;
        endTime = null; // Reset end time if start time changes
      } else {
        if (startTime == null || !isEndTimeValid(pickedTime)) {
          return;
        }
        endTime = pickedTime;
      }
      notifyListeners();
    }
  }

  bool isEndTimeValid(TimeOfDay selectedEndTime) {
    if (startTime == null) return false;

    final int startMinutes = startTime!.hour * 60 + startTime!.minute;
    final int endMinutes = selectedEndTime.hour * 60 + selectedEndTime.minute;

    return endMinutes > startMinutes;
  }

  void toggleReminder(bool value) {
    isReminderOn = value;
    if (isReminderOn && startTime != null) {
      NotificationService.scheduleNotification(startTime!);
    }
    notifyListeners();
  }

  Future<void> saveAppointment() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    uid = pref.getString("USER_ID_KEY"); // Replace with your actual key
    if (uid == null || startTime == null || endTime == null || selectedCategory == null) return;

    var currentTime = DateTime.now().millisecondsSinceEpoch;

    // Here, you can save data to Firestore
    // firestore.collection("Users").doc(uid).collection("Appointments").doc(currentTime.toString()).set({...});

    notifyListeners();
  }
}
