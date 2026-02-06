import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/app_color/app_color.dart';
import '../../../res/app_fonts/app_fonts.dart';
import '../../auth/Login/login_screen.dart';

class WorkProgramCardNew extends StatelessWidget {
  final String title;
  final String? imagePath;
  final VoidCallback? onTap;

  const WorkProgramCardNew({
    super.key,
    required this.title,
    this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
              () {
            Get.to(const LoginScreen());
            debugPrint('Work program tapped: $title');
          },
      child: Container(
        width: 104,
        height: 83,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 36,
              height: 36,
              child: imagePath != null
                  ? Image.asset(
                imagePath!,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) {
                  return const Icon(
                    Icons.lightbulb_outline,
                    size: 24,
                    color: Color(0xFF374151),
                  );
                },
              )
                  : const Icon(
                Icons.lightbulb_outline,
                size: 24,
                color: Color(0xFF374151),
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.artegraSoft,
                  color: AppColor.lightblackTxt,
                  height: 1.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
