import 'package:flutter/material.dart';

class CheckboxText extends StatelessWidget {
  final indicatorName;
  var value;
  final Function onChanged;
  CheckboxText(this.indicatorName, this.value, this.onChanged, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(value: value, onChanged: (_) => onChanged(indicatorName)),
          Text(indicatorName)
        ],
      ),
    );
  }
}
