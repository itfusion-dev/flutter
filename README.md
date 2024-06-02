# Flutter App Documentation

## Getting started

This Flutter application provides a customizable app for viewing games and its reservation with dynamic menu options based on user authentication status and getting timetable through backend connection able to convert within landscape orientation.

### Installation

1. **Clone Repository:**

   ```bash
   git clone https://github.com/itfusion-dev/flutter

## Copy Files

Copy the following files into your Flutter project directory:

- `form.dart`
- `login.dart`
- `timetable.dart`
- `home_page.dart`
- `app_bar.dart`
- `drawer.dart`

## Dependency Installation

Make sure to add the required dependencies to your `pubspec.yaml` file:

```yaml
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
```
Then, run:

```bash
flutter pub get
```

Import the necessary files into your Flutter project, typically at the top of your main.dart file:

```yaml
import 'package:flutter/material.dart';
import 'package:flutter_mobile/form.dart';
import 'package:flutter_mobile/login.dart';
import 'package:flutter_mobile/timetable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_page.dart';
```

### Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-mobile/
|- android
|- build
|- ios
|- lib
|  - components/
|  - pages/
|  - utils/
|- test
```


### Explanation:
1. **Dependencies Section in `pubspec.yaml`**:
   - Make sure to indent your dependencies correctly under the `dependencies` key.
   - Use proper YAML syntax.

2. **Command to Get Dependencies**:
   - Place the `flutter pub get` command in a separate code block for clarity.

3. **Dart Import Statements**:
   - Use Dart syntax highlighting for the import statements.

By following this corrected format, the instructions should render correctly in markdown and be easier to follow.



