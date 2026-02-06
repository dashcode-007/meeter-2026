import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:meter_app/model/requestServices/request_services_model.dart';
import 'package:meter_app/services/db_services.dart';
import 'package:meter_app/utils/backend_util/constant_util.dart';
import 'package:meter_app/utils/backend_util/dbutil.dart';
import 'package:meter_app/utils/backend_util/error_util.dart';
import 'package:meter_app/utils/backend_util/image_util.dart';
import 'package:meter_app/utils/short_message_utils.dart';
import 'package:meter_app/view/bottom_nav/bottom_nav_main.dart';

import '../../../utils/backend_util/auth_util.dart';
import '../../../view/home/bottom_nav.dart';
import '../../../widget/success.dart';

class EngineeringRequestServiceController extends GetxController {
  final TextEditingController otherController =
      TextEditingController(); // Added
  final TextEditingController specialistController =
      TextEditingController(); // Added
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController cityController = TextEditingController(); // Added
  final TextEditingController emailController =
      TextEditingController(); // Added
  final TextEditingController nameController = TextEditingController(); // Added

  final engineeringJobFormKey = GlobalKey<FormState>();

  void clearAllFields() {
    otherController.clear();
    specialistController.clear();
    experienceController.clear();
    emailController.clear();
    nameController.clear();
  }

  RxString flagUri = "flags/sa.png".obs;
  RxString countryCode = "+966".obs;
  RxString countryShortCode = "SA".obs;
  var isPayMeterChecked = false.obs;
  var isAccuracyChecked = false.obs;
  var isAgreeTermsChecked = false.obs;

  bool get areAllChecked =>
      isPayMeterChecked.value &&
      isAccuracyChecked.value &&
      isAgreeTermsChecked.value;

  String fullPhoneNumber() {
    return "${countryCode.value}${phoneNumberController.text}";
  }

  bool validatePhoneNumber() {
    return AuthUtil.validatePhoneNumber(fullPhoneNumber(), countryCode.value);
  }

  RxString filePath = "".obs;
  RxString fileName = "".obs;

  RxBool isLoading = false.obs;

  Future<void> completeEngineeringJob(GlobalKey<FormState> _formKey) async {
    // try {
    //   isLoading.value = true;
    //   if (_formKey.currentState!.validate() &&
    //       validatePhoneNumber() &&
    //       areAllChecked &&
    //       filePath.isNotEmpty) {
    //     String fileUrl = await ImageUtil.uploadToDatabase(filePath.value);
    //     RequestServicesModel requestServicesModel = RequestServicesModel(
    //         id: DbUtil.getAutoUid()!,
    //         role: ConstantUtil.customer,
    //         userUID: DbUtil.getCurrentUid()!,
    //         activityType: ConstantUtil.engineeringJob,
    //         certificateType: selectedTypeOfCertificate.value,
    //         specializations: specialistController.text,
    //         haveExperience: selectedExperience.value,
    //         experience: experienceController.text,
    //         preferredCityWork: cityController.text,
    //         email: emailController.text,
    //         name: nameController.text,
    //         phoneNumber: fullPhoneNumber(),
    //         documentImage: fileUrl);
    //     await DbServices.addRequestService(requestServicesModel);
    //     Get.bottomSheet(
    //       isDismissible: false,
    //       enableDrag: false,
    //       CustomSuccessScreen(
    //         title: "Post Job",
    //         buttonTitle: "Done",
    //         desc: "Your job has been posted. Click to show providers proposals",
    //         onDoneTap: () {
    //           Get.offAll(const BottomNavScreenNew());
    //         },
    //       ),
    //     );
    //   } else {
    //     if (!_formKey.currentState!.validate()) {
    //       ShortMessageUtils.showError("Please fill all fields");
    //     } else if (!validatePhoneNumber()) {
    //       ShortMessageUtils.showError("Please enter valid phone number");
    //     } else if (filePath.isEmpty) {
    //       ShortMessageUtils.showError("Please upload your document");
    //     } else {
    //       ShortMessageUtils.showError("You must agree all");
    //     }
    //   }
    // } catch (e) {
    //   ErrorUtil.handleDatabaseErrors(e);
    // } finally {
    //   isLoading.value = false;
    // }
  }

  void toggleAgreeTerms(bool? value) {
    isAgreeTermsChecked.value = value ?? false;
  }

  void togglePayMeter(bool? value) {
    isPayMeterChecked.value = value ?? false;
  }

  void toggleAccuracyChecked(bool? value) {
    isAccuracyChecked.value = value ?? false;
  }

  void onChangeFlag(String changedUri, String code, String country) {
    flagUri.value = changedUri; // Update the flag image URI.
    countryCode.value = code; // Update the country code.
    countryShortCode.value = country; // Update the country's short code.
    print("$code $country");
  }

  final TextEditingController phoneNumberController = TextEditingController();

  var selectedTypeOfCertificate = "University Degree".obs;

  var isOtherRequired = false.obs;

  void selectTypeOfCertificate(String value) {
    if (selectedTypeOfCertificate.value == value) {
      selectedTypeOfCertificate.value =
          ""; // Unselect if the same value is selected again
    } else {
      selectedTypeOfCertificate.value = value; // Select the new value
    }
    isOtherRequired.value = selectedTypeOfCertificate.value.isEmpty;
  }

  void onChangeOtherValue(String newValue) {
    selectedTypeOfCertificate.value = newValue;
  }

  var selectedExperience = "Yes".obs;

  void selectExperience(String value) {
    selectedExperience.value = value;
  }

  RxString selectedPurpose = "Surveying engineer".obs;
  final List purposeOfPricingList = [
    "Surveying engineer",
    "Structural engineer",
    "Safety engineer",
    "Other",
  ];
  void selectPurposeOfPricing(String value) {
    selectedPurpose.value = value;
    specialistController.text = value;
  }
}
