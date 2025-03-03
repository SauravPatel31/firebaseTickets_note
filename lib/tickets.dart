import 'package:flutter/material.dart';



class MyAppss extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Stack(
              children: [
                // Border Layer (Slightly Larger)
                ClipPath(
                  clipper: TicketClipper(),
                  child: Container(
                    width: double.infinity, // Full width
                    height: 104, // 2px larger for border effect
                    color: Colors.black, // Border color
                  ),
                ),
                // Inner Ticket Layer
                Positioned(
                  left: 2,
                  top: 2,
                  right: 2, // Ensuring full width with border
                  child: ClipPath(
                    clipper: TicketClipper(),
                    child: Container(
                      width: double.infinity,
                      height: 100, // Actual ticket height
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Suit alteration",style: TextStyle(fontSize: 23),),
                                Container(
                                  child: Row(
                                    children: [
                                      Text("3 days left",style: TextStyle(fontSize: 12,color: Colors.pinkAccent.shade200),),
                                      Container(
                                        height: 40,
                                        color: Colors.teal,
                                        child: Text("4.21.20",style: TextStyle(fontSize: 13),),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.shopping_bag,color: Colors.blue,),
                                        Text("For User 2",style: TextStyle(fontSize: 20,),)
                                      ],
                                    ),
                                    Text("description",style: TextStyle(),)
                                  ],
                                ),
                                Container(
                                  color: Colors.deepPurple,
                                  child: Text("View Details"),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double notchRadius = 10;

    // Start from top left
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.4);

    // Right notch
    path.arcToPoint(
      Offset(size.width, size.height * 0.6),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * 0.6);

    // Left notch
    path.arcToPoint(
      Offset(0, size.height * 0.4),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
