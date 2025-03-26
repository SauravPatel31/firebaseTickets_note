import 'package:flutter/material.dart';

class SpecialPage extends StatelessWidget {

  TextEditingController aController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: Column(
        children: [
          TextField(
            controller: aController,
          ),
          ElevatedButton(onPressed: (){}, child: Text("Add"))
        ],
      ),
    );
  }
}
