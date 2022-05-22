import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class CheckboxTextSt extends StatefulWidget {
  final indicatorName;
  final Function updateIndicatorList;
  CheckboxTextSt(this.indicatorName, this.updateIndicatorList, {Key? key})
      : super(key: key);

  @override
  State<CheckboxTextSt> createState() => _CheckboxTextStState();
}

class _CheckboxTextStState extends State<CheckboxTextSt> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
              value: isChecked,
              onChanged: (_) {
                setState(() {
                  if (isChecked == true) {
                    isChecked = false;
                  } else {
                    isChecked = true;
                  }
                });
                widget.updateIndicatorList(isChecked, widget.indicatorName);
              }),
          Text(widget.indicatorName)
        ],
      ),
    );
  }
}
