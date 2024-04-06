import 'package:flutter/material.dart';

class LocationCard extends StatelessWidget {
  final String timezone;
  const LocationCard(this.timezone, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.flag_outlined),
            Expanded(flex: 1, child: Text(timezone)),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/', arguments: {
                      'timezone': timezone,
                    });
                  },
                  child: const Text('Select'),
                ),
              ),
            ),
          ],
        ),
        const Divider(height: 8),
      ],
    );
  }
}
