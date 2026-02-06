import 'package:get/get.dart';
import 'package:meter_app/model/auth/auth_model.dart';
import 'package:meter_app/services/db_services.dart';

class UserController extends GetxController {
  var user = AuthModel(
    userId: '',
    role: '',
    serviceProvider: '',
    facilityName: '',
    facilityNumber: '',
    commercialRegistration: '',
    facilityActivity: '',
    ownerName: '',
    phoneNumber: '',
    managerName: '',
    managerPhoneNumber: '',
    descriptionOfServices: '',
    profilePicture: '',
    isFaceVerify: false,
    isFingerVerify: false,
    region: '',
    city: '',
    neighborhood: '',
    location: '',
    password: '',
    timestamp: DateTime.now(),
    fileUrl: '',
    email: '',
    typeOfActivity: '',
    licenseNumber: '',
    commercialRegistrationDate: '',
    iosCommercialRegistrationDate: '',
  ).obs;

  final DbServices _userService = DbServices();

  void fetchUserData(String userId) async {
    AuthModel? fetchedUser = await _userService.getUserData(userId);
    if (fetchedUser != null) {
      user.value = fetchedUser;
    }
  }
}
