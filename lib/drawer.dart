import 'package:flutter/material.dart';
import 'package:flutter_mobile/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'form.dart';
import 'home_page.dart';
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color textColor = const Color.fromRGBO(10, 16, 13, 1.0);
    double hue = 1.0;
    double saturation = 0.6;
    double lightness = 0.4;
    Color iconColor = HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      width: 220,
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: iconColor,
              ),
              iconSize: 36.0,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          ListTile(
            title: Center(
              child: Text(
                'ГЛАВНАЯ',
                style: GoogleFonts.montserrat(
                  color: textColor,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),
          ListTile(
            title: Center(
              child: Text(
                'ХОЧУ ПОИГРАТЬ',
                style: GoogleFonts.montserrat(
                  color: textColor,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormScreen()),
              );
            },
          ),
          ListTile(
            title: Center(
              child: Text(
                'ВХОД',
                style: GoogleFonts.montserrat(
                  color: textColor,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginForm()),
              );
            },
          ),
          ListTile(
            title: Center(
              child: Text(
                'О НАС',
                style: GoogleFonts.montserrat(
                  color: textColor,
                ),
              ),
            ),
            onTap: () {
              // Handle the tap on drawer item 2
            },
          ),
          ListTile(
            title: Center(
              child: Text(
                'РАСПИСАНИЕ ИГР',
                style: GoogleFonts.montserrat(
                  color: textColor,
                ),
              ),
            ),
            onTap: () {
              // Handle the tap on drawer item 4
            },
          ),
          ListTile(
            title: Center(
              child: Text(
                'КОНТАКТЫ',
                style: GoogleFonts.montserrat(
                  color: textColor,
                ),
              ),
            ),
            onTap: () {
              // Handle the tap on drawer item 4
            },
          ),
        ],
      ),
    );
  }
}
