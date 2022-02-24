class LuciResponse {
  var _result, _statusCode;

  LuciResponse(Map result, int statusCode) {
    _result = result;
    _statusCode = statusCode;
  }

  bool hasError() {
    return _result['error'] != null;
  }

  Map getError() {
    return _result['error'];
  }

  String getErrorMessage() {
    if (hasError()) {
      return _result['error']['data']['message'];
    }
    return "";
  }

  int getStatusCode() {
    return _statusCode;
  }

  dynamic getResult() {
    return _result['result'];
  }

  dynamic getRecords() {
    return getResult()['records'];
  }
}
