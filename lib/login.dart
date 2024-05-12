import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'app_bar.dart';
import 'drawer.dart';
import 'form.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  //проверка на авторизированного пользователя
  Future<void> login() async {
    String email = emailController.text;
    String password = passwordController.text;

    final url = Uri.parse("https://mafia.test.itfusion.xyz/api/users/login");

    //post запрос с телом в формате json - если пользователь есть в системе
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );
      //выдать токен при успешном запросе
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic>? responseData = json.decode(response.body);

        if (responseData != null && responseData.containsKey('accessToken')) {
          await saveToken(responseData['accessToken']);
          print("Login successful ${response.body}");
        }
        //обработка ошибок
        else {
          print(
              "Invalid response format: accessToken not found ${response.body}");
          print("Full response body: ${response.body}");
        }
      } else {
        print("Login failed with status code: ${response.statusCode}");
        print("Error response body: ${response.body}");
      }
    } catch (error) {
      print("Error during login: $error");
    }
  }

  //сохранение токена
  Future<void> saveToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('accessToken', token);
  }
  //получение информации о пользователе по токену
  Future<Map<String, dynamic>> getUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('accessToken');
    bool isRegistered = preferences.getBool('registered') ?? false;

    return {
      'token': token,
      'isRegistered': isRegistered,
    };
  }

  Future<void> removeToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('accessToken');
    print("User logged out");
  }

  @override
  Widget build(BuildContext context) {
    double hue = 1.0;
    double saturation = 0.6;
    double lightness = 0.4;
    Color textColor =
        HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();

    return Scaffold(
      appBar: const MyAppBar(),
      endDrawer: const CustomDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = 600;
          if (constraints.maxWidth < 1200) {
            maxWidth = constraints.maxWidth;
          }
          return Container(
            color: Colors.white,
            constraints: BoxConstraints(
              maxWidth: maxWidth,
            ),
            child: Container(
              margin: EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height - kToolbarHeight,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => FormScreen(),
                                transitionDuration: Duration(seconds: 0),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'Регистрация',
                              style: GoogleFonts.montserrat(
                                fontSize: 30,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.grey
                                    : textColor,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 3,
                          height: 40,
                          color: textColor,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => LoginForm(),
                                transitionDuration: Duration(seconds: 0),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              'Вход',
                              style: GoogleFonts.montserrat(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                decorationColor: textColor,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? textColor
                                    : Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 40.0),
                      margin: EdgeInsets.only(top: 17.0),
                      child: Column(
                        children: [
                          Text(
                            'Эл. почта:',
                            style: GoogleFonts.montserrat(
                              fontSize: 22.0,
                              color: textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 40.0, right: 40.0),
                      margin: EdgeInsets.only(top: 5.0),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(231, 231, 231, 1.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'example@email.com',
                          labelStyle: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        style: GoogleFonts.montserrat(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 40.0),
                      margin: EdgeInsets.only(top: 25.0),
                      child: Column(
                        children: [
                          Text(
                            'Пароль:',
                            style: GoogleFonts.montserrat(
                              fontSize: 22.0,
                              color: textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 40.0, right: 40.0),
                      margin: EdgeInsets.only(top: 5.0),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(231, 231, 231, 1.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'Пароль',
                          labelStyle: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        style: GoogleFonts.montserrat(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 160.0, right: 160.0),
                      margin: EdgeInsets.only(top: 35.0),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          login();
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => MyHomePage(),
                              transitionDuration: Duration(seconds: 0),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: textColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12.0),
                        ),
                        child: Text(
                          'Войти',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
