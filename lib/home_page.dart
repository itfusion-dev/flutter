import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'drawer.dart';
import 'app_bar.dart';

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
      appBar: MyAppBar(),
      endDrawer: const CustomDrawer(),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              height: 200,
              color: Colors.grey,
              child: SingleChildScrollView(
                child: Center(
                  child: Text(
                    responseText,
                    style: const TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
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
