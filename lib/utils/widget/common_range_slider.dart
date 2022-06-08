

import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/utils/constants.dart';

// ignore: must_be_immutable
class CommonRangeSlider extends StatefulWidget {
  RangeValues value;
  Function onChanged;
  double min;
  double max;
  CommonRangeSlider({Key? key,required this.value,required this.onChanged,required this.max,required this.min}) : super(key: key);

  @override
  State<CommonRangeSlider> createState() => _CommonRangeSliderState();
}

class _CommonRangeSliderState extends State<CommonRangeSlider> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: pinkColor,
        thumbColor: pinkColor,
        inactiveTrackColor: sliderTrackColor,
        overlayColor: Colors.transparent,
        trackHeight: 1.vw,
        rangeThumbShape:  const RoundRangeSliderThumbShape(enabledThumbRadius: 7),

      ),
      child: RangeSlider(
        values: widget.value,
        min: widget.min,
        max: widget.max,
        onChanged: (RangeValues values) {
        widget.onChanged(values);
        },
      ),
    );
  }
}
