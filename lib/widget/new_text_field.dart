import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../res/app_assets/app_image.dart';
import '../res/app_color/app_color.dart';
import '../res/app_fonts/app_fonts.dart';

class NewTextField extends StatelessWidget {
  final String hintText;
  final String? title;
  final int? maxLines;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool isObscure;
  final bool showSuffix;
  final VoidCallback? onSuffixIconTap;
  final VoidCallback? onTap;
  final String? prefixImagePath;
  final bool readOnly;
  final TextInputType? textInputType;

  const NewTextField({
    super.key,
    required this.hintText,
    this.isObscure = false,
    this.showSuffix = false,
    this.onTap,
    this.onSuffixIconTap,
    this.validator,
    this.controller,
    this.prefixImagePath,
    this.readOnly = false,
    this.textInputType,
    this.maxLines,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null ?  const SizedBox(height: 8):const SizedBox.shrink(),

         title != null ? Text(
          title as String,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: AppColor.hintTxt,
          ),
        ):const SizedBox.shrink(),

        title != null ?  const SizedBox(height: 8):const SizedBox.shrink(),
        Container(
           decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            onTap: onTap,
            controller: controller,
            validator: validator,
            obscureText: isObscure,
            keyboardType: textInputType,
            readOnly: readOnly,
            maxLines: maxLines,
            minLines: 1,

            // ✅ force vertical center
            textAlignVertical: TextAlignVertical.center,

            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              fontFamily: AppFonts.artegraSoft,
              height: 1.0,
              color: AppColor.hintTxt,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,

              isDense: true,

               contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,

              ),

              suffixIcon: showSuffix
                  ? IconButton(
                onPressed: onSuffixIconTap,
                icon: Image.asset(
                  isObscure ? AppImage.hide : AppImage.show,
                  width: 18,
                ),
              )
                  : null,

              prefixIcon: prefixImagePath != null
                  ? Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(prefixImagePath!, width: 30),
              )
                  : null,

              hintStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                fontFamily: AppFonts.artegraSoft,
                height: 1.0,
                color: AppColor.hintTxt,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


