import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextDateTime extends StatefulWidget {
  final DateTime relativeTime;
  final String format;
  final TextStyle? style;

  const TextDateTime(this.relativeTime, this.format, {super.key, this.style});

  @override
  State<TextDateTime> createState() => _TextDateTimeState();
}

class _TextDateTimeState extends State<TextDateTime> {
  late DateTime currentTime;

  @override
  void initState() {
    super.initState();

    currentTime = widget.relativeTime;

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        setState(() {
          currentTime = currentTime.add(const Duration(seconds: 1));
        });

        return true;
      }

      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat(widget.format).format(currentTime),
      style: widget.style,
    );
  }
}
