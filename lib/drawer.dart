import 'package:flutter/material.dart';
import 'package:flutter_mobile/login.dart';
import 'package:flutter_mobile/timetable.dart';
import 'package:google_fonts/google_fonts.dart'; //импорт шрифтов напрямую
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
    Color iconColor =
        HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();

    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      width: 260,
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
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
          // пункт меню в зависимости от состояния авторизации
          Builder(
            builder: (context) {
              return FutureBuilder<Map<String, dynamic>>(
                //получение информации о пользователе
                future: LoginForm().getUserInfo(),
                builder: (context, snapshot) {
                  //проверка наличия токена авторизации
                  if (snapshot.connectionState == ConnectionState.done) {
                    final token = snapshot.data?['token'];
                    final isRegistered = snapshot.data?['isRegistered'];
                    if (token != null) {
                      // пользователь зарегистрирован
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
                          await LoginForm().removeToken();
                          print("User logged out");
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => MyHomePage(),
                              transitionDuration: Duration(seconds: 0),
                            ),
                          );
                        },
                      );
                    } else {
                      if (isRegistered == true) {
                        // пользователь есть в системе, но не вошел в аккаунт
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
                            await FormScreen().logout();
                            print("User logged out");
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => MyHomePage(),
                                transitionDuration: Duration(seconds: 0),
                              ),
                            );
                          },
                        );
                      } else {
                        // пользователь не зарегистрирован
                        return Column(
                          children: [
                            ListTile(
                              title: Center(
                                child: Text(
                                  'ЗАРЕГИСТРИРОВАТЬСЯ',
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
                            ListTile(
                              title: Center(
                                child: Text(
                                  'ВОЙТИ',
                                  style: GoogleFonts.montserrat(
                                    color: textColor,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => LoginForm(), //переходы на страницы авторизации
                                    transitionDuration: Duration(seconds: 0),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      }
                    }
                  }
                  //если данные еще не получены, вернуть пустой контейнер
                  else {
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
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => TimetableScreen(),
                  transitionDuration: Duration(seconds: 0),
                ),
              );
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
            },
          ),
        ],
      ),
    );
  }
}
