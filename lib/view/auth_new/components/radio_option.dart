import 'package:flutter/material.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_fonts/app_fonts.dart';
import 'package:sizer/sizer.dart';

class RadioOption extends StatelessWidget {
  final String value;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const RadioOption({
    super.key,
    required this.value,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? const Color(0xFFFF9147) : Colors.grey[400]!,
                width: 2,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFF9147),
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(width: 2.w),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                fontFamily: AppFonts.artegraSoft,
                height: 1.0,
                color: AppColor.lightblackTxt,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
