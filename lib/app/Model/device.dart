class Device {
  //Device({this.guid, this.displayName this.address this.port this.identityGuid this.useSecureConnection this.ignoreBadCertificate this.wifiDevices});
  late String guid;
  late String displayName;
  late String address;
  late String port;
  late String identityGuid;
  late bool useSecureConnection;
  late bool ignoreBadCertificate;
  late List<String> wifiDevices = [];

  static const String defaultPort = "80/443";

  Map toJson() => {
        'displayName': displayName,
        'guid': guid,
        'address': address,
        'identityGuid': identityGuid,
        'port': port,
        'wifiDevices': wifiDevices,
        'useSecureConnection': useSecureConnection,
        'ignoreBadCertificate': ignoreBadCertificate,
      };

  static Device fromJson(Map<String, dynamic> json) {
    var i = Device();
    i.guid = json['guid'].toString();
    i.address = json['address'].toString();
    i.displayName = json['displayName'].toString();
    i.identityGuid = json['identityGuid'].toString();
    i.port = json['port'].toString();
    i.useSecureConnection = json['useSecureConnection'] ?? false;
    i.ignoreBadCertificate = json['ignoreBadCertificate'] ?? false;
    if (json['wifiDevices'] != null && (json['wifiDevices'] as List).length > 0)
      i.wifiDevices.addAll(
          (json['wifiDevices'] as List<dynamic>).map((x) => x.toString()));
    return i;
  }
}
