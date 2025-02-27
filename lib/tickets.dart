import 'package:flutter/material.dart';



class MyAppss extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
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
                    color: Colors.white, // Inner ticket color
                  ),
                ),
              ),
            ],
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
