import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'app_bar.dart';
import 'drawer.dart';

class TimetableScreen extends StatefulWidget {
  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  double hue = 1.0;
  double saturation = 0.6;
  double lightness = 0.4;
  List<dynamic> gamesData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://mafia.test.itfusion.xyz/api/games'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> gamesList = responseData['games'];
      setState(() {
        gamesData = gamesList;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color textColor =
        HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();

    return Scaffold(
      appBar: const MyAppBar(),
      endDrawer: const CustomDrawer(),
      body: Container(
        color: const Color(0xFFD6D5C9),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 10,
            ),
            Text(
              'GAMES TIMETABLE',
              style: GoogleFonts.silkscreen(
                fontWeight: FontWeight.w500,
                color: textColor,
                fontSize: 30.0,
                height: 1.1,
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
            ),
        Column(
          children: gamesData.map((game) {
            return Card(
              color: const Color(0x7c7d86),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.only(top: 20, right: 10, left: 10),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                title: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'Тип игры',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Center(
                                child: Text(game['type'].toString()),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 40),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'Стоимость',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Center(
                                child: Text(game['price'].toString()),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 40),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'Клиент',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Center(
                                child: Text(game['players'].join(', ')),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(), // Add a divider line
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(game['date'])),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            );
          }).toList(),
        )
        ],
        ),
      ),
    );
  }
}
