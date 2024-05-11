import 'package:flutter/material.dart';
import 'package:flutter_mobile/form.dart';
import 'package:flutter_mobile/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_page.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  String? username;
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  Future<void> checkToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('accessToken');

    if (token != null) {
      await getUserProfile(token);
    } else {
      setState(() {
        username = null;
      });
    }
  }

  Future<void> getUserProfile(String token) async {
    final url = Uri.parse("https://mafia.test.itfusion.xyz/api/users/profile");
    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        username = responseData['username'];
      });
    } else {
      print("Failed to fetch user profile");
    }
  }

  @override
  Widget build(BuildContext context) {
    double hue = 1.0;
    double saturation = 0.6;
    double lightness = 0.4;
    Color textColor =
        HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (username != null)
                InkWell(
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                  ),
                  child: Text(
                    username != null ? '$username' : 'Хочу Поиграть',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              if (username == null)
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
                        side: BorderSide(
                          color: textColor,
                          width: 2.0,
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
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
