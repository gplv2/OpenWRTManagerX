import 'package:openwrt_managerx/common/utils/utils.dart';

class DHCPLease
{
  late int expires;
  late String hostName;
  late String ipAddress;
  late String macAddress;
  String get expiresText
  {
    if (expires < 0)
      return "Never Expires";
    else
      return Utils.formatDuration(Duration(seconds:  expires));
  }
}
