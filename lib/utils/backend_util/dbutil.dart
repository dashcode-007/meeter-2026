import 'dart:developer';

import 'package:meter_app/model/auth/auth_model.dart';
import 'package:meter_app/utils/backend_util/collection_utils.dart';
import 'package:meter_app/utils/pref_util.dart';

class DbUtil {
  static String? getCurrentUid() {
    String userId = PrefUtil.getString(PrefUtil.userId);
    log("User  Id is $userId");
    return userId;
  }

  static String? getAutoUid() {
    // log("ID is ${CollectionUtils.userCollection.doc().id}");
    // return CollectionUtils.userCollection.doc().id;
  }

  static saveFaceData(String imageUrl) {
    print("UUID is ${getCurrentUid()}");
    // CollectionUtils.userCollection.doc(getCurrentUid()).set({
    //   "isFaceVerify": true,
    //   "faceImageUrl": imageUrl,
    // },
    //     // SetOptions(merge: true)
    //     );
  }

  static saveFingerData() {
    // CollectionUtils.userCollection.doc(getCurrentUid()).set({
    //   "isFingerVerify": true,
    // }, SetOptions(merge: true));
  }


}
