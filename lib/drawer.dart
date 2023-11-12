import 'package:flutter/material.dart';
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200, // Set the fixed width here
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Center(
              child: Text(
                'ГЛАВНАЯ',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color.fromRGBO(85, 26, 139, 1),
                ),
              ),
            ),
            onTap: () {
              // Handle the tap on drawer item 1
            },
          ),
          ListTile(
            title: Center(
              child: Text(
                'О НАС',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color.fromRGBO(85, 26, 139, 1),
                ),
              ),
            ),
            onTap: () {
              // Handle the tap on drawer item 2
            },
          ),
          ListTile(
            title: Center(
              child: Text(
                'РАСПИСАНИЕ ИГР',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color.fromRGBO(85, 26, 139, 1),
                ),
              ),
            ),
            onTap: () {
              // Handle the tap on drawer item 3
            },
          ),
          ListTile(
            title: Center(
              child: Text(
                'КОНТАКТЫ',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color.fromRGBO(85, 26, 139, 1),
                ),
              ),
            ),
            onTap: () {
              // Handle the tap on drawer item 4
            },
          ),
        ],
      ),
    );
  }
}
