import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/utils/backend_util/auth_util.dart';
import 'package:sizer/sizer.dart';

import '../../../res/app_fonts/app_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -41,
              left: -7,
              child: SizedBox(
                width: 102.24,
                height: 200.50,
                child: Column(
                  children: [
                    // Row(
                    //   children: [
                    //     Container(
                    //       width: 50,
                    //       height: 50,
                    //       decoration: BoxDecoration(
                    //         border: Border.all(
                    //           color: const Color(0xffDBDBDB),
                    //           width: 1,
                    //         ),
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //     ),
                    //     const SizedBox(width: 2),
                    //     Container(
                    //       width: 50,
                    //       height: 50,
                    //       decoration: BoxDecoration(
                    //         border: Border.all(
                    //           color: const Color(0xffDBDBDB),
                    //           width: 1,
                    //         ),
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 2),
                    // Row(
                    //   children: [
                    //     Container(
                    //       width: 50,
                    //       height: 50,
                    //       decoration: BoxDecoration(
                    //         border: Border.all(
                    //           color: const Color(0xffDBDBDB),
                    //           width: 1,
                    //         ),
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //     ),
                    //     const SizedBox(width: 2),
                    //     Container(
                    //       width: 50,
                    //       height: 50,
                    //       decoration: BoxDecoration(
                    //         border: Border.all(
                    //           color: const Color(0xffDBDBDB),
                    //           width: 1,
                    //         ),
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 2),
                    // Row(
                    //   children: [
                    //     Container(
                    //       width: 50,
                    //       height: 50,
                    //       decoration: BoxDecoration(
                    //         border: Border.all(
                    //           color: const Color(0xffDBDBDB),
                    //           width: 1,
                    //         ),
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //     ),
                    //     const SizedBox(width: 2),
                    //     Container(
                    //       width: 50,
                    //       height: 50,
                    //       decoration: BoxDecoration(
                    //         border: Border.all(
                    //           color: const Color(0xffDBDBDB),
                    //           width: 1,
                    //         ),
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Center(child: Image.asset("assets/images/grid2.png")),

                  ],
                ),
              ),
            ),
            Column(
              children: [
                // Top App Bar with Back Button
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsetsGeometry.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),

                // Logo
                Image.asset(
                  'assets/images/meter.webp', // Replace with your logo asset
                  height: 80,
                ),

                const SizedBox(height: 30),

                // Main Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        // const Center(
                        //   child: Text(
                        //     'Forgot Password?',
                        //     style: TextStyle(
                        //       fontSize: 23,
                        //       fontWeight: FontWeight.w900,
                        //       color: Colors.black,
                        //       fontFamily: AppFonts.artegraSoft,
                        //     ),
                        //   ),
                        // ),
                        Center(child: SvgPicture.asset("assets/images/forg.svg")),

                        const SizedBox(height: 12),

                        // Subtitle
                        const Center(
                          child: Text(
                            'Please enter your email to reset the password',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.greyTxt,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFonts.artegraSoft,
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Email Input Field
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Enter your email',
                              hintStyle:   TextStyle(
                                color: AppColor.hintTxt,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: AppFonts.artegraSoft,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 20,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // Bottom Section
                Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
    child: SizedBox(
    width: double.infinity,
    height: 45,
    child: ElevatedButton(
    style: ElevatedButton.styleFrom(
    padding: EdgeInsets.zero,
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
    ),
    ),
    onPressed: () {},
    child: Ink(
    decoration: BoxDecoration(
    gradient: AuthUtil().linearGradient,
    borderRadius: BorderRadius.circular(15),
    ),
    child: Container(
    alignment: Alignment.center,
    child: const Text(
    "Reset Password",
    style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    ),
    ),
    ),
    ),
    ),
    ),
    ),

    const SizedBox(height: 10),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child:   Text(
                        'Login using',
                        style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ],
        ),
      ),

      // Floating Action Button (Support Icon)
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            print('Support button pressed');
          },
          backgroundColor: Colors.white,
          child: Icon(
            Icons.person,
            color: Colors.orange[400],
            size: 30,
          ),
        ),
      ),
    );
  }
}
