import 'package:flutter/material.dart';

import '../../../res/app_color/app_color.dart';

class CheckBoxWithTitle extends StatelessWidget {
  final bool checkValue;
  final Widget title;
  final Function(bool?)? onChanged;
  const CheckBoxWithTitle({super.key, required this.checkValue, required this.title, this.onChanged});

  @override
  Widget build(BuildContext context) {
      return Row(
        children: [
          Transform.scale(
            scale: 1.3,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              activeColor: AppColor.primaryColor,
              checkColor: AppColor.whiteColor,
              // overlayColor: WidgetStateProperty<Color>,
              value: checkValue,
              onChanged: onChanged,
            ),
          ),
          Flexible(child: title),
        ],
      );
  }
}
