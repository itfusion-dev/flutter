import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/app_bar.dart';
import '../components/drawer.dart';
import '../components/footer.dart';
import '../components/form.dart';

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

    _drawRotatedEllipse(canvas, center, 144, paint..color = Colors.white);
    _drawRotatedEllipse(canvas, center, 12, paint..color = Colors.white);
    _drawRotatedEllipse(canvas, center, -12, paint..color = Colors.white);
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
        color: Colors.black,
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
                          'ДОБРО ПОЖАЛОВАТЬ В EMPIRE ALMATY MAFIA CLUB',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFD6D5C9),
                            fontSize: 28.0,
                            height: 1.1,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -6,
                        child: Text(
                          'Empire Almaty',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFD6D5C9),
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
                      'ДОБРО ПОЖАЛОВАТЬ В EMPIRE ALMATY!',
                      style: GoogleFonts.silkscreen(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 30.0,
                        height: 1.1,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Присоединяйтесь к самым ярким и захватывающим играм мафии! Испытайте свои навыки убеждения и перехитрите своих противников на этой захватывающей игровой арене.',
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
                      'Вы можете не только зарегистрироваться на предстоящие игры, но вы также можете просмотреть наше захватывающее расписание игр и придумайте свое следующее эпическое предательство.',
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
                      'Встречайте игроков',
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
                      'Присоединяйтесь к растущему сообществу игроков в мафию. Общайтесь, находите друзей и проложите свой путь к вершине рейтинга!',
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
                              child: ClipOval(
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Colors.grey,
                                    BlendMode.saturation,
                                  ),
                                  child: Image.network(
                                    'https://storage.yandexcloud.net/mafia-bucket/Rossolana.png',
                                    width: 80,
                                    height: 80,
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
                                "Г-жа Rossolana",
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
                                "Лучший Дон",
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
                              child: ClipOval(
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Colors.grey,
                                    BlendMode.saturation,
                                  ),
                                  child: Image.network(
                                    'https://storage.yandexcloud.net/mafia-bucket/dancepool.png',
                                    width: 80,
                                    height: 80,
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
                                "Г-н Dancefloor",
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
                                "Лучший Мирный",
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
                              child: ClipOval(
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Colors.grey,
                                    BlendMode.saturation,
                                  ),
                                  child: Image.network(
                                    'https://storage.yandexcloud.net/mafia-bucket/sandy.png',
                                    width: 80,
                                    height: 80,
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
                                "Г-жа Sandy ",
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
                                "Лучший Дон",
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
                        //элементов дизайна сверху вниз
                        Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            CustomPaint(
                              size: Size(400, 320),
                              painter: CustomConvexCornerPainter(),
                            ),
                            Positioned(
                              top: 60,
                              child: ClipOval(
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Colors.grey,
                                    BlendMode.saturation,
                                  ),
                                  child: Image.network(
                                    'https://storage.yandexcloud.net/mafia-bucket/Smoke.png',
                                    width: 80,
                                    height: 80,
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
                                "Г-н smoke",
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
                                "Лучший Черный",
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
                              'Приступим!',
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
                              'Готовы погрузиться в захватывающий мир мафии с Empire ALmaty? Не ждите больше! Зарегистрируйтесь, выберите игру и начните перехитрять своих соперников сегодня!',
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
                            'Присоединиться',
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
            Footer(),
          ],
        ),
      ),
    );
  }
}
