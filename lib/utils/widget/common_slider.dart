import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/utils/constants.dart';




// ignore: must_be_immutable
class CommonSlider extends StatefulWidget {
  double value;
  Function onChanged;
  double min;
  double max;
  CommonSlider({Key? key,required this.value,required this.onChanged,required this.max,required this.min}) : super(key: key);

  @override
  State<CommonSlider> createState() => _CommonSliderState();
}
class _CommonSliderState extends State<CommonSlider> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: pinkColor,
        thumbColor: pinkColor,
        inactiveTrackColor: sliderTrackColor,
        overlayColor: Colors.transparent,
        trackHeight: 1.vw,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
      ),
      child: Slider(
          value: widget.value,
          min: 0,
          max: 200.0,
          onChanged: (double values) {
            widget.onChanged(values);
          },
          semanticFormatterCallback: (double newValue) {
            return '${newValue.round()}';
          }
      ),
    );
  }
}
