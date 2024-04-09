import 'package:flutter/material.dart';
import 'package:timezone/services/world_time.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

enum LoadingStatus {
  inProgress,
  success,
  fail,
}

class _LoadingState extends State<Loading> {
  var loadingStatus = LoadingStatus.inProgress;
  late Map<LoadingStatus, Widget> stateMapper;

  _LoadingState() : super() {
    stateMapper = {
      LoadingStatus.inProgress: const CircularProgressIndicator(),
      LoadingStatus.fail: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('A problem occurred fetching the required data'),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () {
              setState(() {
                loadingStatus = LoadingStatus.inProgress;
              });
              loadData();
            },
            icon: const Icon(Icons.replay_outlined),
            label: const Text('Reload'),
          )
        ],
      ),
    };
  }

  void loadData() {
    var args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final timeData = WorldTime(args?['timezone']);

    timeData.getTimeData().then((value) {
      if (timeData.timezone != null && context.mounted) {
        Navigator.pushReplacementNamed(context, '/home', arguments: {
          'datetime': timeData.datetime,
          'offset': timeData.offset,
          'location': timeData.location,
          'flag': timeData.flag,
        });
        return;
      }

      setState(() {
        loadingStatus = LoadingStatus.fail;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, loadData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: stateMapper[loadingStatus]),
    );
  }
}
