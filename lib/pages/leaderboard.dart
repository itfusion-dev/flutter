import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import '../components/drawer.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<Map<String, dynamic>> _leaderboardData = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final url = Uri.parse('https://mafia.yc.itfusion.xyz/api/users');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final users = data['users'] as List;
        setState(() {
          _leaderboardData = users.asMap().entries.map((entry) {
            int index = entry.key;
            var user = entry.value;
            int gamesParticipate = user['games_participate'].length;
            int winCount = user['win_count'];
            double winRate = gamesParticipate > 0 ? (winCount / gamesParticipate) * 100 : 0;
            return {
              "Ранг": index + 1,
              "Никнейм": user['username'],
              "Винрейт": "${winRate.toStringAsFixed(2)}%",
              "Общий рейтинг": user['elo'],
              "Игры": gamesParticipate,
              "Победы": winCount
            };
          }).toList();
        });
      } else {
        print('Failed to load users');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      endDrawer: CustomDrawer(),
      body: Container(
        color: const Color(0xFFD6D5C9),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 10,
            ),
            Text(
              'Рейтинг игроков',
              style: GoogleFonts.silkscreen(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 30.0,
                height: 1.1,
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text(
                        'Ранг',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Никнейм',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Винрейт',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Общий рейтинг',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Игры',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Победы',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ],
                  rows: _leaderboardData.asMap().entries.map((entry) {
                    int index = entry.key;
                    var data = entry.value;
                    return DataRow(
                      color: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                        return index % 2 == 0 ? Color(0xFFABAA9B) : Color(0xFFCAC9BA);
                      }),
                      cells: [
                        DataCell(
                          Text(
                            data['Ранг'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: index == 0 ? Colors.black87 : null,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            data['Никнейм'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: index == 0 ? Colors.black87 : null,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            data['Винрейт'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: index == 0 ? Colors.black87 : null,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            data['Общий рейтинг'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: index == 0 ? Colors.black87 : null,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            data['Игры'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: index == 0 ? Colors.black87 : null,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            data['Победы'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: index == 0 ? Colors.black87 : null,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}