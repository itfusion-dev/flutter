import 'package:flutter/material.dart';
import 'package:flutter_mobile/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'form.dart';
import 'home_page.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => MyHomePage(),
                  transitionDuration: Duration(seconds: 0),
                ),
              );
            },
          ),
          Builder(
            builder: (context) {
              return FutureBuilder<String?>(
                future: LoginForm().readToken(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final token = snapshot.data;
                    if (token != null) {
                      print("User Token: $token");
                      return ListTile(
                        title: Center(
                          child: Text(
                            'ВЫЙТИ',
                            style: GoogleFonts.montserrat(
                              color: textColor,
                            ),
                          ),
                        ),
                        onTap: () async {
                          await LoginForm().removeToken(); // Remove the token
                          print("User logged out");
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => MyHomePage(),
                              transitionDuration: Duration(seconds: 0),
                            ),
                          );
                        },
                      );
                    } else {
                      return Column(
                        children: [
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
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => LoginForm(),
                                  transitionDuration: Duration(seconds: 0),
                                ),
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
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => FormScreen(),
                                  transitionDuration: Duration(seconds: 0),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }
                  } else {
                    return Container();
                  }
                },
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
              // Handle the tap on drawer item
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
              // Handle the tap on drawer item
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
              // Handle the tap on drawer item
            },
          ),
        ],
      ),
    );
  }
}
