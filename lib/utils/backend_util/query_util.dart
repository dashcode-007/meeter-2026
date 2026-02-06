import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meter_app/model/seller/device/device_model.dart';
import 'package:meter_app/utils/backend_util/collection_utils.dart';
import 'package:meter_app/utils/backend_util/dbutil.dart';

///This Class Will Contain [Queries] of [Firestore] for Fetching [Data]

class QueryUtil {
  /////////////////        Streams    ///////////////////////////

  static Stream<List<DeviceModel>> fetchDevices() {
    return CollectionUtils.deviceCollection
        .where("userUID", isEqualTo: DbUtil.getCurrentUid())
        .where("deviceApprove", isEqualTo: "false")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                DeviceModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  static Stream<List<DeviceModel>> fetchDevicesForStore() {
    return CollectionUtils.deviceCollection
        .where("deviceApprove", isEqualTo: "false")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                DeviceModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }
}
