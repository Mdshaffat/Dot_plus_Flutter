class CallingInfo {
  final int id;
  final String? callerId;
  final String? receiverId;
  final int? patietnId;
  final String? callingTime;
  const CallingInfo(
      {required this.id,
      this.callerId,
      this.receiverId,
      this.patietnId,
      this.callingTime});

  factory CallingInfo.fromJson(Map<String, dynamic> json) {
    return CallingInfo(
        id: json['id'],
        callerId: json['callerId'],
        receiverId: json['receiverId'],
        patietnId: json['patietnId'],
        callingTime: json['callingTime']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'callerId': callerId,
        'receiverId': receiverId,
        'patietnId': patietnId,
        'callingTime': callingTime
      };
}
