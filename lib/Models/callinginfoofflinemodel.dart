class CallingInfoOffline {
  final String? callerId;
  final String? receiverId;
  final int? patietnId;
  final String? receiverFirstName;
  final String? receiverLastName;
  final String? callingTime;
  final int? status;
  const CallingInfoOffline(
      {this.callerId,
      this.receiverId,
      this.patietnId,
      this.receiverFirstName,
      this.receiverLastName,
      this.callingTime,
      this.status});

  factory CallingInfoOffline.fromJson(Map<String, dynamic> json) {
    return CallingInfoOffline(
        callerId: json['callerId'],
        receiverId: json['receiverId'],
        patietnId: json['patietnId'],
        receiverFirstName: json['receiverFirstName'],
        receiverLastName: json['receiverLastName'],
        callingTime: json['callingTime'],
        status: json['status']);
  }

  Map<String, dynamic> toJson() => {
        'callerId': callerId,
        'receiverId': receiverId,
        'patietnId': patietnId,
        'receiverFirstName': receiverFirstName,
        'receiverLastName': receiverLastName,
        'callingTime': callingTime,
        'status': status
      };
}
