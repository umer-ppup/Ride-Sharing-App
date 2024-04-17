class startRidePostModel {
  final String request;

  startRidePostModel({this.request});

  factory startRidePostModel.fromJson(Map json) {
    return startRidePostModel(
      request: json['request'],
    );
  }

  Map toMap() {
    var map = new Map();
    map["request"] = request;
    return map;
  }
}