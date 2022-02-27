import 'package:openwrt_managerx/app/Model/device.dart';
import 'package:openwrt_managerx/OpenWRT/Model/ReplyBase.dart';
import 'CommandReplyBase.dart';

class SystemBoardReply extends CommandReplyBase {
  SystemBoardReply(ReplyStatus status) : super(status);

  @override
  List<String> get commandParameters => ["system", "board"];

  @override
  SystemBoardReply createReply(ReplyStatus status, Map<String, Object> data,
      {Device device}) {
    var i = SystemBoardReply(status);
    i.data = data;
    return i;
  }
}
