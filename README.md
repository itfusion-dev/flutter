### Flutter App Documentation

This Flutter application provides a customizable app for viewing games and its reservation with dynamic menu options based on user authentication status and getting timetable through backend connection able to convert within landscape orientation.

#### Installation

To integrate `flutter_mobile` into your Flutter project, follow these steps:

1. **Clone Repository:**
   Clone the repository into your local development environment.

   ```bash
   git clone https://github.com/itfusion-dev/flutter

#### Copy Files

Copy the following files into your Flutter project directory:

- `form.dart`
- `login.dart`
- `timetable.dart`
- `home_page.dart`
- `app_bar.dart`
- `drawer.dart`

#### Dependency Installation

Make sure to add the required dependencies to your `pubspec.yaml` file:

dependencies:
flutter:
    sdk: flutter
cupertino_icons: ^1.0.2
http: ^0.13.6
google_fonts: ^4.0.0
shared_preferences: ^2.2.0
intl: ^0.19.0
url_launcher: ^6.2.6
flutter_linkify: ^6.0.0
mockito: ^5.4.4
http_mock_adapter: ^0.6.1

Then, run:

flutter pub get

#### Import Files:

Import the necessary files into your Flutter project, typically at the top of your main Dart file:

- `import 'package:flutter/material.dart';
import 'package:flutter_mobile/form.dart';
import 'package:flutter_mobile/login.dart';
import 'package:flutter_mobile/timetable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_page.dart';`

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
