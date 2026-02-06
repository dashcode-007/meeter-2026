import 'package:flutter/material.dart';
import 'package:meter_app/utils/backend_util/auth_util.dart';
import 'package:sizer/sizer.dart';

import 'otp_box.dart';

class OtpVerificationBottomSheet extends StatefulWidget {
  final String maskedPhone;
  final VoidCallback onVerify;
  final VoidCallback? onResendCode;

  const OtpVerificationBottomSheet({
    super.key,
    required this.maskedPhone,
    required this.onVerify,
    this.onResendCode,
  });

  static Future<void> show(
    BuildContext context, {
    required String maskedPhone,
    required VoidCallback onVerify,
    VoidCallback? onResendCode,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => OtpVerificationBottomSheet(
        maskedPhone: maskedPhone,
        onVerify: () {
          Navigator.pop(context);
          onVerify();
        },
        onResendCode: onResendCode,
      ),
    );
  }

  @override
  State<OtpVerificationBottomSheet> createState() =>
      _OtpVerificationBottomSheetState();
}

class _OtpVerificationBottomSheetState extends State<OtpVerificationBottomSheet> {
  late final List<TextEditingController> _otpControllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _otpControllers = List.generate(4, (_) => TextEditingController());
    _focusNodes = List.generate(4, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 58.h,
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
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
              Container(
                width: 50,
                height: 4.5,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 4.h),
              const Text(
                'Verification',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 1.5.h),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Code has been send to ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  children: [
                    TextSpan(
                      text: widget.maskedPhone,
                      style: const TextStyle(
                        color: Color(0xFFFF9147),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => OtpBox(
                    controller: _otpControllers[index],
                    focusNode: _focusNodes[index],
                    nextFocusNode:
                        index < 3 ? _focusNodes[index + 1] : null,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              GestureDetector(
                onTap: widget.onResendCode,
                child: RichText(
                  text: TextSpan(
                    text: "Haven't got the code yet? ",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                    children: const [
                      TextSpan(
                        text: 'Resend code',
                        style: TextStyle(
                          color: Color(0xFFFF9147),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              GestureDetector(
                onTap: widget.onVerify,
                child: Container(
                  width: double.infinity,
                  height: 6.8.h,
                  decoration: BoxDecoration(
                    gradient: AuthUtil().linearGradient,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text(
                      'Verify Code',
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
        Positioned(
          right: 6.w,
          bottom: 3.h,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                color: Colors.orange,
                size: 28,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
