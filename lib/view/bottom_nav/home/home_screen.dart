import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_fonts/app_fonts.dart';
import 'package:meter_app/utils/backend_util/constant_util.dart';
import 'package:meter_app/view/auth/Login/login_screen.dart';
import 'dart:async';

import 'package:meter_app/view/bottom_nav/account/account_main.dart';
import 'package:meter_app/view/bottom_nav/chat/chat_main.dart';
import 'package:meter_app/view/bottom_nav/home/seller_home/publish_device/publish_device.dart';
import 'package:meter_app/view/bottom_nav/home/service_screen.dart';
import 'package:meter_app/view/bottom_nav/home/survey_screen..dart';
import 'package:meter_app/widget/text_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../../gen/assets.gen.dart';
import '../../../controller/bottom_nav_controller/bottom_nav_controller_main.dart';
import '../../../controller/bottom_nav_controller/home_controller.dart';
import '../../../res/app_assets/app_image.dart';
import '../../../services/db_services.dart';
import '../../../utils/app_textstyle.dart';
import '../../../utils/backend_util/date_time_util.dart';
import '../../../utils/backend_util/query_util.dart';
import '../../../widget/app_bar.dart';
import '../../../widget/backend/custom_stream_builder.dart';
import '../../../widget/containers/button.dart';
import '../../../widget/containers/edit_device_widget.dart';
import '../../../widget/containers/request_container.dart';
import '../../../widget/custom_loading.dart';
import '../../../widget/success.dart';
import '../../../widget/textfield.dart';
import '../requests/requests_main.dart';
import '../store/store_detail.dart';
import 'device_screen.dart';
import 'eng_screen.dart';

// Main Home Screen with Bottom Navigation
class MainHomeScreen extends StatefulWidget {
  final String? userType;
  const MainHomeScreen({Key? key, this.userType}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  late final List<Widget> _screens = [
    HomeScreen(
      userType: widget.userType,
    ),
    DevicesScreen(),
    const RequestsMain(),
    ChatMain(),
    AccountMain(
      userType: widget.userType.toString(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController =
        Get.put(BottomNavController());

    return Obx(() {
      bool isSeller = widget.userType == ConstantUtil.seller;
      bool isProvider = widget.userType == ConstantUtil.provider;

      List<BottomNavigationBarItem> items = [
        BottomNavigationBarItem(
          icon: Image.asset(
            AppImage.home,
            width: 22,
            height: 22,
          ),
          activeIcon: Image.asset(
            AppImage.homeActive,
            width: 24,
            height: 24,
          ),
          label: "Home".tr,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            AppImage.store,
            width: 22,
            height: 22,
          ),
          activeIcon: Image.asset(
            AppImage.storeActive,
            width: 24,
            height: 24,
          ),
          label: !isSeller ? "Store".tr : "My devices",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            AppImage.requests,
            width: 22,
            height: 22,
          ),
          activeIcon: Image.asset(
            AppImage.requestsActive,
            width: 24,
            height: 24,
          ),
          label: isProvider ? "Proposals".tr : "Requests".tr,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            AppImage.chat,
            width: 22,
            height: 22,
          ),
          activeIcon: Image.asset(
            AppImage.chatActive,
            width: 24,
            height: 24,
          ),
          label: "Chat".tr,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            AppImage.account,
            width: 22,
            height: 22,
          ),
          activeIcon: Image.asset(
            AppImage.accountActive,
            width: 24,
            height: 24,
          ),
          label: "Account".tr,
        ),
      ];

      return Scaffold(
        body: _screens[bottomNavController.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          items: items,
          showUnselectedLabels: true,
          backgroundColor: Colors.transparent,
          currentIndex: bottomNavController.currentIndex.value,
          selectedItemColor: AppColor.primaryColor,
          unselectedItemColor: AppColor.semiTransparentDarkGrey,
          iconSize: 18,
          selectedLabelStyle: GoogleFonts.poppins(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
          onTap: (index) {
            bottomNavController.onIndexChange(index);
          },
        ),
      );
    });
  }
}

