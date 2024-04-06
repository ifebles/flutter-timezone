import 'dart:convert';

import 'package:http/http.dart';

class WorldTimezone {
  static Future<List<String>> getTimezones() =>
      get(Uri.parse('https://worldtimeapi.org/api/timezone')).then((value) {
        return List.from(jsonDecode(value.body));
      });
}
