import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mandays/utils/datetime_utils.dart';

class StopWatchWidget extends StatefulWidget {
  const StopWatchWidget({
    Key? key,
    required this.tagName,
    required this.onStart,
    required this.onStop,
  }) : super(key: key);

  final String tagName;
  final Function() onStart;
  final Function(Duration) onStop;

  @override
  State<StopWatchWidget> createState() => _StopWatchWidgetState();
}

class _StopWatchWidgetState extends State<StopWatchWidget> {
  bool _isCounting = false;
  Timer? _counterTimer;
  int _countNumber = 0;
  int _totalNumber = 0;

  @override
  void dispose() {
    _counterTimer?.cancel();
    super.dispose();
  }

  Widget _buildStartButton() {
    return FloatingActionButton(
      child: const Icon(
        Icons.not_started_outlined,
      ),
      onPressed: () {
        widget.onStart.call();
        _counterTimer?.cancel();
        setState(() {
          _countNumber = 0;
          _isCounting = !_isCounting;
        });

        _counterTimer = Timer.periodic(
          const Duration(seconds: 1),
          (timer) {
            setState(() {
              _countNumber++;
              _totalNumber++;
            });
          },
        );
      },
    );
  }

  Widget _buildStopButton() {
    return FloatingActionButton(
      backgroundColor: Colors.red,
      child: const Icon(
        Icons.stop_circle_outlined,
      ),
      onPressed: () {
        setState(() {
          _isCounting = !_isCounting;
          _countNumber = 0;
        });
        widget.onStop.call(Duration(seconds: _totalNumber));
        _counterTimer?.cancel();
      },
    );
  }

  Widget _buildResetCurrentTime() {
    return TextButton(
        onPressed: () {
          _counterTimer?.cancel();
          setState(() {
            _totalNumber -= _countNumber;
            _countNumber = 0;
            _isCounting = false;
          });
        },
        child: const Text('CLEAR'));
  }

  Widget _buildResetTotalTime() {
    return TextButton(
        onPressed: () {
          _counterTimer?.cancel();
          widget.onStop(Duration.zero);
          setState(() {
            _totalNumber = 0;
            _isCounting = false;
          });
        },
        child: const Text('CLEAR'));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.tagName,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(DateTimeUtils.getDurationFormat(_totalNumber)),
                ),
                _buildResetTotalTime(),
              ],
            ),
            Column(
              children: [
                _isCounting ? _buildStopButton() : _buildStartButton(),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(DateTimeUtils.getDurationFormat(_countNumber)),
                ),
                _buildResetCurrentTime(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
