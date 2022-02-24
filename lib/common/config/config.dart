class Config {
  Config._();

  /// Luci URLs
  static const String LuciDevURL = "https://devurl.luci.internal/";
  static const String LuciProdURL = "https://produrl.luci.internal/";
  static const String LuciUATURL = "https://uaturl.luci.internal/";

  /// SelfSignedCert:
  static const selfSignedCert = false;

  /// API Config
  static const timeout = 60000;
  static const logNetworkRequest = true;
  static const logNetworkRequestHeader = true;
  static const logNetworkRequestBody = true;
  static const logNetworkResponseHeader = false;
  static const logNetworkResponseBody = true;
  static const logNetworkError = true;
}
