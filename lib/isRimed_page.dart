import 'package:firebase_note/ap_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppointmentProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Appointment")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(hintText: "Enter Name"),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(hintText: "Enter Description"),
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2022),
                  lastDate: DateTime.now(),
                  initialDate: provider.selectedDate,
                );
                if (pickedDate != null) {
                  provider.selectedDate = pickedDate;
                  provider.notifyListeners();
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
                    Text("${provider.selectedDate.toLocal()}".split(' ')[0]),
                    Icon(Icons.date_range),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => provider.selectTime(context: context, isStartTime: true),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(provider.startTime != null
                          ? "${provider.startTime!.hour}:${provider.startTime!.minute}"
                          : "Start Time"),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => provider.selectTime(context: context, isStartTime: false),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(provider.endTime != null
                          ? "${provider.endTime!.hour}:${provider.endTime!.minute}"
                          : "End Time"),
                    ),
                  ),
                ),
              ],
            ),
            Switch(
              value: provider.isReminderOn,
              onChanged: provider.toggleReminder,
            ),
            ElevatedButton(
              onPressed: provider.saveAppointment,
              child: Text("Book Appointment"),
            ),
          ],
        ),
      ),
    );
  }
}
