import 'package:get/get.dart';

import '../models/api_response.dart';
import '../models/my_referrals_model.dart';
import '../models/notification_model.dart';
import '../models/user_model.dart';
import '../providers/api_provider.dart';
import 'package:dio/dio.dart' as dio;

class UserRepository {
  late ApiProvider apiProvider;

  UserRepository() {
    apiProvider = Get.find<ApiProvider>();
  }

  Future<ApiResponse> login(creds) async {
    var data = dio.FormData.fromMap(creds);
    return await apiProvider.makeAPICall("POST", "login", data).then((value) {
      if (value.status == Status.COMPLETED) {
        User user = User.fromJson(value.data["user"]);
        user.token = value.data["token"];
        value.data = user;
      }
      return value;
    });
  }

  Future<ApiResponse> forgotPassword(var data) async {
    var body = dio.FormData.fromMap(data);
    return await apiProvider
        .makeAPICall("POST", "forget-password", body)
        .then((value) {
      if (value.status == Status.COMPLETED) {
        // User user = User.fromJson(value.data["user"]);
        // user.token = value.data["token"];
        // value.data = user;
      }
      return value;
    });
  }

  Future<ApiResponse> fetchUserDetails() async {
    return await apiProvider.makeAPICall("GET", "profile", {}).then((value) {
      if (value.status == Status.COMPLETED) {
        User user = User.fromJson(value.data["user"]);
        value.data = user;
      }
      return value;
    });
  }

  Future<ApiResponse> logout() async {
    return await apiProvider.makeAPICall("GET", "logout", {}).then((value) {
      if (value.status == Status.COMPLETED) {
        User user = User.fromJson(value.data);
        value.data = user;
      }
      return value;
    });
  }

  Future<ApiResponse> register(creds) async {
    var data = dio.FormData.fromMap(creds);
    return await apiProvider
        .makeAPICall("POST", "register", data)
        .then((value) {
      if (value.status == Status.COMPLETED) {
        User user = User.fromJson(value.data["user"]);
        user.token = value.data["token"];
        value.data = user;
      }
      return value;
    });
  }

  Future<ApiResponse> fetchNotifications() async {
    return await apiProvider
        .makeAPICall("GET", "notifications", {}).then((value) {
      if (value.status == Status.COMPLETED) {
        value.data = (value.data["notifications"] as List)
            .map((e) => MyNotification.fromJson(e))
            .toList();
      }
      return value;
    });
  }

  Future<ApiResponse> fetchMyReferrals() async {
    return await apiProvider
        .makeAPICall("GET", "my-referrals", {}).then((value) {
      if (value.status == Status.COMPLETED) {
        MyReferral myReferral = MyReferral.fromJson(value.data);
        myReferral.referrals = (value.data["data"] as List)
            .map((e) => Referral.fromJson(e))
            .toList();
        value.data = myReferral;
      }
      return value;
    });
  }

  Future<ApiResponse> withdrawRequest(double amount) async {
    return await apiProvider.makeAPICall(
        "POST", "withdrawal-request", {"amount": amount}).then((value) {
      if (value.status == Status.COMPLETED) {
        // MyReferral myReferral = MyReferral.fromJson(value.data);
        // myReferral.referrals = (value.data["data"] as List)
        //     .map((e) => Referral.fromJson(e))
        //     .toList();
        // value.data = myReferral;
      }
      return value;
    });
  }
}
