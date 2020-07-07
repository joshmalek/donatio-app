import '../src/ThemePalette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParallelButton extends StatelessWidget {
  String _buttonValue;
  double _width;
  Function() _onpress;
  bool _hasAction;

  ParallelButton(this._buttonValue, this._width) {
    _hasAction = false;
  }
  ParallelButton.withAction(this._buttonValue, this._width, this._onpress) {
    _hasAction = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (_hasAction) _onpress();
        },
        child: Transform(
          transform: Matrix4.skewX(100),
          child: Container(
              height: 30,
              alignment: Alignment.center,
              width: _width < 100 ? 100 : _width,
              child: Transform(
                transform: Matrix4.skewX(-100),
                child: Text(this._buttonValue, style: FontPresets.buttonText),
              ),
              decoration: BoxDecoration(
                  color: ThemePalette.black,
                  borderRadius: BorderRadius.circular(3))),
        ));
  }
}
