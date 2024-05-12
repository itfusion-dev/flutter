import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'drawer.dart';
import 'app_bar.dart';
import 'form.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//отдельные классы для пользовательского дизайна с функциями прорисовки
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

  void _drawRotatedEllipse(
      Canvas canvas, Offset center, double rotation, Paint paint) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation * pi / 180);
    canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: 370, height: 185), paint);
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

  void _drawRotatedEllipse(Canvas canvas, Offset center, double rotation,
      double width, double height, Paint paint) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation * pi / 180);
    canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: width, height: height),
        paint);
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
      ..color = Color(0xFFC4C3B5) // Border color
      ..style = PaintingStyle.stroke // Stroke style
      ..strokeWidth = 2; // Width of the border

    final path = Path();
    final double concaveRadius = 30.0;
    final double convexRadius = size.width / 2;

    path.moveTo(concaveRadius, 0);
    path.lineTo(size.width - convexRadius, 0);

    path.arcToPoint(
      Offset(size.width, convexRadius),
      radius: Radius.circular(convexRadius),
      clockwise: true,
    );

    path.lineTo(size.width, size.height - concaveRadius);
    path.arcToPoint(
      Offset(size.width - concaveRadius, size.height),
      radius: Radius.circular(concaveRadius),
      clockwise: true,
    );

    path.lineTo(convexRadius, size.height);

    path.arcToPoint(
      Offset(0, size.height - convexRadius),
      radius: Radius.circular(convexRadius),
      clockwise: true,
    );

    path.lineTo(0, concaveRadius);

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
      ..color = Color(0xFFC4C3B5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();

    final squareSize = min(size.width, size.height);
    final offset =
        Offset((size.width - squareSize) / 2, (size.height - squareSize) / 2);

    final rect = Rect.fromLTWH(offset.dx, offset.dy, squareSize, squareSize);
    final radius = Radius.circular(30);

    path.addRRect(RRect.fromRectAndRadius(rect, radius));

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
      ..color = Color(0xFFC4C3B5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final Path path = Path();

    final double topConvexRadius = size.width / 2;
    final double bottomConvexRadius = 30.0;
    path.moveTo(0, size.height - bottomConvexRadius);

    path.arcToPoint(
      Offset(bottomConvexRadius, size.height),
      radius: Radius.circular(bottomConvexRadius),
      clockwise: false,
    );

    path.lineTo(size.width - bottomConvexRadius, size.height);
    path.arcToPoint(
      Offset(size.width, size.height - bottomConvexRadius),
      radius: Radius.circular(bottomConvexRadius),
      clockwise: false,
    );

    path.lineTo(size.width, topConvexRadius);
    path.arcToPoint(
      Offset(size.width - topConvexRadius, 0),
      radius: Radius.circular(topConvexRadius),
      clockwise: false,
    );

    path.lineTo(topConvexRadius, 0);
    path.arcToPoint(
      Offset(0, topConvexRadius),
      radius: Radius.circular(topConvexRadius),
      clockwise: false,
    );

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
      ..color = Color(0xFFC4C3B5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final Path path = Path();

    final double largeConvexRadius = size.width / 2;
    final double smallConvexRadius = 30.0;
    path.moveTo(0, size.height - largeConvexRadius);

    path.arcToPoint(
      Offset(largeConvexRadius, size.height),
      radius: Radius.circular(largeConvexRadius),
      clockwise: false,
    );

    path.lineTo(size.width - largeConvexRadius, size.height);
    path.arcToPoint(
      Offset(size.width, size.height - largeConvexRadius),
      radius: Radius.circular(largeConvexRadius),
      clockwise: false,
    );

    path.lineTo(size.width, smallConvexRadius);
    path.arcToPoint(
      Offset(size.width - smallConvexRadius, 0),
      radius: Radius.circular(smallConvexRadius),
      clockwise: false,
    );

    path.lineTo(largeConvexRadius, 0);
    path.arcToPoint(
      Offset(0, largeConvexRadius),
      radius: Radius.circular(largeConvexRadius),
      clockwise: false,
    );

    path.lineTo(0, size.height - largeConvexRadius);

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _MyHomePageState extends State<MyHomePage> {
  bool isExpanded = false;
  String responseText = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double hue = 1.0;
    double saturation = 0.6;
    double lightness = 0.4;
    Color textColor =
        HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
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
                        //пользовательский виджет для отображения
                        //элементов дизацна сверху вниз
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
                    //кнопка для регистрации
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12.0),
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
            //футер
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
