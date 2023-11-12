import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

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
    final response = await http.get(
        Uri.parse('https://test.itfusion.kz/api/users'));

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
        title: const Text(
          'Logotype',
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
      endDrawer: const CustomDrawer(),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.grey,
              child: Center(
                child: Text(
                  responseText,
                  style: const TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ),
            Container(
              child: const Center(
                child: Text(
                  'Another component for dividing',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}