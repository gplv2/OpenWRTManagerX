import 'dart:convert';
import 'package:get/get.dart';
import 'package:openwrt_managerx/common/api_factory/api.dart';
import 'package:openwrt_managerx/common/config/config.dart';
import 'package:openwrt_managerx/common/config/prefs/pref_utils.dart';
import 'package:openwrt_managerx/common/utils/utils.dart';
import 'package:openwrt_managerx/common/widgets/log.dart';
import 'package:openwrt_managerx/app/Model/Identity.dart';

import 'package:openwrt_managerx/src/authentication/controllers/signin_controller.dart';
import 'package:openwrt_managerx/src/authentication/models/user_model.dart';
//import 'package:openwrt_managerx/src/authentication/views/signin.dart';
//import 'package:openwrt_managerx/src/home/view/home.dart';

getVersionInfoAPI() {
  Api.getVersionInfo(
    onResponse: (response) {
      Api.getDatabases(
        serverVersionNumber: response.serverVersionInfo![0],
        onResponse: (response) {
          Log(response);
          Config.DB = response[0];
        },
        onError: (error, data) {
          handleApiError(error);
        },
      );
    },
    onError: (error, data) {
      handleApiError(error);
    },
  );
}

authenticationAPI(String name, String pass) {
  Api.authenticate(
    luci_username: name,
    luci_password: pass,
    onResponse: (UserModel response) {
      currentUser.value = response;
      PrefUtils.setIsLoggedIn(true);
      PrefUtils.setUser(jsonEncode(response));
      //Get.offAll(() => Home());
    },
    onError: (error, data) {
      handleApiError(error);
    },
  );
}

logoutApi() {
  Api.destroy(
    onResponse: (response) {
      PrefUtils.clearPrefs();
      //Get.offAll(() => SignIn());
    },
    onError: (error, data) {
      handleApiError(error);
    },
  );
}
