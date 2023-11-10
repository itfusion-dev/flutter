import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Boilerplate',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Color(0xFFD6D5C9),
      ),
      home: const MyHomePage(title: 'Logotype'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String responseText = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://test.itfusion.kz/api/users'));

    if (response.statusCode == 200) {
      setState(() {
        responseText = response.body;
      });
    } else {
      setState(() {
        responseText = 'Error: ${response.statusCode}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.red,
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: Drawer(
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
                  // Handle the tap on drawer item 4
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
                  // Handle the tap on drawer item 4
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
                  // Handle the tap on drawer item 4
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(responseText),
          ],
        ),
      ),
    );
  }
}
