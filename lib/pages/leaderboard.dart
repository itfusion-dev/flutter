import 'dart:convert';
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
            return {
              "Ранг": index + 1,
              "Никнейм": user['username'],
              "Винрейт": "0%",
              "Общий рейтинг": user['elo'],
              "Игры": user['games_participate'].length,
              "Победы": 0
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
      endDrawer: const CustomDrawer(),
      body: Container(
        color: const Color(0xFFD6D5C9),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Ранг')),
              DataColumn(label: Text('Никнейм')),
              DataColumn(label: Text('Винрейт')),
              DataColumn(label: Text('Общий рейтинг')),
              DataColumn(label: Text('Игры')),
              DataColumn(label: Text('Победы')),
            ],
            rows: _leaderboardData.map((data) {
              return DataRow(cells: [
                DataCell(Text(data['Ранг'].toString())),
                DataCell(Text(data['Никнейм'].toString())),
                DataCell(Text(data['Винрейт'])),
                DataCell(Text(data['Общий рейтинг'].toString())),
                DataCell(Text(data['Игры'].toString())),
                DataCell(Text(data['Победы'].toString())),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}