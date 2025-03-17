/*
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math';

import 'package:skeletonizer/skeletonizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> names = List.generate(
    200, (index) => "${String.fromCharCode(65 + Random().nextInt(26))}Name$index",
  );
  String? selectedLetter;

  @override
  Widget build(BuildContext context) {
    List<String> filteredNames = selectedLetter == null
        ? names
        : names.where((name) => name.startsWith(selectedLetter!)).toList();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Name Filter"),
          actions: [
            DropdownButton<String>(
              hint: Text("Filter"),
              value: selectedLetter,
              items: [null, ...List.generate(26, (index) => String.fromCharCode(65 + index))]
                  .map((letter) => DropdownMenuItem<String>(
                value: letter,
                child: Text(letter ?? "All"),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedLetter = value;
                });
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: filteredNames.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(filteredNames[index]),
            );
          },
        ),
      ),
    );
  }
}


class SkeletonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true, // Change to false to show actual data
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.purple.shade200), // Border like in the image
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 1,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time & Icon Row
            Row(
              children: [
                CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.green,
                ),
                SizedBox(width: 8),
                Container(
                  width: 80,
                  height: 10,
                  color: Colors.grey,
                ),
                Spacer(),
                Icon(Icons.more_horiz, color: Colors.grey),
              ],
            ),
            SizedBox(height: 10),

            // Title
            Container(
              width: double.infinity,
              height: 15,
              color: Colors.grey,
            ),
            SizedBox(height: 5),

            // Subtitle
            Container(
              width: 120,
              height: 12,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}



class ShimmerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.purple.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time & Icon Row
            Row(
              children: [
                CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(width: 8),
                Container(
                  width: 80,
                  height: 10,
                  color: Colors.grey,
                ),
                Spacer(),
                Container(
                  width: 20,
                  height: 10,
                  color: Colors.grey,
                ),
              ],
            ),
            SizedBox(height: 10),

            // Title
            Container(
              width: double.infinity,
              height: 15,
              color: Colors.grey,
            ),
            SizedBox(height: 5),

            // Subtitle
            Container(
              width: 120,
              height: 12,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}


*/
/*class ShimmerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.purple.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time & Icon Row
            Row(
              children: [
                CircleAvatar(radius: 5, backgroundColor: Colors.grey),
                SizedBox(width: 8),
                _shimmerBox(width: 80, height: 10),
                Spacer(),
                _shimmerBox(width: 20, height: 10),
              ],
            ),
            SizedBox(height: 10),
            // Title
            _shimmerBox(width: double.infinity, height: 15),
            SizedBox(height: 5),
            // Subtitle
            _shimmerBox(width: 120, height: 12),
          ],
        ),
      ),
    );
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
}*//*

*/
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';
class AbcPage extends StatelessWidget {
  const AbcPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(10),
          child: SizedBox(
            width: double.infinity,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          myShimmer(widget: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle
                            ),
                          )),
                          SizedBox(width: 10,),
                          myShimmer(widget: Text("00:00-00:00")),
                        ],
                      ),
                      myShimmer(widget: Container(
                        width: 30,
                        height: 10,
                        color: Colors.grey,
                      ))
                    ],
                  ),
                  SizedBox(height: 12,),
                  myShimmer(widget: Container(width: 250,height: 12,color: Colors.grey,)),
                  SizedBox(height: 12,),
                  myShimmer(widget: Container(width: 150,height: 12,color: Colors.grey,)),
                ],
              ),
            ),
          ),
        );
      },),
    );
  }
  Widget myShimmer({required Widget widget}){
    return Shimmer.fromColors(child: widget, baseColor:  Colors.grey[300]!, highlightColor:  Colors.grey[100]!,);
  }
}


