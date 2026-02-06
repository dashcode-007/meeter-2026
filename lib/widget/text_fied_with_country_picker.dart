import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/utils/app_textstyle.dart';
import 'package:meter_app/utils/language_utils.dart';
import 'package:meter_app/utils/pref_util.dart';
import 'package:meter_app/widget/text_widget.dart';

import '../res/app_fonts/app_fonts.dart';

class CustomTextFieldWithCountryPicker extends StatelessWidget {
  final String hintText;
   final TextEditingController controller;
  final String? Function(String?)? validator;
  final String flagPath;
  final String? countryShortCode;
  final String? countryDialingCode;
  final Function(CountryCode)? countryCode;
  final String? title;
  final VoidCallback? onTapSuffix;
  final String verifyText;
  final Color verifyColor;
  final bool isVerifySucces;

  const CustomTextFieldWithCountryPicker({
    super.key,
    required this.hintText,
    required this.controller,
    required this.flagPath,
      this.title,
    this.validator,
    this.countryCode,
    this.countryShortCode,
    this.countryDialingCode,
    this.onTapSuffix,
    this.verifyText = "Verify",
    this.verifyColor = AppColor.primaryColor,
    this.isVerifySucces = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),

        /// Title (same typography)
        Text(
          title as String,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: AppColor.hintTxt,
          ),
        ),

        const SizedBox(height: 8),

        /// Card style like NewTextField
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
            controller: controller,
            validator: validator,
            readOnly: isVerifySucces,
            keyboardType: TextInputType.number,
            cursorColor: AppColor.primaryColor,

            /// Critical for vertical centering
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
              prefixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),


              /// same padding as NewTextField
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),

              /// Country picker / prefix
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 12, right: 6),
                child: isVerifySucces
                    ? Center(
                  child: Text(
                    countryShortCode ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColor.primaryColor,
                    ),
                  ),
                )
                    : SizedBox(
                  width: 100,
                      child: CountryCodePicker(

                                        initialSelection: countryShortCode ?? 'SA',
                                        favorite: [
                      countryDialingCode ?? '+966',
                      countryShortCode ?? 'SA'
                                        ],
                                        showFlagMain: true,
                                        showDropDownButton: false,
                                        padding: EdgeInsets.zero,
                                        onChanged: countryCode,
                                        textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColor.primaryColor,
                                        ),
                                        dialogSize: Size(Get.width, Get.height * 0.6),
                                        boxDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColor.whiteColor,
                                        ),
                                      ),
                    ),
              ),

              suffixIcon: onTapSuffix != null
                  ? Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: onTapSuffix,
                    child: Text(
                      verifyText,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: verifyColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              )
                  : null,



              hintStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                fontFamily: AppFonts.artegraSoft,
                height: 1.0,
                color: AppColor.greenColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
