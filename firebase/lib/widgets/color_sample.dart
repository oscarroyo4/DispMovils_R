import 'package:flutter/material.dart';

class ColorSample extends StatelessWidget {
  final Color color;
  final String colorName;
  final bool selected;
  ColorSample({
    @required this.color,
    @required this.colorName,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    double size = 15;
    double sizeOutline = 31;
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Icon(
          Icons.fiber_manual_record_sharp,
          color: color,
          size: size,
        ),
        Icon(
          Icons.fiber_manual_record_outlined,
          color: selected ? color : Colors.transparent,
          size: sizeOutline,
        ),
      ],
    );
  }
}
