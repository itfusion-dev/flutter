import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_bar.dart';
import 'drawer.dart';
import 'home_page.dart';
import 'login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http; //пакет для обработки http запросов

class FormScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  // функция для выполнения регистрации пользователя
  Future<void> register(BuildContext context) async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String username = usernameController.text;

    final url = Uri.parse("https://mafia.yc.itfusion.xyz/api/users/signup");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "username": username,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic>? responseData = json.decode(response.body);

        if (responseData != null && responseData.containsKey('accessToken')) {
          await saveToken(responseData['accessToken']);

          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.setBool('registered', true);

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Registration Successful"),
                content: Text("You have been successfully registered."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );

          print("Registration successful ${response.body}");
        } else {
          print("Invalid response format: accessToken not found ${response.body}");
          print("Full response body: ${response.body}");
        }
      } else {
        print("Registration failed with status code: ${response.statusCode}");
        print("Error response body: ${response.body}");
      }
    } catch (error) {
      print("Error during registration: $error");
    }
  }

  //функция сохранения токена в системе
  Future<void> saveToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('accessToken', token);
  }

//проверка на наличие пользователя в системе
  Future<bool?> isRegistered() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('registered') ?? false;
  }

  //функция выхода из аккаунта - удаление токена и проверки
  Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('registered');
    await preferences.remove('accessToken');
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
              //расчет при альбомной ориентации экрана
              height: MediaQuery.of(context).size.height - kToolbarHeight,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //если находимся на странице регистрации
                        //жирный текст красного цвета
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Регистрация',
                            style: GoogleFonts.montserrat(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? textColor
                                  : Colors.red,
                              decoration: TextDecoration.underline,
                              decorationColor: textColor,
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
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.grey
                                    : textColor,
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
                            'Полное имя:',
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
                        controller: nameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(231, 231, 231, 1.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'Введите имя',
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
                            'Логин:',
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
                        controller: usernameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(231, 231, 231, 1.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'Логин',
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
                      padding: EdgeInsets.only(left: 80.0, right: 80.0),
                      margin: EdgeInsets.only(top: 35.0),
                      width: double.infinity,
                      //при успешной регистрации переход на основную страницу
                      child: ElevatedButton(
                        onPressed: () {
                          register(context);
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
                          'Зарегистрироваться',
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
