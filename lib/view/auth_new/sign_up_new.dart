import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_fonts/app_fonts.dart';
import 'package:meter_app/utils/backend_util/constant_util.dart';
import 'package:meter_app/view/auth_new/general_info/general_info_screen.dart';
import 'package:sizer/sizer.dart';

import '../../gen/assets.gen.dart';
import '../../widget/new_text_field.dart';
import 'components/activity_bottom_sheet.dart';
import 'components/activity_dropdown_field.dart';
import 'components/otp_verification_bottom_sheet.dart';
import 'components/phone_input_field.dart';
import 'components/radio_option.dart';
import 'components/sign_up_header.dart';
import 'components/user_type_button.dart';

class SignUpScreenNew extends StatefulWidget {
  const SignUpScreenNew({super.key});

  @override
  State<SignUpScreenNew> createState() => _SignUpScreenNewState();
}

class _SignUpScreenNewState extends State<SignUpScreenNew> {
  String selectedUserType = ConstantUtil.customer;
  String? selectedFacilityType;
  String? selectedActivity;

  void _changeUserType(String type) {
    setState(() {
      selectedUserType = type;
      selectedFacilityType = null;
      selectedActivity = null;
    });
  }

  void _showActivityBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ActivityBottomSheet(
        activities: ActivityBottomSheet.defaultActivities,
        selectedActivity: selectedActivity,
        onSelect: (value) {
          setState(() => selectedActivity = value);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showOtpBottomSheet() {
    OtpVerificationBottomSheet.show(
      context,
      maskedPhone: '(+971*********)',
      onVerify: _navigateAfterOtp,
    );
  }

  void _navigateAfterOtp() {
    switch (selectedUserType) {
      case ConstantUtil.customer:
      case ConstantUtil.seller:
      case ConstantUtil.provider:
        Get.offAll(() => GeneralInfoScreen(userType: selectedUserType));
        break;
      default:
        Get.snackbar(
          'Error',
          'Invalid user type selected',
          snackPosition: SnackPosition.BOTTOM,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SignUpHeader(),
                SizedBox(height: 3.h),
                Center(child: SvgPicture.asset(Assets.images.arbi)),
                SizedBox(height: 1.2.h),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: const Text(
                      'Create your account with us to enjoy the latest features from our platform.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.greyTxt,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.artegraSoft,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 3.5.h),
                Row(
                  children: [
                    Expanded(
                      child: UserTypeButton(
                        label: ConstantUtil.customer,
                        isSelected: selectedUserType == ConstantUtil.customer,
                        onTap: () => _changeUserType(ConstantUtil.customer),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: UserTypeButton(
                        label: ConstantUtil.provider,
                        isSelected: selectedUserType == ConstantUtil.provider,
                        onTap: () => _changeUserType(ConstantUtil.provider),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: UserTypeButton(
                        label: ConstantUtil.seller,
                        isSelected: selectedUserType == ConstantUtil.seller,
                        onTap: () => _changeUserType(ConstantUtil.seller),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                _buildDynamicForm(),
                SizedBox(height: 3.5.h),
                GestureDetector(
                  onTap: _showOtpBottomSheet,
                  child: Container(
                    width: double.infinity,
                    height: 6.5.h,
                    decoration: BoxDecoration(
                      color: AppColor.buttonColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDynamicForm() {
    if (selectedUserType == ConstantUtil.customer) {
      return _buildCustomerForm();
    } else if (selectedUserType == ConstantUtil.provider) {
      return _buildServiceProviderForm();
    } else {
      return _buildSellerForm();
    }
  }

  Widget _buildCustomerForm() {
    return Column(
      children: [
        const NewTextField(hintText: 'Name', title: 'Enter Your Name'),
        SizedBox(height: 2.h),
        const NewTextField(title: 'Enter your email', hintText: 'Email'),
        SizedBox(height: 2.h),
        const PhoneInputField(),
      ],
    );
  }

  Widget _buildServiceProviderForm() {
    return Column(
      children: [
        Row(
          children: [
            RadioOption(
              value: 'Company',
              label: 'Company',
              isSelected: selectedFacilityType == 'Company',
              onTap: () => setState(() => selectedFacilityType = 'Company'),
            ),
            SizedBox(width: 4.w),
            RadioOption(
              value: 'Establishment',
              label: 'Establishment',
              isSelected: selectedFacilityType == 'Establishment',
              onTap: () =>
                  setState(() => selectedFacilityType = 'Establishment'),
            ),
            SizedBox(width: 4.w),
            RadioOption(
              value: 'Office',
              label: 'Office',
              isSelected: selectedFacilityType == 'Office',
              onTap: () => setState(() => selectedFacilityType = 'Office'),
            ),
          ],
        ),
        SizedBox(height: 2.5.h),
        const NewTextField(
          title: 'Enter Facility Name',
          hintText: 'Facility Name',
        ),
        SizedBox(height: 2.h),
        const NewTextField(title: 'Enter your email', hintText: 'Email'),
        SizedBox(height: 2.h),
        const PhoneInputField(),
        SizedBox(height: 2.h),
        ActivityDropdownField(
          hint: 'Select an activity',
          selectedValue: selectedActivity,
          onTap: _showActivityBottomSheet,
        ),
        SizedBox(height: 2.h),
        const NewTextField(
          title: 'Enter a description for your service',
          hintText: 'Description...',
        ),
      ],
    );
  }

  Widget _buildSellerForm() {
    return Column(
      children: [
        Row(
          children: [
            RadioOption(
              value: 'Company',
              label: 'Company',
              isSelected: selectedFacilityType == 'Company',
              onTap: () => setState(() => selectedFacilityType = 'Company'),
            ),
            SizedBox(width: 5.w),
            RadioOption(
              value: 'Establishment',
              label: 'Establishment',
              isSelected: selectedFacilityType == 'Establishment',
              onTap: () =>
                  setState(() => selectedFacilityType = 'Establishment'),
            ),
          ],
        ),
        SizedBox(height: 2.5.h),
        const NewTextField(
          title: 'Enter Facility Name',
          hintText: 'Facility Name',
        ),
        SizedBox(height: 2.h),
        const NewTextField(title: 'Enter your email', hintText: 'Email'),
        SizedBox(height: 2.h),
        const PhoneInputField(),
        SizedBox(height: 2.h),
        const NewTextField(
          title: 'Enter Facility Number',
          hintText: 'Facility Number',
        ),
        SizedBox(height: 2.h),
        const NewTextField(
          title: 'Enter Commercial Registration',
          hintText: 'Commercial Registration',
        ),
        SizedBox(height: 2.h),
        const NewTextField(
          title: 'Enter facility activity',
          hintText: 'Facility Activity',
        ),
      ],
    );
  }
}
