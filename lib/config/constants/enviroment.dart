import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static String apiUrl =
      dotenv.env['API_URL'] ?? 'No API_URL envirment variable found';
}
