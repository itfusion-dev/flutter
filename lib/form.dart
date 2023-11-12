import 'package:flutter/material.dart';
import 'app_bar.dart';
import 'drawer.dart';

class FormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      endDrawer: const CustomDrawer(),
      body: const Center(
        child: Text('This is the form screen'),
      ),
    );
  }
}
