import 'package:openwrt_manager/Model/device.dart';
import 'package:openwrt_manager/OpenWRT/Model/CommandReplyBase.dart';
import 'package:openwrt_manager/OpenWRT/Model/ReplyBase.dart';

class WifiAssociatedClientReply extends CommandReplyBase {
  WifiAssociatedClientReply(ReplyStatus status) : super(status);

  Device device;

  int interfaceIndex;

  @override
  List<dynamic> get commandParameters {
    var lst = List<dynamic>();
    lst.addAll(["iwinfo", "assoclist"]);
    if (device != null && device.wifiDevices.length > 0 && interfaceIndex != null)
      lst.add({"device": device.wifiDevices[interfaceIndex]});
    return lst;
  }

  @override
  Object createReply(ReplyStatus status, Map<String, Object> data,
      {Device device}) {
    if (device == null || device.wifiDevices.length == 1) {
      var i = WifiAssociatedClientReply(status);
      i.device = device;
      i.data = data;
      return i;
    }
    var lst = List<WifiAssociatedClientReply>();
    if (device.wifiDevices.length >= 2) {
      for (int idx = 0; idx < device.wifiDevices.length;) {
        var i = WifiAssociatedClientReply(status);
        i.interfaceIndex = idx;
        i.device = device;
        i.data = data;
        idx++;
        lst.add(i);
      }
    }
    return lst;
  }
}
