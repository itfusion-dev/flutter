import 'package:flutter/material.dart';
import 'package:flutter_mobile/form.dart';
import 'package:flutter_mobile/login.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    double hue = 1.0;
    double saturation = 0.6;
    double lightness = 0.4;
    Color textColor = HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return AppBar(
      title: Text(
        'Logotype',
        style: GoogleFonts.montserrat(
          color: textColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      actions: <Widget>[
        if (isLandscape)
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // выравнивание к началу строки
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => MyHomePage(),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(right: 40.0),
                  child: Text(
                    'ГЛАВНАЯ',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 40.0),
                child: Text(
                  'О НАС',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 40.0),
                child: Text(
                  'РАСПИСАНИЕ ИГР',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 30.0),
                child: Text(
                  'КОНТАКТЫ',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => FormScreen(),
                        transitionDuration: Duration(seconds: 0),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: textColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                  ),
                  child: Text(
                    'Хочу Поиграть',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => LoginForm(),
                        transitionDuration: Duration(seconds: 0),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0),
                        side: BorderSide(color: textColor,
                          width: 2.0,
                        ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                  ),
                  child: Text(
                    'Войти',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      color: textColor,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        if (!isLandscape)
          GestureDetector(
            onTap: () {
              Scaffold.of(context).openEndDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
              child: Icon(
                Icons.menu,
                color: textColor,
                size: 36.0,
              ),
            ),
          ),
      ],
    );
  }
}
