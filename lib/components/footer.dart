import 'package:flutter/material.dart';
import 'package:flutter_mobile/pages/timetable.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/leaderboard.dart';

import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => TimetableScreen(),
                            transitionDuration: Duration(seconds: 0),
                          ),
                        );
                      },
                      child: Text(
                        'Расписание игр',
                        style: GoogleFonts.archivo(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 16.0,
                          height: 1.1,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => LeaderboardScreen(),
                            transitionDuration: Duration(seconds: 0),
                          ),
                        );
                      },
                      child: Text(
                        'Рейтинг игроков',
                        style: GoogleFonts.archivo(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 16.0,
                          height: 1.1,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () async {
                        const url = 'https://www.youtube.com/watch?v=kwIT-RYaYqw&t=21s';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Text(
                        'Правила игр',
                        style: GoogleFonts.archivo(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 16.0,
                          height: 1.1,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () async {
                        const url = 'https://mafiaworldtour.com/tournaments/2880';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Text(
                        'Ближайший турнир от клуба',
                        style: GoogleFonts.archivo(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 16.0,
                          height: 1.1,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    SizedBox(height: 40),
                    Divider(
                      color: Color(0xFF262626),
                      thickness: 1.0,
                      height: 20.0,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.facebook, color: Colors.white, size: 40),
                SizedBox(width: 20),
                Icon(Icons.telegram, color: Colors.white, size: 40),
                SizedBox(width: 20),
                Icon(Icons.watch, color: Colors.white, size: 40),
                SizedBox(width: 20),
                Icon(Icons.wallet, color: Colors.white, size: 40),
              ],
            ),
            SizedBox(height: 25),
            Center(
              child: Text(
                '© Mafia Madness 2023',
                textAlign: TextAlign.center,
                style: GoogleFonts.archivo(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 18.0,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}