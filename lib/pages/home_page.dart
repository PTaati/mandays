import 'package:flutter/material.dart';

import '../utils/datetime_utils.dart';
import '../widgets/stop_watch_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Duration? _codingDuration;
  Duration? _reviewDuration;
  Duration? _meetingDuration;

  Widget _buildSummary() {
    final allTime = (_codingDuration?.inSeconds ?? 0) +
        (_reviewDuration?.inSeconds ?? 0) +
        (_meetingDuration?.inSeconds ?? 0);
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Chip(
                  label: Text(
                    'Time Spent',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('${DateTimeUtils.getDurationFormat(allTime)}/'
                      '${DateTimeUtils.getDurationFormat(const Duration(hours: 8).inSeconds)}'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFeatures() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSummary(),
        StopWatchWidget(
          tagName: 'Coding',
          onStart: () {},
          onStop: (duration) {
            setState(() {
              _codingDuration = duration;
            });
          },
        ),
        StopWatchWidget(
          tagName: 'Review Code',
          onStart: () {},
          onStop: (duration) {
            setState(() {
              _reviewDuration = duration;
            });
          },
        ),
        StopWatchWidget(
          tagName: 'Meeting',
          onStart: () {},
          onStop: (duration) {
            setState(() {
              _meetingDuration = duration;
            });
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: _buildFeatures(),
        ),
      ),
    );
  }
}
