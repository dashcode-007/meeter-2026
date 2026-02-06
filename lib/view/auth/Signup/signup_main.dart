import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/auth_controller/main_auth_controller.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/utils/backend_util/constant_util.dart';
import 'package:meter_app/widget/containers/auth_role_container.dart';
import 'customer_login/customer_main.dart';
import 'provider_login/provider_main.dart';
import 'seller_login/seller_main.dart';

class SignupMain extends StatelessWidget {
  const SignupMain({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainAuthController>();
    return Obx(() => Column(
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              children: [
                AuthRoleContainer(
                  onTap: () {
                    controller.switchToNewRole(ConstantUtil.seller);
                  },
                  imagePath: AppImage.sellerPerson,
                  title: ConstantUtil.seller.tr,
                  isActive: controller.selectedRole.value == ConstantUtil.seller,
                  activeImagePath: AppImage.sellerPersonActive,
                ),
                SizedBox(
                  width: Get.width * 0.02,
                ),
                AuthRoleContainer(
                  onTap: () {
                    controller.switchToNewRole(ConstantUtil.customer);
                  },
                  imagePath: AppImage.customerPerson,
                  title: ConstantUtil.customer.tr,
                  isActive: controller.selectedRole.value == ConstantUtil.customer,
                  activeImagePath: AppImage.customerPersonActive,
                ),
                SizedBox(
                  width: Get.width * 0.02,
                ),
                AuthRoleContainer(
                  onTap: () {
                    controller.switchToNewRole(ConstantUtil.provider);
                  },
                  imagePath: AppImage.providedPerson,
                  title: ConstantUtil.provider.tr,
                  isActive: controller.selectedRole.value == ConstantUtil.provider,
                  activeImagePath: AppImage.providedPersonActive,
                ),
              ],
            ),
            if (controller.selectedRole.value == ConstantUtil.seller)
              const SellerLoginMain(userType: ConstantUtil.seller,),
            if (controller.selectedRole.value == ConstantUtil.customer)
              const CustomerLoginMain(userType: ConstantUtil.customer,),
            if (controller.selectedRole.value == ConstantUtil.provider)
              const ProviderLoginMain(userType: ConstantUtil.seller,),
          ],
        ));
  }
}
