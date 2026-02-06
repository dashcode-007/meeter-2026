import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_fonts/app_fonts.dart';
import 'package:meter_app/utils/pref_util.dart';
import 'package:meter_app/view/auth/Login/login_screen.dart';
import 'package:meter_app/view/auth/main_auth.dart';
import 'package:meter_app/view/bottom_nav/account/pivacy_policy.dart';
import 'package:meter_app/view/bottom_nav/account/select_country_screen.dart';
import 'package:meter_app/view/bottom_nav/account/terms_of_service.dart';
import 'package:meter_app/view/bottom_nav/home/home_screen.dart';
import '../../../controller/bottom_nav_controller/account_controller/profile_controller.dart';
import '../../../controller/user/user_controller.dart';
import '../../../res/app_assets/app_image.dart';
import '../../../widget/custom_row.dart';
import '../../../widget/profile_header.dart';
import 'edit_user_info.dart';
import 'help_center.dart';

class AccountMain extends StatelessWidget {
 final String userType;
  AccountMain({super.key, required this.userType});
 final controller = Get.put(ProfileController());

  final UserController userController = Get.put(UserController());

  /// CARD DECORATION (FOR OPTION TILES + DELETE ACCOUNT)
  BoxDecoration _cardDecoration({Color? color}) {
    return BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        const BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    userController.fetchUserData("kucKPLca7AnJq2agkZfq");

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [

               Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5.0),
                    child: const CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage(AppImage.profile),
                    ),
                  ),
                  const SizedBox(width: 8),
                    Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(
                              fontSize: 12, color: AppColor.surveycreenTxt,
                              fontFamily: AppFonts.artegraSoft,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text(
                          userType,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700,
                              fontFamily: AppFonts.artegraSoft,
                              color: AppColor.lightblackTxt
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: const StadiumBorder(),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    ),
                    onPressed: () {
                      Get.bottomSheet(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          const EditUserInfo(),
                          backgroundColor: AppColor.whiteColor);                    },
                    child: const Text("Edit"),
                  )
                ],
              ),

              const SizedBox(height: 10),

              /// 🔹 VERIFY EMAIL CARD (FLAT, NO SHADOW)
              // Container(
              //   margin: const EdgeInsets.only(top: 10),
              //   padding: const EdgeInsets.all(10),
              //   decoration: BoxDecoration(
              //     color: const Color(0xffFDECEC),
              //     borderRadius: BorderRadius.circular(14),
              //   ),
              //   child: Row(
              //     children: [
              //       const Icon(Icons.info, color: Colors.orange),
              //       const SizedBox(width: 10),
              //       const Expanded(
              //         child: Text("You must verify your email",
              //           style: TextStyle(
              //               fontSize: 12, color:  Color(0xff7E6F44),
              //               fontFamily: AppFonts.artegraSoft,
              //               fontWeight: FontWeight.w400
              //
              //           ),),
              //       ),
              //       TextButton(
              //         onPressed: () {},
              //         child: const Text("check",style: TextStyle(color: Color(0xff7E6F44)),),
              //       )
              //     ],
              //   ),
              // ),
              //
              // const SizedBox(height: 10),

              /// 🔹 OPTIONS
              Expanded(
                child: ListView(
                  children: [
                    _tile("Country", onTap: () {
                      Get.to(() => SelectCountryScreen());
                    }),

                    _tile("Help Center",onTap: (){
                      Get.to(const HelpCenter());

                    }),
                    _tile("Terms Of Services",onTap: (){
                      Get.to(const TermsOfService());

                    }),
                    _tile("Privacy Policy",onTap: (){
                      Get.to(const PrivacyPolicy());

                    }),
                    _tile("About App",onTap: (){

                    }),
                    _tile('Technical Support Chat',onTap: (){

                    }),


                    /// 🔹 DELETE ACCOUNT (WITH SHADOW)
                    _tile("Delete Account", textColor: Colors.orange),
                  ],
                ),
              ),

              /// 🔹 LOGOUT BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.red),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFDECEC),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    // PrefUtil.remove(PrefUtil.userId);
                    Get.offAll(LoginScreen());
                    userType == '';
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 COMMON TILE (WITH SHADOW)
  Widget _tile(String title, {Color textColor = AppColor.lightblackTxt, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: _cardDecoration(),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontFamily: AppFonts.artegraSoft,
              fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap, // Use the passed function
      ),
    );
  }

}