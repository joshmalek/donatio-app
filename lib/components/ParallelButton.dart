import '../src/ThemePalette.dart';
import 'package:flutter/cupertino.dart';

class ParallelButton extends StatelessWidget {
  String _buttonValue;
  double _width;
  ParallelButton(this._buttonValue, this._width);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        alignment: Alignment.center,
        width: _width < 100 ? 100 : _width,
        child: Text(this._buttonValue, style: FontPresets.buttonText),
        decoration: BoxDecoration(
            color: ThemePalette.black, borderRadius: BorderRadius.circular(3)));
  }
}
