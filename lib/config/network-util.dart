import 'package:flutter_app/screens/home.dart';

abstract class NetworkUtility {

  static const String BASE_URL = 'http://10.0.2.2/blood-bank/public/api/';

  static Map<String, String> generateHeader() {
    return {'Authorization': 'Bearer ${HomeScreen.token}'};
  }
}