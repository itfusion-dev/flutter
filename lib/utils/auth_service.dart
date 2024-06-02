import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Сохранение токена
  Future<void> saveToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('accessToken', token);
  }

  // Получение информации о пользователе по токену
  Future<Map<String, dynamic>> getUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('accessToken');
    bool isRegistered = preferences.getBool('registered') ?? false;

    return {
      'token': token,
      'isRegistered': isRegistered,
    };
  }

  // Удаление токена
  Future<void> removeToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('accessToken');
    print("User logged out");
  }

  // проверка на наличие пользователя в системе
  Future<bool?> isRegistered() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('registered') ?? false;
  }

  // функция выхода из аккаунта - удаление токена и проверки
  Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('registered');
    await preferences.remove('accessToken');
  }
}
