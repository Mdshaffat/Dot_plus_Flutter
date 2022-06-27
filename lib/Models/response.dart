import 'dart:io';

import '../API/api.dart';

class ResponseData {
  final String? message;
  final bool? isValid;
  final String? data;
  const ResponseData({this.message, this.isValid, this.data});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
        message: json['message'], isValid: json['isValid'], data: json['data']);
  }
  Map<String, dynamic> toJson() =>
      {"message": message, "isValid": isValid, 'data': data};
}

class HasNetWork {
  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup(ROOTURI);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    } catch (e) {
      return false;
    }
  }

  isActive() async {
    bool isOnline = await hasNetwork();
    return isOnline;
  }
}
