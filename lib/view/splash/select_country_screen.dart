import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:meter_app/res/app_color/app_color.dart';

import '../../../utils/backend_util/auth_util.dart';
import '../../../widget/loading_dialog.dart';
import 'welcome_screen.dart';
class SelectCountryScreen extends StatefulWidget {
  const SelectCountryScreen({super.key});

  @override
  State<SelectCountryScreen> createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  String selectedCountry = 'UAE';

  final List<Map<String, String>> countries = [
    {'name': 'Saudi Arabia', 'flag': '🇸🇦'},
    {'name': 'UAE', 'flag': '🇦🇪'},
    {'name': 'Australia', 'flag': '🇦🇺'},
    {'name': 'China', 'flag': '🇨🇳'},
    {'name': 'Bahrain', 'flag': '🇧🇭'},
    {'name': 'Kuwait', 'flag': '🇰🇼'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ WHITE background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),

              /// Language selector
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🇺🇸'),
                      const SizedBox(width: 6),
                      Text('English',style: TextStyle(fontSize: 10,color: AppColor.lightblackTxt),),
                      const SizedBox(width: 4),
                      const Icon(Icons.keyboard_arrow_down, size: 18),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              /// LOGO (TOP CENTER)
              Image.asset(
                'assets/images/meter.webp',
                height: 80,
                fit: BoxFit.contain,
              ),


              const SizedBox(height: 15),
              SvgPicture.asset("assets/images/slect.svg"),
              const SizedBox(height: 6),

              const Text(
                'Please select your country to continue',
                style: TextStyle(
                  color: Color(0xff797B88),
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 25),

              /// Country List
              Expanded(
                child: ListView.separated(
                  itemCount: countries.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final country = countries[index];
                    final isSelected =
                        country['name'] == selectedCountry;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCountry = country['name']!;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 18),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xffDE81311A).withOpacity(0.1)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFFF7931E)
                                : Colors.grey.shade300,
                            width: 1.4,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              country['flag']!,
                              style: const TextStyle(fontSize: 24),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                country['name']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: Color(0xFFF7931E),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// Continue Button
              GestureDetector(
                onTap: () async{
                  showLoadingDialog(context);

                  await Future.delayed(const Duration(seconds: 3));

                  Navigator.of(context).pop();
                  Get.off(const WelcomeScreen());
                  },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  width: double.infinity,
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    // color: Color(0xffDE8131)
                    gradient: AuthUtil().linearGradient
                    // gradient: const LinearGradient(
                    //   colors: [
                    //     Color(0xffDE8131)
                    //     // Color(0xFFFBB26A),
                    //     // Color(0xFFF7931E),
                    //   ],
                    // ),
                  ),
                  child: const Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
