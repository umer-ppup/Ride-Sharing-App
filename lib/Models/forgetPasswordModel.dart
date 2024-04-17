class forgetPasswordModel {
  final String userId;
  final String phone;

  forgetPasswordModel({this.userId,this.phone});

  factory forgetPasswordModel.fromJson(Map json) {
    return forgetPasswordModel(
      userId: json['userId'],
      phone: json['phone'],
    );
  }

  Map toMap() {
    var map = new Map();
    map["userId"] = userId;
    map["phone"] = phone;

    return map;
  }
}