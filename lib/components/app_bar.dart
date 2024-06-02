import 'package:flutter/material.dart';
import 'package:flutter_mobile/pages/leaderboard.dart';
import 'package:flutter_mobile/utils/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../pages/home_page.dart';
import '../pages/timetable.dart';
import 'form.dart';
import 'login.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  String? username;
  String playButtonText = 'Хочу Поиграть';

  @override
  void initState() {
    super.initState();
    checkToken(); // проверка токена при инициализации
  }

  // асинхронная функция для проверки токена
  Future<void> checkToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('accessToken');

    // если токен есть, вызываем функцию для получения профиля пользователя
    if (token != null) {
      await getUserProfile(token);
    } else {
      setState(() {
        username = null;
        updatePlayButtonText();
      });
    }
  }

  // асинхронная функция для получения профиля пользователя
  Future<void> getUserProfile(String token) async {
    final url = Uri.parse("https://mafia.yc.itfusion.xyz/api/users/profile");
    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        username = responseData['username'];
        updatePlayButtonText();
      });
    } else {
      print("Failed to fetch user profile");
      setState(() {
        username = null;
        updatePlayButtonText();
      });
    }
  }

  void updatePlayButtonText() {
    setState(() {
      playButtonText = username != null ? username! : 'Хочу Поиграть';
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    Widget playButton() {
      return Container(
        padding: EdgeInsets.only(right: 15.0),
        child: playButtonText != 'Хочу Поиграть'
            ? Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13.0),
                ),
                child: PopupMenuButton<String>(
                  offset: Offset(0,
                      30),
                  onSelected: (String result) async {
                    if (result == 'Выйти') {
                      await AuthService().logout();
                      await AuthService().removeToken();
                      print("User logged out");
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => MyHomePage(),
                          transitionDuration: Duration(seconds: 0),
                        ),
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'Выйти',
                      child: Text(
                        'Выйти',
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                  child: ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                    ),
                    child: Text(
                      playButtonText,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              )
            : ElevatedButton(
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
                  backgroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13.0),
                    side: BorderSide(color: Colors.white),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                ),
                child: Text(
                  playButtonText,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
      );
    }

    Widget loginButton() {
      return Container(
        padding: EdgeInsets.only(left: 20.0, right: 10.0),
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
              side: BorderSide(
                color: Colors.black87,
                width: 2.0,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
          ),
          child: Text(
            'Войти',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              fontSize: 15.0,
            ),
          ),
        ),
      );
    }

    Widget textLink(String text, VoidCallback onPressed) {
      return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      );
    }

    return AppBar(
      title: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://storage.yandexcloud.net/mafia-bucket/favicon.ico'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      backgroundColor: Colors.black87,
      automaticallyImplyLeading: false,
      elevation: 0,
      actions: <Widget>[
        if (isLandscape)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textLink('ГЛАВНАЯ', () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => MyHomePage(),
                    transitionDuration: Duration(seconds: 0),
                  ),
                );
              }),
              SizedBox(width: 10),
              textLink('РАСПИСАНИЕ', () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => TimetableScreen(),
                    transitionDuration: Duration(seconds: 0),
                  ),
                );
              }),
              SizedBox(width: 10),
              textLink('РЕЙТИНГ ИГРОКОВ', () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => LeaderboardScreen(),
                    transitionDuration: Duration(seconds: 0),
                  ),
                );
              }),
              if (username == null) loginButton(),
              playButton(),
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
                color: Colors.white,
                size: 36.0,
              ),
            ),
          ),
      ],
    );
  }
}
