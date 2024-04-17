class otpPostModel {
  final String userId;
  final String otp;

  otpPostModel({this.userId,this.otp});

  factory otpPostModel.fromJson(Map json) {
    return otpPostModel(
      userId: json['userId'],
      otp: json['otp'],
    );
  }

  Map toMap() {
    var map = new Map();
    map["userId"] = userId;
    map["otp"] = otp;

    return map;
  }
}