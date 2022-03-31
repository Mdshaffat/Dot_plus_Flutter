import 'dart:io';

import '../API/api.dart';

class ResponseData {
  final String? Message;
  final bool? IsValid;
  const ResponseData({this.Message, this.IsValid});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(Message: json['message'], IsValid: json['isValid']);
  }
  Map<String, dynamic> toJson() => {"message": Message, "isValid": IsValid};
}

class HasNetWork {
  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup(ROOTURI);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  isActive() async {
    bool isOnline = await hasNetwork();
    return isOnline;
  }
}
