import 'package:flutter/material.dart';
import 'package:timezone/widgets/text_datetime.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> data = {};
  Duration? timeDiff;

  @override
  Widget build(BuildContext context) {
    var mroute = ModalRoute.of(context);

    if (mroute != null) {
      data = mroute.settings.arguments as Map<String, dynamic>;
    }

    List<String> offsetParts = data['offset'].split(':');
    final nowRef = DateTime.parse(data['datetime']).add(Duration(
        hours: int.parse(offsetParts[0]), minutes: int.parse(offsetParts[1])));
    const dateStyle = TextStyle(fontSize: 18);

    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/location'),
              icon: const Icon(Icons.location_on_outlined),
              label: const Text('Edit location'),
            ),
            Text(
              data['location'],
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextDateTime(nowRef, 'dd/MM/yyyy', style: dateStyle),
            TextDateTime(nowRef, 'hh:mm:ss a', style: dateStyle),
          ],
        ),
      )),
    );
  }
}
