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
      hours: int.parse(offsetParts[0]),
      minutes: int.parse(offsetParts[1]),
    ));

    var bgImg = nowRef.hour > 6 && nowRef.hour < 20 ? 'day' : 'night';
    const dateStyle = TextStyle(fontSize: 18);

    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 150, 0, 0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.white30],
                begin: Alignment.topLeft,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/location'),
                    icon: const Icon(Icons.location_on_outlined),
                    label: const Text(
                      'Edit location',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStatePropertyAll(Colors.grey[850]),
                    ),
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
            ),
          ),
        ),
      )),
    );
  }
}
