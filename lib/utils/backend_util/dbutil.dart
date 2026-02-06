import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    log("ID is ${CollectionUtils.userCollection.doc().id}");
    return CollectionUtils.userCollection.doc().id;
  }

  static saveFaceData(String imageUrl) {
    print("UUID is ${getCurrentUid()}");
    CollectionUtils.userCollection.doc(getCurrentUid()).set({
      "isFaceVerify": true,
      "faceImageUrl": imageUrl,
    }, SetOptions(merge: true));
  }

  static saveFingerData() {
    CollectionUtils.userCollection.doc(getCurrentUid()).set({
      "isFingerVerify": true,
    }, SetOptions(merge: true));
  }

  static Future<String> getRoleByUid() async {
    try {
      DocumentSnapshot userDoc =
          await CollectionUtils.userCollection.doc(getCurrentUid()).get();
      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>?;
        log("Role is ${data?["role"]}");
        return data?['role'] as String;
      } else {
        return "Customer";
      }
    } catch (e) {
      return "Customer";
    }
  }

  static Future<List<AuthModel>> fetchAuthData() async {
    try {
      QuerySnapshot querySnapshot = await CollectionUtils.userCollection
          .where("userId", isEqualTo: getCurrentUid())
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs
            .map(
                (doc) => AuthModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception("No documents found matching the query");
      }
    } catch (e) {
      throw Exception("Error fetching documents: $e");
    }
  }
}
