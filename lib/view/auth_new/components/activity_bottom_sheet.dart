import 'package:flutter/material.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_fonts/app_fonts.dart';
import 'package:sizer/sizer.dart';

class ActivityBottomSheet extends StatelessWidget {
  final List<String> activities;
  final String? selectedActivity;
  final ValueChanged<String> onSelect;

  const ActivityBottomSheet({
    super.key,
    required this.activities,
    this.selectedActivity,
    required this.onSelect,
  });

  static const List<String> defaultActivities = [
    'Survey Office',
    'Engineering Office',
    'Design Office',
    'Interior Design Office',
    'Engineering Consultation Company',
    'Safety Office',
    'other',
  ];

  static Future<String?> show(
    BuildContext context, {
    List<String>? activities,
    String? selectedActivity,
  }) async {
    String? result;
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ActivityBottomSheet(
        activities: activities ?? defaultActivities,
        selectedActivity: selectedActivity,
        onSelect: (value) {
          result = value;
          Navigator.pop(context);
        },
      ),
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 65.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Container(
              width: 50,
              height: 4.5,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 2.5.h),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: activities.length,
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
              itemBuilder: (context, index) {
                final activity = activities[index];
                final isSelected = selectedActivity == activity;

                return GestureDetector(
                  onTap: () => onSelect(activity),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 2.h,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFFF9147)
                                  : Colors.grey[400]!,
                              width: 2,
                            ),
                          ),
                          child: isSelected
                              ? Center(
                                  child: Container(
                                    width: 14,
                                    height: 14,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFFF9147),
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            activity,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontFamily: AppFonts.artegraSoft,
                              height: 1.0,
                              color: AppColor.greyTxt,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
