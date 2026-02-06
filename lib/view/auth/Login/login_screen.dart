import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_fonts/app_fonts.dart';

import '../../../widget/app_btn.dart';
import '../../../widget/support_btn.dart';
import '../../../gen/assets.gen.dart';
import '../../auth_new/sign_up_new.dart';
import '../../bottom_nav/home/home_screen.dart';
import 'forget_screen.dart';

enum LoginType { email, phone, nafaz }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginType _loginType = LoginType.nafaz;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final nafazController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF3F3F3),
        body: SafeArea(
          child: Stack(
            children: [
              // ================= DECORATIVE LINES =================
              Positioned(
                top: -25,
                left: -7,
                child: SizedBox(
                  width: 102.24,
                  height: 200.50,
                  child: Column(
                    children: [
                     Image.asset(Assets.images.grid2.path)
                    ],
                  ),
                ),
              ),

              // ================= MAIN CONTENT =================
              Column(
                children: [
                  // ================= TOP BAR =================
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.arrow_back_ios_new, size: 18),
                        ),
                      ],
                    ),
                  ),

                  // ================= LOGO =================
                  Image.asset(
                    Assets.images.meter.path,
                    height: 60,
                  ),

                  const SizedBox(height: 20),

                  // ================= TITLE =================
                  // RichText(
                  //   textAlign: TextAlign.center,
                  //   text: const TextSpan(
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.w800,
                  //       fontFamily: AppFonts.artegraSoft,
                  //       fontSize: 24,
                  //       fontStyle: FontStyle.normal,
                  //       height: 1.0,
                  //       letterSpacing: 0,
                  //       color: Colors.black,
                  //     ),
                  //     children: [
                  //       TextSpan(
                  //         text: "Welcome To ",
                  //         style: TextStyle(color: Colors.black),
                  //       ),
                  //       TextSpan(
                  //         text: "meter platform",
                  //         style: TextStyle(color: Colors.orange),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SvgPicture.asset("assets/images/english.svg"),

                  const SizedBox(height: 6),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "Create your account with us to enjoy the latest features from our platform.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.greyTxt,
                        fontSize: 8.5,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.artegraSoft,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ================= TABS =================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: _tabButton(
                              title: "نفاذ", type: LoginType.nafaz, fontSize: 20),
                        ),
                        Expanded(child: _tabButton(title: "Phone", type: LoginType.phone)),
                        Expanded(child: _tabButton(title: "Email", type: LoginType.email)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ================= INPUT FIELDS =================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildLoginFields(),
                  ),

                  const SizedBox(height: 16),

                  // ================= REMEMBER / FORGOT =================
                  if (_loginType != LoginType.nafaz)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.check_box_outline_blank, size: 20),
                          const SizedBox(width: 8),
                          const Text(
                            "Remember me",
                            style: TextStyle(
                              fontFamily: AppFonts.artegraSoft,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const Spacer(),
                          if (_loginType == LoginType.email)
                            GestureDetector(
                              onTap: () {
                                Get.to(const ForgotPasswordScreen());
                              },
                              child:   Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  fontFamily: AppFonts.artegraSoft,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                  const Spacer(),

                  // ================= LOGIN BUTTON =================
                  AppBtn(
                    title: 'Log In',
                    onPressed: () {
                      Get.off(const MainHomeScreen());
                    },
                  ),

                  const SizedBox(height: 12),

                  // ================= SIGN UP TEXT =================
                  Text.rich(
                    TextSpan(
                      text: "Don't have account ",
                      style: const TextStyle(
                        color: AppColor.hintTxt,
                        fontFamily: AppFonts.artegraSoft,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: "Sign Up",
                          style:   TextStyle(
                            fontFamily: AppFonts.artegraSoft,
                            fontSize: 12,
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(() => const SignUpScreenNew());
                            },
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
        // Floating Action Button (Support Icon)
        floatingActionButton: const SupportButton());
  }

  // ================= TAB BUTTON =================
  Widget _tabButton(
      {required String title, required LoginType type, double? fontSize}) {
    final bool isSelected = _loginType == type;

    // Text color: green for نفاذ, black for others
    Color textColor;
    if (type == LoginType.nafaz) {
      textColor = const Color(0xff258675);
    } else {
      textColor = Colors.black;
    }

    return GestureDetector(
      onTap: () => setState(() => _loginType = type),
      child: Container(
         // fixed width
        height: 50,
        // fixed height
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xffECC7A7) : Colors.white,
          borderRadius: BorderRadius.circular(10), // radius 10px
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: title == 'نفاذ' ? 20 : 13,
            height: 1.0,
            letterSpacing: 0,
            color: textColor,
            fontFamily: AppFonts.artegraSoft,
          ),
        ),
      ),
    );
  }

  // ================= INPUT SWITCH =================
  Widget _buildLoginFields() {
    switch (_loginType) {
      case LoginType.email:
        return Column(
          children: [
            _emailInput(),
            const SizedBox(height: 16),
            _passwordInput(),
          ],
        );

      case LoginType.phone:
        return _phoneInput();

      case LoginType.nafaz:
        return _nafazInput();
    }
  }

  // ================= EMAIL INPUT =================
  Widget _emailInput() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x30000000),
            offset: Offset(0, 0),
            blurRadius: 23.3,
            spreadRadius: -3,
          ),
        ],
      ),
      child: TextField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 1.0,
          letterSpacing: 0,
          color: Colors.black,
        ),
        decoration: const InputDecoration(
          hintText: "Enter your email",
          hintStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            fontFamily: AppFonts.artegraSoft,
            height: 1.0,
            color: AppColor.hintTxt,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
      ),
    );
  }

  // ================= PASSWORD INPUT =================
  Widget _passwordInput() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: "Enter your password",
          hintStyle: TextStyle(
            fontSize: 14,
            fontFamily: AppFonts.artegraSoft,
            fontWeight: FontWeight.w600,
            color: AppColor.hintTxt,
          ),
          border: InputBorder.none,
          suffixIcon: Icon(Icons.visibility_off),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
      ),
    );
  }

  // ================= PHONE INPUT =================
  Widget _phoneInput() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x30000000),
            offset: Offset(0, 0),
            blurRadius: 23.3,
            spreadRadius: -3,
          ),
        ],
      ),
      child: TextField(
        controller: phoneController,
        keyboardType: TextInputType.phone,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Saudi Flag
                Container(
                  width: 32,
                  height: 22,
                  decoration: BoxDecoration(
                    color: const Color(0xff165D31),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Text(
                      '🇸🇦',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Country Code
                const Text(
                  "+966",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFonts.artegraSoft,
                    fontSize: 16,
                    color: AppColor.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          hintText: "",
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
      ),
    );
  }
  // ================= NAFZ INPUT =================
  Widget _nafazInput() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x30000000),
            offset: Offset(0, 0),
            blurRadius: 23.3,
            spreadRadius: -3,
          ),
        ],
      ),
      child: TextField(
        controller: nafazController,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        decoration: const InputDecoration(
          hintText: "Enter id number",
          hintStyle: TextStyle(
            fontSize: 14,
            fontFamily: AppFonts.artegraSoft,
            fontWeight: FontWeight.w600,
            color: AppColor.hintTxt,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
      ),
    );
  }
}


// ================= EXAMPLE SIGN UP SCREEN =================
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Sign Up',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: const Center(
        child: Text(
          'Sign Up Screen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

