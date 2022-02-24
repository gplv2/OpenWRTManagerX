import 'package:openwrt_manager/app/Model/device.dart';
import 'package:openwrt_manager/OpenWRT/Model/ReplyBase.dart';
import 'CommandReplyBase.dart';

class KernelLogReply extends CommandReplyBase {
  KernelLogReply(ReplyStatus status) : super(status);

  @override
  List<dynamic> get commandParameters {
    List<dynamic> lst = [];
    lst.addAll(["file", "exec"]);
    lst.add({
      'command': '/sbin/logread',
      'params': ['-e']
    });
    return lst;
  }

  @override
  KernelLogReply createReply(ReplyStatus status, Map<String, Object> data,
      {Device device}) {
    var i = KernelLogReply(status);
    i.data = data;
    return i;
  }
}
