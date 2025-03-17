import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_note/app_const.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DeliveryAddPage extends StatefulWidget {
  @override
  _DeliveryAddPageState createState() => _DeliveryAddPageState();
}

class _DeliveryAddPageState extends State<DeliveryAddPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  String? uid;
  bool isLoading = true;
  bool isUpdating = false; // To determine whether to show "Save" or "Update"

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    uid = pref.getString(AppConst.USER_ID_KEY);

    if (uid != null) {
      DocumentSnapshot doc = await firestore
          .collection("Users")
          .doc(uid)
          .collection("DeliveryAddress")
          .doc(AppConst.DELIVERY_DOC_ID)
          .get();


      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        setState(() {
          nameController.text = data["name"] ?? "";
          pinCodeController.text = data["pinCode"] ?? "";
          cityController.text = data["city"] ?? "";
          addController.text = data["add"] ?? "";
          countryController.text = data["country"] ?? "";
          isUpdating = true; // Data exists, so show "Update" button
        });
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _saveOrUpdateAddress() async {
    if (uid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User ID not found!")),
      );
      return;
    }

    Map<String, dynamic> addressData = {
      "name": nameController.text.trim(),
      "pinCode": pinCodeController.text.trim(),
      "city": cityController.text.trim(),
      "add": addController.text.trim(),
      "country": countryController.text.trim(),
    };

    await firestore
        .collection("Users")
        .doc(uid)
        .collection("DeliveryAddress")
        .doc(AppConst.DELIVERY_DOC_ID)
        .set(addressData, SetOptions(merge: true));

    setState(() {
      isUpdating = true; // Ensure button updates to "Update"
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(isUpdating ? "Address Updated!" : "Address Saved!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Delivery Address")),
      body: isLoading
          ? Center(child:  Skeletonizer.sliver(
    effect: PulseEffect(),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('Item number $index as title'),
                subtitle: const Text('Subtitle here'),
                trailing: const Icon(Icons.ac_unit),
              ),
            );
          },
        ),
      ))
          : SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField(nameController, "Name"),
            SizedBox(height: 20),
            _buildTextField(pinCodeController, "PinCode"),
            SizedBox(height: 20),
            _buildTextField(cityController, "City"),
            SizedBox(height: 20),
            _buildTextField(addController, "Address"),
            SizedBox(height: 20),
            _buildTextField(countryController, "Country"),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveOrUpdateAddress,
              child: Text(isUpdating ? "Update" : "Save"), // Change button label dynamically
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(),
      ),
    );
  }
}
// Helper method to create shimmer placeholders
Widget _shimmerBox({required double width, required double height}) {
  return SizedBox(
    width: width,
    height: height,
    child: DecoratedBox(
      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(4)),
    ),
  );
}
