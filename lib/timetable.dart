import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_mobile/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/link.dart';
import 'app_bar.dart';
import 'login.dart';

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
    await http.get(Uri.parse('https://mafia.yc.itfusion.xyz/api/games'));
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

  Future<void> addToQueue(String gameId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('accessToken');
    print('Token retrieved: $token');

    final url = Uri.parse("https://mafia.yc.itfusion.xyz/api/users/profile");
    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print('$responseData');
      final patchResponse = await http.patch(
        Uri.parse('https://mafia.yc.itfusion.xyz/api/users/queue'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'gid': gameId}),
      );

      if (patchResponse.statusCode == 200) {
        final responseData = jsonDecode(patchResponse.body);
        print('Response: $responseData');
      } else {
        print('Failed to add to queue. Status code: ${patchResponse.statusCode} + ${patchResponse.body}');
        throw Exception('Failed to add to queue');
      }
    } else {
      print('Failed to fetch user profile. Status code: ${response.statusCode}');
      throw Exception('Failed to fetch user profile');
    }
  }


  @override
  Widget build(BuildContext context) {
    Color textColor =
    HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();

    return Scaffold(
      appBar: AppBar(
        title: Text('Timetable Screen'),
      ),
      endDrawer: Drawer(),
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
            Expanded(
              child: ListView.builder(
                itemCount: gamesData.length,
                itemBuilder: (context, index) {
                  final game = gamesData[index];
                  return Card(
                    color: const Color(0x7c7d86),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(top: 20, right: 10, left: 10),
                    child: ListTile(
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      DateFormat('d MMM, HH:mm')
                                          .format(DateTime.parse(game['date'])),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              FutureBuilder<Map<String, dynamic>>(
                                // Getting user information
                                future: LoginForm().getUserInfo(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    final token = snapshot.data?['token'];
                                    if (token != null) {
                                      return ElevatedButton(
                                        onPressed: () async {
                                          if (game['type'].toString() ==
                                              'Funky') {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("Запись успешна"),
                                                  content: Text(
                                                      "Вы записались на игру!"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(); // закрыть окно
                                                      },
                                                      child: Text("Закрыть"),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          } else if (game['type'].toString() ==
                                              'Ranked') {
                                            try {
                                              await addToQueue(game['id']);
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title:
                                                    Text("Бронь успешна"),
                                                    content: Text(
                                                        "Вы забронировали место на турнир!"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(); // закрыть окно
                                                        },
                                                        child: Text("Закрыть"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            } catch (e) {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text("Ошибка"),
                                                    content: Text(
                                                        "Не удалось забронировать место."),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(); // закрыть окно
                                                        },
                                                        child: Text("Закрыть"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                          }
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                            Colors.grey[800]!,
                                          ),
                                        ),
                                        child: Text(
                                          game['status'] == 'booked'
                                              ? 'Забронировано'
                                              : game['type'].toString() ==
                                              'Funky'
                                              ? 'Записаться'
                                              : 'Забронировать',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      );
                                    }
                                  }
                                  return Link(
                                    target: LinkTarget.blank,
                                    uri: Uri.parse(
                                        'https://2gis.kz/almaty/directions/points/76.930096,43.243167;70000001043890537'),
                                    builder: (context, followLink) =>
                                        ElevatedButton(
                                          onPressed: followLink,
                                          style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                              Colors.grey[800]!,
                                            ),
                                          ),
                                          child: Text(
                                            'Как добраться?',
                                            style: TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