// Home Screen
class HomeScreen extends StatefulWidget {
  final String? userType;
  const HomeScreen({Key? key, this.userType}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final PageController _carouselController = PageController();
  int _currentCarouselPage = 0;
  Timer? _carouselTimer;
  late AnimationController _fadeController;

  String _selectedLanguage = 'English';
  String _selectedLanguageFlag = '🇺🇸';

  final List<BannerItem> _bannerItems = [
    BannerItem(
      type: BannerType.image,
      url: Assets.images.image1.path,
    ),
    BannerItem(
      type: BannerType.image,
      url: Assets.images.image2.path,
    ),
    BannerItem(
      type: BannerType.video,
      url: Assets.images.bannn,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _startAutoScroll();
  }

  void _startAutoScroll() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      if (_currentCarouselPage < _bannerItems.length - 1) {
        _currentCarouselPage++;
      } else {
        _currentCarouselPage = 0;
      }

      _carouselController.animateToPage(
        _currentCarouselPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _carouselController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildLanguageBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.userType == ConstantUtil.seller ||
              widget.userType == ConstantUtil.provider
          ? CustomHomeAppBar(
              title: "Makka, Saudi Arabia".tr,
            )
          : null,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeController,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.userType == ConstantUtil.customer) ...[
                    _customerView()
                  ] else if (widget.userType == ConstantUtil.provider) ...[
                    SizedBox(
                      height: 1.h,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Good Morning, ',
                            style: AppTextStyle.dark20,
                          ),
                          TextSpan(
                            text: "MonGe !",
                            style: AppTextStyle.dark20.copyWith(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '!',
                            style: AppTextStyle.dark20.copyWith(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    const TextWidget(
                        title: "There are a lot of requests waiting for you",
                        textColor: AppColor.semiTransparentDarkGrey,
                        fontSize: 14),
                    CustomTextField(
                      controller: controller.searchController,
                      hintText: "Search",
                      title: "",
                      showSpace: true,
                      prefixImagePath: AppImage.search,
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    const TextWidget(
                      title: "Requests Near You",
                      textColor: AppColor.semiDarkGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (itemBuilder, index) {
                        return const RequestContainer(
                          buttonText: "Apply Now",
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: Get.height * 0.02,
                        );
                      },
                    )
                  ] else ...[
                    SizedBox(
                      height: 1.h,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Good Morning, ',
                            style: AppTextStyle.dark20,
                          ),
                          TextSpan(
                            text: "MonGe !",
                            style: AppTextStyle.dark20.copyWith(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '!',
                            style: AppTextStyle.dark20.copyWith(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    const TextWidget(
                        title: "Choose your service and start",
                        textColor: AppColor.semiTransparentDarkGrey,
                        fontSize: 16),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    MyCustomButton(
                        iconPath: AppImage.service,
                        textColor: AppColor.primaryColor,
                        borderSideColor: AppColor.primaryColor,
                        title: "Publish a device".tr,
                        backgroundColor: Colors.transparent,
                        onTap: () {
                          Get.to(const PublishDevice(
                            isUpdate: false,
                          ));
                        }),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    const TextWidget(
                      title: "My Devices",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      textColor: AppColor.semiDarkGrey,
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    CustomStreamBuilder(
                      stream: QueryUtil.fetchDevices(),
                      builder: (context, devices) {
                        log("Devices length is ${devices!.length}");
                        return GridView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Number of columns
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              childAspectRatio: 0.4,
                            ),
                            itemCount: devices.length,
                            itemBuilder: (itemBuilder, index) {
                              final data = devices[index];
                              return EditDeviceWidget(
                                  date: DateTimeUtil.reformatDate(
                                      data.timestamp.toString()),
                                  onClick: () {
                                    Get.to(StoreDetail(
                                      showChatIcon: false,
                                      deviceModel: data,
                                    ));
                                  },
                                  deviceName: data.deviceName,
                                  deviceModel: data.deviceModel,
                                  onDeleteTap: () {
                                    Get.dialog(LogoutDialogue(
                                        title: "Delete Device",
                                        description:
                                            "Are you sure you want to delete device?",
                                        mainButtonText: "Delete",
                                        mainButtonTap: () async {
                                          await DbServices.deleteDevice(
                                              data.id);
                                          Get.back();
                                        }));
                                  },
                                  onEditTap: () {
                                    Get.to(PublishDevice(
                                      isUpdate: true,
                                      deviceModel: data,
                                    ));
                                  },
                                  imageUrl: data.deviceImage);
                            });
                      },
                      loadingWidget: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.2,
                          ),
                          const CustomLoading(),
                        ],
                      ),
                    )
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customerView() {
    return Column(
      children: [
        Stack(
          children: [
            // Grid design overlay at top - scrolls with content
            Align(
              alignment: Alignment.topLeft,
              child: SvgPicture.asset(
                Assets.images.grid,
                width: 130,
                height: 100,
                color: AppColor.greyColor,
                fit: BoxFit.contain,
              ),
            ),
            // Header and search bar on top
            Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 15),
                _buildSearchBar(),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildCarousel(),
        const SizedBox(height: 6),
        _buildServicesSection(),
        const SizedBox(height: 6),
        _buildWorkProgramsSection(),
        const SizedBox(height: 22),
        _buildExploreProductsSection(),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: TextWidget(
              title: 'Welcome to the Meter platform',
              fontSize: 13,
              fontWeight: FontWeight.bold,
              textColor: AppColor.lightblueTxt,
              // fontFamily: AppFonts.artegraSoft,
              // letterSpacing: -0.3,
            ),
          ),
          GestureDetector(
            onTap: _showLanguageSelector,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(_selectedLanguageFlag,
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 6),
                  Text(
                    _selectedLanguage,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColor.lightblackTxt,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down,
                      size: 18, color: Color(0xFF6B7280)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageBottomSheet() {
    String tempSelectedLanguage = _selectedLanguage;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setModalState) {
        return Container(
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
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select language',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _buildLanguageOption(
                      context: context,
                      flag: '🇺🇸',
                      language: 'English',
                      isSelected: tempSelectedLanguage == 'English',
                      onTap: () {
                        setModalState(() {
                          tempSelectedLanguage = 'English';
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildLanguageOption(
                      context: context,
                      flag: '🇸🇦',
                      language: 'Arabic',
                      isSelected: tempSelectedLanguage == 'Arabic',
                      onTap: () {
                        setModalState(() {
                          tempSelectedLanguage = 'Arabic';
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildLanguageOption(
                      context: context,
                      flag: '🇨🇳',
                      language: 'Chinese',
                      isSelected: tempSelectedLanguage == 'Chinese',
                      onTap: () {
                        setModalState(() {
                          tempSelectedLanguage = 'Chinese';
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedLanguage = tempSelectedLanguage;
                        _selectedLanguageFlag =
                            tempSelectedLanguage == 'English'
                                ? '🇺🇸'
                                : tempSelectedLanguage == 'Arabic'
                                    ? '🇸🇦'
                                    : '🇨🇳';
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF8A3D),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Change',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required String flag,
    required String language,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFDECEC) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                isSelected ? const Color(0xFFFDECEC) : const Color(0xFFE5E7EB),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                language,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFF1F2937)
                      : const Color(0xFF6B7280),
                ),
              ),
            ),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF8A3D),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 16, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColor.searchcolor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: 'Find the service you want',
            hintStyle: TextStyle(
                color: AppColor.searchcolor,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                fontFamily: AppFonts.artegraSoft),
            prefixIcon: Icon(
              Icons.search,
              color: AppColor.searchcolor,
              size: 25,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _carouselController,
            onPageChanged: (index) {
              setState(() {
                _currentCarouselPage = index;
              });
            },
            itemCount: _bannerItems.length,
            itemBuilder: (context, index) {
              return _buildBannerCard(_bannerItems[index]);
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_bannerItems.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentCarouselPage == index ? 8 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentCarouselPage == index
                    ? const Color(0xFFFF8A3D)
                    : const Color(0xFFD1D5DB),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildBannerCard(BannerItem banner) {
    return GestureDetector(
      onTap: () {
        print('Banner tapped: ${banner.type}');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.1),
          //     blurRadius: 8,
          //     offset: const Offset(0, 4),
          //   ),
          // ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 170,
            width: double.infinity,
            child: banner.type == BannerType.image
                ? Image.asset(
                    banner.url,
                    fit: BoxFit.fitWidth, // preserves height, avoids cropping
                    alignment: Alignment.topCenter, // adjust if needed
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 60,
                          color: Colors.white70,
                        ),
                      );
                    },
                  )
                : _VideoBanner(url: banner.url), // existing video widget
          ),
        ),
      ),
    );
  }

  Widget _buildServicesSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Services',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColor.homeTxt,
                  fontFamily: AppFonts.artegraSoft,
                  letterSpacing: -0.3,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const ServicesScreen());
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColor.themeColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'show more',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 115,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              _buildServiceCard('Survey',
                  imagePath: Assets.images.icon11.path, onTap: () {
                Get.to(const SurveyScreen());
              }),
              _buildServiceCard('Engineering',
                  imagePath: Assets.images.icon21.path, onTap: () {
                Get.to(const EngineeringServicesScreen());
              }),
              _buildServiceCard('Designing',
                  imagePath: Assets.images.icon31.path, onTap: () {
                Get.to(const LoginScreen());
              }),
              _buildServiceCard('Training',
                  imagePath: Assets.images.icon41.path, onTap: () {
                Get.to(const LoginScreen());
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard(
    String title, {
    String? imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        child: Column(
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
                      imagePath,
                      width: 70,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.image_not_supported,
                          size: 28,
                          color: Color(0xFF9CA3AF),
                        );
                      },
                    )
                  : const Icon(Icons.settings,
                      size: 28, color: Color(0xFF374151)),
            ),
            const SizedBox(height: 6), // Reduced from 8
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

  Widget _buildWorkProgramsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Work programs', // Changed from 'Work programs'
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColor.homeTxt,
              letterSpacing: -0.3,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildWorkProgramCard('AutoDesk',
                  imagePath: Assets.images.icon51.path),
              _buildWorkProgramCard('Design your own',
                  imagePath: Assets.images.icon61.path),
              _buildWorkProgramCard('Measurements',
                  imagePath: Assets.images.icon71.path),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWorkProgramCard(String title, {String? imagePath}) {
    return GestureDetector(
      onTap: () {
        Get.to(const LoginScreen());
        print('Work program tapped: $title');
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 45,
              child: imagePath != null
                  ? Image.asset(
                      imagePath,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.lightbulb_outline,
                          size: 24,
                          color: Color(0xFF374151),
                        );
                      },
                    )
                  : const Icon(Icons.lightbulb_outline,
                      size: 24, color: Color(0xFF374151)),
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

  Widget _buildExploreProductsSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Explore products',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColor.homeTxt,
                  letterSpacing: -0.3,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const LoginScreen());
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColor.themeColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'show more',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: _buildProductCard(
                  'WingtraOne',
                  4.5,
                  imagePath: Assets.images.image8.path,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildProductCard(
                  'Product Name',
                  4.0,
                  imagePath: Assets.images.image9.path,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(
    String productName,
    double rating, {
    required String imagePath,
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(const LoginScreen());
        print('Product tapped: $productName');
      },
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Cart icon
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF5F0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 18,
                  color: Color(0xFFFF8A3D),
                ),
              ),
            ),

            // CENTER PRODUCT IMAGE
            Center(
              child: Container(
                width: 80,
                height: 80,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) {
                    return const Icon(
                      Icons.image_not_supported,
                      size: 40,
                      color: Color(0xFF9CA3AF),
                    );
                  },
                ),
              ),
            ),

            // Product name & rating
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  Text(
                    productName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.artegraSoft,
                      color: AppColor.lightblackTxt,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '•',
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        rating.toString(),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.star,
                          size: 14, color: Color(0xFFFFA500)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder screens for bottom navigation
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.favorite, size: 80, color: Color(0xFFFF8A3D)),
            SizedBox(height: 16),
            Text(
              'No favorites yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Requests',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.description, size: 80, color: Color(0xFFFF8A3D)),
            SizedBox(height: 16),
            Text(
              'No requests yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Orders',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.shopping_bag, size: 80, color: Color(0xFFFF8A3D)),
            SizedBox(height: 16),
            Text(
              'No orders yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.person, size: 80, color: Color(0xFFFF8A3D)),
            SizedBox(height: 16),
            Text(
              'Profile',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum BannerType { image, video }

class BannerItem {
  final BannerType type;
  final String url;

  BannerItem({
    required this.type,
    required this.url,
  });
}

class _VideoBanner extends StatefulWidget {
  final String url;

  const _VideoBanner({required this.url});

  @override
  State<_VideoBanner> createState() => _VideoBannerState();
}

class _VideoBannerState extends State<_VideoBanner> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.url)
      ..initialize().then((_) {
        setState(() {});
        _controller
          ..setLooping(true)
          ..setVolume(0)
          ..play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      ),
    );
  }
}
