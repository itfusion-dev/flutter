import 'package:flutter/material.dart';

import 'form.dart';
import 'home_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
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
          ListTile(
            title: Center(
              child: Text(
                'ХОЧУ ПОИГРАТЬ',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color.fromRGBO(85, 26, 139, 1),
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormScreen()),
              );
            },
          ),
          ListTile(
            title: Center(
              child: Text(
                'ВОЙТИ',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color.fromRGBO(85, 26, 139, 1),
                ),
              ),
            ),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}
