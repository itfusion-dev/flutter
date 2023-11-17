import 'package:flutter/material.dart';
import 'app_bar.dart';
import 'drawer.dart';
import 'login.dart';
import 'package:google_fonts/google_fonts.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double hue = 1.0;
    double saturation = 0.6;
    double lightness = 0.4;
    Color textColor = HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();

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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Регистрация',
                            style: GoogleFonts.montserrat(
                              fontSize: 2.25 * 16.0,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).brightness == Brightness.light
                                  ? textColor
                                  : Colors.red,
                              decoration: TextDecoration.underline,
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
                              MaterialPageRoute(builder: (context) => LoginForm()),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              'Вход',
                              style: GoogleFonts.montserrat(
                                fontSize: 2.25 * 16.0,
                                color: Theme.of(context).brightness == Brightness.light
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
                          // Add more Text widgets or other widgets as needed
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 40.0, right: 40.0),
                      margin: EdgeInsets.only(top: 5.0),
                      child: TextField(
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
                            // Add more Text widgets or other widgets as needed
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 40.0, right: 40.0),
                      margin: EdgeInsets.only(top: 5.0),
                      child: TextField(
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
                            // Add more Text widgets or other widgets as needed
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 40.0, right: 40.0),
                      margin: EdgeInsets.only(top: 5.0),
                      child: TextField(
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
                            // Add more Text widgets or other widgets as needed
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 40.0, right: 40.0),
                      margin: EdgeInsets.only(top: 5.0),
                      child: TextField(
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
                      child: ElevatedButton(
                        onPressed: () {
                          // Add the logic for the button press
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: textColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
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
