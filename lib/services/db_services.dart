import 'package:firebase_database/firebase_database.dart';
import 'package:meter_app/model/auth/auth_model.dart';
import 'package:meter_app/model/requestServices/request_services_model.dart';
import 'package:meter_app/model/seller/device/device_model.dart';
import 'package:meter_app/utils/backend_util/collection_utils.dart';
import 'package:meter_app/utils/short_message_utils.dart';

class DbServices {
  /////////////////////////Add//////////////////////////////////

  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child(
      'users');

  static Future<void> addDevice(DeviceModel models) async {
    await CollectionUtils.deviceCollection
        .doc(models.id)
        .set(models.toMap())
        .whenComplete(() {});
  }

  static Future<void> addRequestService(RequestServicesModel models) async {
    await CollectionUtils.requestServiceCollection
        .doc(models.id)
        .set(models.toMap())
        .whenComplete(() {});
  }

  //////////////////////////////Delete //////////////////////

  static Future<void> deleteDevice(String deviceId) async {
    await CollectionUtils.deviceCollection
        .doc(deviceId)
        .delete()
        .catchError((error) {
      ShortMessageUtils.showError("Error deleting device: $error");
    });
  }

  static Future<void> updateDevice(String deviceId,
      Map<String, dynamic> data) async {
    await CollectionUtils.deviceCollection
        .doc(deviceId)
        .update(data)
        .catchError((error) {
      ShortMessageUtils.showError("Error updating device: $error");
    });
  }

  Future<AuthModel?> getUserData(String userId) async {
    DatabaseEvent event = await _dbRef.child(userId).once();
    DataSnapshot snapshot = event.snapshot;
    if (snapshot.exists) {
      return AuthModel.fromJson(
          Map<String, dynamic>.from(snapshot.value as Map));
    }
    return null;
  }
}
