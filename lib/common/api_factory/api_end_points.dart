class ApiEndPoints {
  ApiEndPoints._();

  static const String getSessionInfo = "/cgi-bin/luci";
  static const String authenticate = "/cgi-bin/luci/admin/ubus";
  static const String luci = "/cgi-bin/luci/admin/ubus";
  static const String searchRead = "/cgi-bin/luci/admin/ubus";
  static const String cgi = "/cgi-bin/luci/";

  static String getCallKWEndPoint(String model, String method) {
    return '$callKw/$model/$method';
  }
}
