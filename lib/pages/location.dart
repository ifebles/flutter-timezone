import 'package:flutter/material.dart';
import 'package:timezone/pages/loading.dart';
import 'package:timezone/services/world_timezone.dart';
import 'package:timezone/widgets/location_card.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  var loadingStatus = LoadingStatus.inProgress;
  List<String> timezones = [];
  String filterQuery = '';

  void loadData() {
    WorldTimezone.getTimezones().then((value) {
      setState(() {
        if (value.isNotEmpty) {
          loadingStatus = LoadingStatus.success;
          timezones = value;

          return;
        }

        loadingStatus = LoadingStatus.fail;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    switch (loadingStatus) {
      case LoadingStatus.inProgress:
        body = const Center(child: CircularProgressIndicator());
        break;

      case LoadingStatus.fail:
        body = Center(
          child: Column(
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
              ),
            ],
          ),
        );
        break;

      default:
        List<String> filteredTimezones = timezones;
        var controller = TextEditingController(text: filterQuery);

        if (filterQuery.isNotEmpty) {
          filteredTimezones = timezones
              .where((w) => w
                  .toLowerCase()
                  .replaceAll('_', ' ')
                  .contains(filterQuery.toLowerCase().replaceAll('_', ' ')))
              .toList();
        }

        body = Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Filter location',
                prefixIcon: const Icon(Icons.filter_alt),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.clear();
                    setState(() {
                      filterQuery = '';
                    });
                  },
                  icon: const Icon(Icons.cancel_outlined),
                ),
              ),
              onSubmitted: (value) {
                setState(() {
                  filterQuery = value.trim();
                });
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children:
                    filteredTimezones.map((m) => LocationCard(m)).toList(),
              ),
            ),
          ],
        );
        break;
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('Choose location'),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: body,
    );
  }
}
