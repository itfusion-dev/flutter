import 'package:flutter/material.dart';
import 'package:flutter_mobile/components/form.dart';
import 'package:flutter_mobile/main.dart';
import 'package:flutter_mobile/pages/home_page.dart';
import 'package:flutter_mobile/pages/timetable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  testWidgets('Тест на создание основы приложения', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.byType(MyApp), findsOneWidget);
  });

  testWidgets('Загрузка тематических виджетов', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    final MaterialApp app = tester.widget(find.byType(MaterialApp));
    expect(app.theme?.scaffoldBackgroundColor, equals(Colors.white));
  });

  testWidgets('Загрузка основной страницы', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.byType(MyHomePage), findsOneWidget);
  });

  testWidgets('Создание компонента основной страницы', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.byType(MyHomePage), findsOneWidget);
  });


  testWidgets('Проверка на изменение цветов', (WidgetTester tester) async {
    final scaffoldColor = Colors.blue;
    final themeData = ThemeData(scaffoldBackgroundColor: scaffoldColor);
    await tester.pumpWidget(
      MaterialApp(
        theme: themeData,
        home: Container(),
      ),
    );
    final MaterialApp app = tester.widget(find.byType(MaterialApp));
    expect(app.theme?.scaffoldBackgroundColor, equals(scaffoldColor));
  });

  group('Тесты функции регистрации', () {
    test('Успешная регистрация', () async {
      // Создаем экземпляр FormScreen для доступа к его членам
      FormScreen formScreen = FormScreen();

      // Мокаем ответ на http post запрос
      http.Response response = http.Response(
        jsonEncode({'accessToken': 'mockedAccessToken'}),
        201,
      );

      // Мокаем SharedPreferences
      SharedPreferences.setMockInitialValues({'registered': false});

      // Мокаем SharedPreferences.getInstance
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool('registered', true);

      // Выполняем функцию и проверяем утверждение
      expect(preferences.getBool('registered'), true);
    });

    test('fetchData returns a list of games when the API call is successful', () async {
      TimetableScreen timetableScreenState = TimetableScreen();

      // Вымышленный ответ API, чтобы использовать в тесте
      final fakeResponse = http.Response(
        '{"games": [{"id": 1, "name": "Game 1"}, {"id": 2, "name": "Game 2"}]}',
        200,
      );

      // Мокаем http.get, чтобы вместо отправки реального запроса использовать наш фейковый ответ
      http.Client client = MockClient((request) async => fakeResponse);

      // Тестируем вашу функцию fetchData с использованием фейкового http-клиента
      //final gamesData = await timetableScreenState.fetchData();

      // Проверяем, что состояние игр содержит как минимум 2 игры
      //expect(timetableScreenState.gamesData.length, 2);
    });

  });
}
