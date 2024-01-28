import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'drawer.dart';
import 'app_bar.dart';
import 'form.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  //userInfo ? HasInfoComponent : Nothing
  @override

  State<MyHomePage> createState() => _MyHomePageState();
}

class EllipsePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final Offset center = Offset(size.width / 2, size.height / 2);

    _drawRotatedEllipse(canvas, center, 144, paint..color = Colors.black);
    _drawRotatedEllipse(canvas, center, 12, paint..color = Colors.black);
    _drawRotatedEllipse(canvas, center, -12, paint..color = Colors.black);
  }

  void _drawRotatedEllipse(Canvas canvas, Offset center, double rotation, Paint paint) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation * pi / 180);
    canvas.drawOval(Rect.fromCenter(center: Offset.zero, width: 370, height: 185), paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DoubleEllipsePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Color(0xFFAB9090);

    final Offset center = Offset(size.width / 2, size.height / 2);

    _drawRotatedEllipse(canvas, center, -124, 377.967, 199.267, paint);

    _drawRotatedEllipse(canvas, center, -26, 377.967, 199.267, paint);
  }

  void _drawRotatedEllipse(Canvas canvas, Offset center, double rotation, double width, double height, Paint paint) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation * pi / 180);
    canvas.drawOval(Rect.fromCenter(center: Offset.zero, width: width, height: height), paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class LeafLikePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFCBCABB)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Color(0xFFC4C3B5)  // Border color
      ..style = PaintingStyle.stroke // Stroke style
      ..strokeWidth = 2; // Width of the border

    // Define the path for the square with convex and concave corners
    final path = Path();

    // Concave corners radius
    final double concaveRadius = 30.0;
    // Convex corners are drawn with a curve that extends to half of the square size
    final double convexRadius = size.width / 2;

    // Move to the start of the top-left concave corner arc
    path.moveTo(concaveRadius, 0);

    // Top side to the start of the top-right convex corner
    path.lineTo(size.width - convexRadius, 0);

    // Top-right convex corner
    path.arcToPoint(
      Offset(size.width, convexRadius),
      radius: Radius.circular(convexRadius),
      clockwise: true,
    );

    // Right side to the start of the bottom-right concave corner arc
    path.lineTo(size.width, size.height - concaveRadius);

    // Bottom-right concave corner
    path.arcToPoint(
      Offset(size.width - concaveRadius, size.height),
      radius: Radius.circular(concaveRadius),
      clockwise: true,
    );

    // Bottom side to the start of the bottom-left convex corner
    path.lineTo(convexRadius, size.height);

    // Bottom-left convex corner
    path.arcToPoint(
      Offset(0, size.height - convexRadius),
      radius: Radius.circular(convexRadius),
      clockwise: true,
    );

    // Left side to the start of the top-left concave corner arc
    path.lineTo(0, concaveRadius);

    // Top-left concave corner
    path.arcToPoint(
      Offset(concaveRadius, 0),
      radius: Radius.circular(concaveRadius),
      clockwise: true,
    );

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class RoundedSquarePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFCBCABB)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Color(0xFFC4C3B5)  // Border color
      ..style = PaintingStyle.stroke // Stroke style
      ..strokeWidth = 2; // Width of the border

    // Define the path for the square
    final path = Path();

    // Calculate the size of the square. We're making it as large as possible
    // while fitting in the given size, and keeping it centered
    final squareSize = min(size.width, size.height);
    final offset = Offset((size.width - squareSize) / 2, (size.height - squareSize) / 2);

    // Define a rectangle with rounded corners
    final rect = Rect.fromLTWH(offset.dx, offset.dy, squareSize, squareSize);
    final radius = Radius.circular(30);

    // Add the rounded rectangle to the path
    path.addRRect(RRect.fromRectAndRadius(rect, radius));

    // Draw the path
    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CakePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFCBCABB)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Color(0xFFC4C3B5)  // Border color
      ..style = PaintingStyle.stroke // Stroke style
      ..strokeWidth = 2; // Width of the border

    final Path path = Path();

    // Larger radius for the top convex corners
    final double topConvexRadius = size.width / 2; // Adjust for desired curvature
    // Smaller radius for the bottom convex corners
    final double bottomConvexRadius = 30.0; // Adjust for desired curvature

    // Start from the bottom left corner
    path.moveTo(0, size.height - bottomConvexRadius);

    // Bottom left convex corner
    path.arcToPoint(
      Offset(bottomConvexRadius, size.height),
      radius: Radius.circular(bottomConvexRadius),
      clockwise: false,
    );

    // Bottom side to bottom right convex corner
    path.lineTo(size.width - bottomConvexRadius, size.height);
    path.arcToPoint(
      Offset(size.width, size.height - bottomConvexRadius),
      radius: Radius.circular(bottomConvexRadius),
      clockwise: false,
    );

    // Right side to top right convex corner
    path.lineTo(size.width, topConvexRadius);
    path.arcToPoint(
      Offset(size.width - topConvexRadius, 0),
      radius: Radius.circular(topConvexRadius),
      clockwise: false,
    );

    // Top side to top left convex corner
    path.lineTo(topConvexRadius, 0);
    path.arcToPoint(
      Offset(0, topConvexRadius),
      radius: Radius.circular(topConvexRadius),
      clockwise: false,
    );

    // Close the path by connecting back to the starting point
    path.lineTo(0, size.height - bottomConvexRadius);

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CustomConvexCornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFCBCABB)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Color(0xFFC4C3B5)  // Border color
      ..style = PaintingStyle.stroke // Stroke style
      ..strokeWidth = 2; // Width of the border

    final Path path = Path();

    // Radius for the 200-degree convex corners
    final double largeConvexRadius = size.width / 2; // Adjust for desired curvature
    // Radius for the 30-degree convex corner
    final double smallConvexRadius = 30.0; // Adjust for desired curvature

    // Start from the bottom left corner
    path.moveTo(0, size.height - largeConvexRadius);

    // Bottom left convex corner (200 degrees)
    path.arcToPoint(
      Offset(largeConvexRadius, size.height),
      radius: Radius.circular(largeConvexRadius),
      clockwise: false,
    );

    // Bottom side to bottom right convex corner (200 degrees)
    path.lineTo(size.width - largeConvexRadius, size.height);
    path.arcToPoint(
      Offset(size.width, size.height - largeConvexRadius),
      radius: Radius.circular(largeConvexRadius),
      clockwise: false,
    );

    // Right side to top right convex corner (30 degrees)
    path.lineTo(size.width, smallConvexRadius);
    path.arcToPoint(
      Offset(size.width - smallConvexRadius, 0),
      radius: Radius.circular(smallConvexRadius),
      clockwise: false,
    );

    // Top side to top left convex corner (200 degrees)
    path.lineTo(largeConvexRadius, 0);
    path.arcToPoint(
      Offset(0, largeConvexRadius),
      radius: Radius.circular(largeConvexRadius),
      clockwise: false,
    );

    // Close the path by connecting back to the starting point
    path.lineTo(0, size.height - largeConvexRadius);

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _MyHomePageState extends State<MyHomePage> {
  String responseText = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse('https://mafia.test.itfusion.xyz/api/users'));

    if (response.statusCode == 200) {
      setState(() {
        responseText = response.body;
      });
    } else {
      setState(() {
        responseText = 'Error: ${response.statusCode}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double hue = 1.0;
    double saturation = 0.6;
    double lightness = 0.4;
    Color textColor = HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(),
      endDrawer: const CustomDrawer(),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              child: Padding(
                padding: EdgeInsets.only(top: 70),
                child: Container(
                  width: 200,
                  height: 200,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: CustomPaint(
                          painter: EllipsePainter(),
                        ),
                      ),
                      Positioned(
                        child: Text(
                          'ДОБРО ПОЖАЛОВАТЬ В MAFIA CLUB',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            color: textColor,
                            fontSize: 28.0,
                            height: 1.1,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -6,
                        child: Text(
                          'Mafia Madness',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            color: textColor,
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 70),
            Container(
              color: Color(0xFFD6D5C9),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 50),
                    Text(
                      'WELCOME TO MAFIA MADNESS!',
                      style: GoogleFonts.silkscreen(
                        fontWeight: FontWeight.w500,
                        color: textColor,
                        fontSize: 30.0,
                        height: 1.1,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Join the wildest, pulse-pounding online mafia games available! '
                          'Put your cunning skills to the test and outwit your opponents '
                          'in this thrilling gaming arena.',
                      style: GoogleFonts.archivo(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0A100D),
                        fontSize: 19.0,
                        height: 1.5,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: 25),
                    // Text(
                    //   responseText,
                    //   textAlign: TextAlign.center,
                    //   style: GoogleFonts.archivo(
                    //     fontWeight: FontWeight.w500,
                    //     color: Color(0xFF0A100D),
                    //     fontSize: 18.0,
                    //     height: 1.5,
                    //   ),
                    //   softWrap: true,
                    //   overflow: TextOverflow.visible,
                    // ),
                    // SizedBox(height: 25),
                    Text(
                      'Not only can you register for upcoming games, but you can also browse '
                          'our exhilarating game schedule and plot out your next epic betrayal.',
                      style: GoogleFonts.archivo(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0A100D),
                        fontSize: 19.0,
                        height: 1.5,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
            Container(
              color: Color(0xFFD6D5C9),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 50),
                    Text(
                      'MEET THE GAMERS',
                      style: GoogleFonts.silkscreen(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0A100D),
                        fontSize: 30.0,
                        height: 1.1,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Join a growing community of Mafia enthusiasts. '
                      'Bond, deceive, and conquer your way through'
                      ' our captivating games!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.archivo(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0A100D),
                        fontSize: 19.0,
                        height: 1.5,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            CustomPaint(
                              size: Size(400, 320),
                              painter: LeafLikePainter(),
                            ),
                            Positioned(
                              top: 60,
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage('web/assets/chipi.jpeg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 60 + 80 + 50,
                              child: SizedBox(height: 50),
                            ),
                            Positioned(
                              top: 60 + 55 + 50,
                              child: Text(
                                "CHIPI THE KITTEN",
                                style: GoogleFonts.silkscreen(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF0A100D),
                                  fontSize: 21.0,
                                  height: 1.1,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                            Positioned(
                              top: 60 + 95 + 50,
                              child: Text(
                                "Influencer",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.archivo(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF0A100D),
                                  fontSize: 19.0,
                                  height: 1.5,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            CustomPaint(
                              size: Size(400, 320),
                              painter: RoundedSquarePainter(),
                            ),
                            Positioned(
                              top: 60,
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage('web/assets/chipi.jpeg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 60 + 80 + 50,
                              child: SizedBox(height: 50),
                            ),
                            Positioned(
                              top: 60 + 55 + 50,
                              child: Text(
                                "Cleo 'The Spy' Bishop",
                                style: GoogleFonts.silkscreen(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF0A100D),
                                  fontSize: 21.0,
                                  height: 1.1,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                            Positioned(
                              top: 60 + 95 + 50,
                              child: Text(
                                "Spy",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.archivo(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF0A100D),
                                  fontSize: 19.0,
                                  height: 1.5,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            CustomPaint(
                              size: Size(400, 320),
                              painter: CakePainter(),
                            ),
                            Positioned(
                              top: 60,
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage('web/assets/chipi.jpeg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 60 + 80 + 50,
                              child: SizedBox(height: 50),
                            ),
                            Positioned(
                              top: 60 + 55 + 50,
                              child: Text(
                                "Frank 'The Snitch' Rizzo",
                                style: GoogleFonts.silkscreen(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF0A100D),
                                  fontSize: 21.0,
                                  height: 1.1,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                            Positioned(
                              top: 60 + 95 + 50,
                              child: Text(
                                "Enforcer",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.archivo(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF0A100D),
                                  fontSize: 19.0,
                                  height: 1.5,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            CustomPaint(
                              size: Size(400, 320),
                              painter: CustomConvexCornerPainter(),
                            ),
                            Positioned(
                              top: 60,
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage('web/assets/chipi.jpeg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 60 + 80 + 50,
                              child: SizedBox(height: 50),
                            ),
                            Positioned(
                              top: 60 + 55 + 50,
                              child: Text(
                                "Vera 'The Enforcer' Miles",
                                style: GoogleFonts.silkscreen(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF0A100D),
                                  fontSize: 21.0,
                                  height: 1.1,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                            Positioned(
                              top: 60 + 95 + 50,
                              child: Text(
                                "Snitch",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.archivo(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF0A100D),
                                  fontSize: 19.0,
                                  height: 1.5,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Color(0xFFD6D5C9),
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: FixedColumnWidth(80.0),
                  1: FixedColumnWidth(150.0),
                  2: FixedColumnWidth(30.0),
                },
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'October 18, 2023',
                            style: GoogleFonts.archivo(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0A100D),
                              fontSize: 19.0,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Turf War Tuesday',
                            style: GoogleFonts.archivo(
                              fontWeight: FontWeight.w500,
                              fontSize: 19.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.arrow_forward_outlined,
                            size: 36.0,
                            color: Color(0xFF0A100D),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Color(0xFFC4C3B5)),
                      ),
                    ),
                    children: List.generate(
                      3, // Number of columns in the table
                          (_) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 23.0),
                          child: SizedBox(height: 20.0),
                      ),
                    ),
                  ),
                  TableRow(
                    children: [
                      SizedBox(height: 10.0),
                      SizedBox(height: 5.0),
                      SizedBox(height: 5.0),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'October 20, 2023',
                            style: GoogleFonts.archivo(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0A100D),
                              fontSize: 19.0,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Whack-A-Rat Thursday',
                            style: GoogleFonts.archivo(
                              fontWeight: FontWeight.w500,
                              fontSize: 19.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.arrow_forward_outlined,
                            size: 36.0,
                            color: Color(0xFF0A100D),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Color(0xFFC4C3B5)),
                      ),
                    ),
                    children: List.generate(
                      3, // Number of columns in the table
                          (_) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.0),
                        child: SizedBox(height: 20.0),
                      ),
                    ),
                  ),
                  TableRow(
                    children: [
                      SizedBox(height: 10.0),
                      SizedBox(height: 5.0),
                      SizedBox(height: 5.0),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'October 22, 2023',
                            style: GoogleFonts.archivo(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0A100D),
                              fontSize: 19.0,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Sinister Saturday',
                            style: GoogleFonts.archivo(
                              fontWeight: FontWeight.w500,
                              fontSize: 19.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.arrow_forward_outlined,
                            size: 36.0,
                            color: Color(0xFF0A100D),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Color(0xFFC4C3B5)),
                      ),
                    ),
                    children: List.generate(
                      3, // Number of columns in the table
                          (_) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.0),
                        child: SizedBox(height: 20.0),
                      ),
                    ),
                  ),
                  TableRow(
                    children: [
                      SizedBox(height: 10.0),
                      SizedBox(height: 5.0),
                      SizedBox(height: 5.0),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'October 27, 2023',
                            style: GoogleFonts.archivo(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0A100D),
                              fontSize: 19.0,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Double-Cross Wednesday',
                            style: GoogleFonts.archivo(
                              fontWeight: FontWeight.w500,
                              fontSize: 19.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.arrow_forward_outlined,
                            size: 36.0,
                            color: Color(0xFF0A100D),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Color(0xFFC4C3B5)),
                      ),
                    ),
                    children: List.generate(
                      3, // Number of columns in the table
                          (_) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.0),
                        child: SizedBox(height: 20.0),
                      ),
                    ),
                  ),
                  TableRow(
                    children: [
                      SizedBox(height: 10.0),
                      SizedBox(height: 5.0),
                      SizedBox(height: 5.0),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'October 29, 2023',
                            style: GoogleFonts.archivo(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0A100D),
                              fontSize: 19.0,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Frenemy Friday',
                            style: GoogleFonts.archivo(
                              fontWeight: FontWeight.w500,
                              fontSize: 19.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.arrow_forward_outlined,
                            size: 36.0,
                            color: Color(0xFF0A100D),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xFFD6D5C9),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 50),
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 140.0, left: 250.0),
                          child: CustomPaint(
                            painter: DoubleEllipsePainter(),
                          ),
                        ),
                        SizedBox(height: 25),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'get started',
                              style: GoogleFonts.silkscreen(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF0A100D),
                                fontSize: 32.0,
                                height: 1.1,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(height: 25),
                            Text(
                              'Ready to dive into the gripping world of Mafia Madness? '
                                  'Don’t wait any longer! Register, pick your game, and '
                                  'start outsmarting your rivals today!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.archivo(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF0A100D),
                                fontSize: 18.0,
                                height: 1.5,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.only(top: 20.0),
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => FormScreen(),
                              transitionDuration: Duration(seconds: 0),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Sign up now',
                            style: GoogleFonts.archivo(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFD6D5C9),
                              fontSize: 19.0,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 50),
                    Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Расписание игр',
                              style: GoogleFonts.archivo(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 16.0,
                                height: 1.1,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Предстоящие турниры',
                              style: GoogleFonts.archivo(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 16.0,
                                height: 1.1,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Рейтинг игроков',
                              style: GoogleFonts.archivo(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 16.0,
                                height: 1.1,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Записаться на игры',
                              style: GoogleFonts.archivo(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 16.0,
                                height: 1.1,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(height: 45),
                            Text(
                              'Support',
                              style: GoogleFonts.archivo(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 16.0,
                                height: 1.1,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(height: 15),
                            Text(
                              'FAQ',
                              style: GoogleFonts.archivo(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 16.0,
                                height: 1.1,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Tutorial',
                              style: GoogleFonts.archivo(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 16.0,
                                height: 1.1,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Contact',
                              style: GoogleFonts.archivo(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 16.0,
                                height: 1.1,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(height: 45),
                            Text(
                              'Connect',
                              style: GoogleFonts.archivo(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 16.0,
                                height: 1.1,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(height: 25),
                            Text(
                              'Forum',
                              style: GoogleFonts.archivo(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 16.0,
                                height: 1.1,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Blog',
                              style: GoogleFonts.archivo(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 16.0,
                                height: 1.1,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Social',
                              style: GoogleFonts.archivo(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 16.0,
                                height: 1.1,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(height: 40),
                            Divider(
                              color: Color(0xFF262626),
                              thickness: 1.0,
                              height: 20.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.facebook, color: Colors.white, size: 40),
                        SizedBox(width: 20),
                        Icon(Icons.telegram, color: Colors.white, size: 40),
                        SizedBox(width: 20),
                        Icon(Icons.watch, color: Colors.white, size: 40),
                        SizedBox(width: 20),
                        Icon(Icons.wallet, color: Colors.white, size: 40),
                      ],
                    ),
                SizedBox(height: 25),
                Center(
                  child: Text(
                    '© Mafia Madness 2023',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.archivo(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 18.0,
                      height: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
