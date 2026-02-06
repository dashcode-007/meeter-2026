
import 'package:flutter/material.dart';

import '../../../res/app_color/app_color.dart';
import '../../../res/app_fonts/app_fonts.dart';

class ServiceCardNew extends StatelessWidget {
  final String title;
  final String? imagePath;
  final VoidCallback onTap;

  const ServiceCardNew({
    super.key,
    required this.title,
    this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 90,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 75,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: const Color(0xffF2F2F4),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: imagePath != null
                  ? Image.asset(
                imagePath!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.image_not_supported,
                  size: 28,
                  color: Color(0xFF9CA3AF),
                ),
              )
                  : const Icon(
                Icons.settings,
                size: 28,
                color: Color(0xFF374151),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: AppFonts.artegraSoft,
                color: AppColor.lightblackTxt,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
