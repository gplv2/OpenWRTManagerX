import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:openwrt_managerx/common/api_factory/models/base_list.dart';
import 'package:openwrt_managerx/common/api_factory/modules/authentication_module.dart';
import 'package:openwrt_managerx/common/config/config.dart';
import 'package:openwrt_managerx/common/config/prefs/pref_utils.dart';
import 'package:openwrt_managerx/common/widgets/log.dart';

class Utils
{
  static const String NoSpeedCalculationText = "-----";
  static const bool ReleaseMode = bool.fromEnvironment('dart.vm.product', defaultValue: false);

  static String formatDuration(Duration d) {
    var seconds = d.inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];
    if (days != 0) {
      tokens.add('${days}d');
    }
    if (tokens.isNotEmpty || hours != 0) {
      tokens.add('${hours}h');
    }
    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('${minutes}m');
    }
    tokens.add('${seconds}s');

    return tokens.join(' ');
  }

  static String formatBytes(int bytes, {int decimals = 0}) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "Kb", "Mb", "Gb", "Tb", "Pb"];
    var i = (log(bytes) / log(1024)).floor();
    var number = (bytes / pow(1024, i));
    return (number).toStringAsFixed(number.truncateToDouble() == number ? 0 : decimals) +
        ' ' +
        suffixes[i];
  }
}

Future<void> ackAlert(
  BuildContext context,
  String title,
  String content,
  VoidCallback onPressed,
) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        titleTextStyle: TextStyle(
          fontSize: 21,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        content: Text(content),
        contentTextStyle: TextStyle(
          fontSize: 17,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              "Please wait",
              style: TextStyle(
                fontSize: 17,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: onPressed,
          ),
        ],
      );
    },
  );
}

showLoading() {
  Get.dialog(
    Center(
      child: SizedBox(
        child: FittedBox(child: CircularProgressIndicator()),
        height: 50.0,
        width: 50.0,
      ),
    ),
    barrierDismissible: false,
  );
}

hideLoading() {
  Get.back();
}

void showSnackBar(
    {title,
    message,
    SnackPosition? snackPosition,
    Color? backgroundColor,
    Duration? duration}) {
  Get.showSnackbar(
    GetBar(
      title: title,
      message: message,
      duration: duration ?? Duration(seconds: 2),
      snackPosition: snackPosition ?? SnackPosition.BOTTOM,
      backgroundColor: backgroundColor ?? Colors.black87,
    ),
  );
}

handleApiError(errorMessage) {
  showSnackBar(backgroundColor: Colors.redAccent, message: errorMessage);
}

showWarning(message) {
  showSnackBar(backgroundColor: Colors.blueAccent, message: message);
}

bool validatePassword(String password) {
  return RegExp(
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~?]).{8,}$')
      .hasMatch(password);
}

bool validateEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool validURL(String url) {
  return Uri.parse(url).isAbsolute;
}

typedef OnItemsSelected(BaseListModel data);
typedef OnMultiItemSelected(List<BaseListModel> data);
typedef OnFilterSelected(String salary);

//MARK - Open single select bottomsheet -
//-----------------------------------
showCustomBottomSheet({
  @required List<BaseListModel>? list,
  @required String? title,
  @required OnItemsSelected? onItemsSelected,
  bool isMultiSelect = false,
}) {
  Get.bottomSheet(
    BottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          topLeft: Radius.circular(30.0),
        ),
      ),
      onClosing: () {
        Log("on Close bottom sheet");
      },
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0),
              topLeft: Radius.circular(30.0),
            ),
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 4,
                color: Colors.grey,
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    title ?? "",
                  ),
                  isMultiSelect
                      ? Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              height: 41,
                              width: 75,
                              child: MaterialButton(
                                elevation: 0.0,
                                color: Colors.blue,
                                onPressed: () {
                                  var isSelectedItems =
                                      list!.where((e) => e.isSelected).toList();
                                  if (isSelectedItems.length == 0) {
                                    // showWarning(Localize.selectAnyItem.tr);
                                  } else {
                                    Get.back(result: isSelectedItems);
                                  }
                                },
                                child: Text(
                                  "Done",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 17,
                                  ),
                                ),
                                textColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height / 2 - 170,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: list!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 50,
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                list[index].name!,
                              ),
                              list[index].isSelected
                                  ? Icon(Icons.done)
                                  : SizedBox()
                            ],
                          ),
                          onTap: () {
                            if (isMultiSelect) {
                              list[index].isSelected = !list[index].isSelected;
                            } else {
                              list[index].isSelected = !list[index].isSelected;
                              Get.back(result: list[index]);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    ),
  ).then((value) {
    FocusManager.instance.primaryFocus!.unfocus();
    onItemsSelected!(value);
    Log(value);
  });
}

showSessionDialog() {
  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      title: Text(
        "Session Time out",
      ),
      content: Text(
        "Sorry! your session is expired, Please login again",
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            PrefUtils.clearPrefs();
          },
          child: Text(
            "signin",
          ),
        ),
      ],
    ),
  );
}

showLogoutDialog() {
  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      title: Text(
        "Logout",
      ),
      content: Text(
        "Are you sure you want to logout?",
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Get.back();
          },
          child: Text(
            "Cancel",
          ),
        ),
        TextButton(
          onPressed: () async {
            Get.back();
            logoutApi();
          },
          child: Text(
            "Logout",
          ),
        ),
      ],
    ),
  );
}

Future<String> getImageUrl(
    {required String model, required String field, required String id}) async {
  String session = await PrefUtils.getToken();
  return Config.LuciDevURL +
      "/web/image?model=$model&field=$field&$session&id=$id";
}
