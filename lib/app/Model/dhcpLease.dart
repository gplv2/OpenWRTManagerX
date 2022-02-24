import 'package:openwrt_manager/common/utils/Utils.dart';

class DHCPLease
{
  int expires;
  String hostName;
  String ipAddress;
  String macAddress;
  String get expiresText
  {
    if (expires < 0)
      return "Never Expires";
    else
      return Utils.formatDuration(Duration(seconds:  expires));
  }
}