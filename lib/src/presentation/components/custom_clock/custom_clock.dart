import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'helpers/clock_model.dart';
import 'helpers/spinner_text.dart';

class CustomClock extends StatefulWidget {
  const CustomClock({super.key});

  @override
  State<CustomClock> createState() => _CustomClockState();
}

class _CustomClockState extends State<CustomClock> {
  late DateTime _dateTime;
  late ClockModel _clockModel;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _clockModel = ClockModel();
    _clockModel.is24HourFormat = true;

    _dateTime = DateTime.now();
    _clockModel.hour = _dateTime.hour;
    _clockModel.minute = _dateTime.minute;
    _clockModel.second = _dateTime.second;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _dateTime = DateTime.now();
      _clockModel.hour = _dateTime.hour;
      _clockModel.minute = _dateTime.minute;
      _clockModel.second = _dateTime.second;

      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(4.0),
      child: Container(
        alignment: AlignmentDirectional.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _amPm,
            _hour(),
            Container(
              alignment: AlignmentDirectional.center,
              margin: const EdgeInsets.all(1.0),
              padding: const EdgeInsets.all(2.0),
            ),
            _minute,
            _second,
          ],
        ),
      ),
    );
  }

  Widget _hour() => Container(
        padding: const EdgeInsets.all(2),
        alignment: AlignmentDirectional.center,
        child: SpinnerText(
          text: _clockModel.is24HourTimeFormat
              ? hTOhh_24hTrue(_clockModel.hour)
              : hTOhh_24hFalse(_clockModel.hour)[0],
          textStyle: Theme.of(context).textTheme.bodyLarge,
        ),
      );

  Widget get _minute => Container(
        padding: const EdgeInsets.all(2),
        alignment: AlignmentDirectional.center,
        child: SpinnerText(
          text: mTOmm(_clockModel.minute),
          textStyle: Theme.of(context).textTheme.bodyLarge,
        ),
      );

  Widget get _second => Container(
        margin: const EdgeInsets.all(1),
        padding: const EdgeInsets.all(2),
        alignment: AlignmentDirectional.center,
        child: SpinnerText(
            text: sTOss(_clockModel.second),
            textStyle:
                Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10)),
      );

  Widget get _amPm => _clockModel.is24HourTimeFormat
      ? const SizedBox()
      : Container(
          padding: REdgeInsets.all(2),
          alignment: AlignmentDirectional.center,
          child: Text(
            " ${hTOhh_24hFalse(_clockModel.hour)[1]}",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        );
}
