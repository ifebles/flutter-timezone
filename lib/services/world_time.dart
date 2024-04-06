import 'dart:convert';

import 'package:http/http.dart';

class WorldTime {
  String? timezone;
  String? datetime;
  String? location;
  String? offset;
  String? flag;

  WorldTime([this.timezone]);

  Future<void> getTimeData() async {
    String url;

    if (timezone == null) {
      url = 'https://worldtimeapi.org/api/ip';
    } else {
      url = 'https://worldtimeapi.org/api/timezone/$timezone';
    }

    ///

    try {
      var response = await get(Uri.parse(url));
      Map data = jsonDecode(response.body);

      timezone = data['timezone'];
      offset = data['utc_offset'];
      datetime = data['utc_datetime'];
      flag = timezone?.split('/').lastOrNull;
      location = flag?.replaceAll('_', ' ');
    } catch (ex) {
      print('An exception occurred: $ex');
    }
  }
}
