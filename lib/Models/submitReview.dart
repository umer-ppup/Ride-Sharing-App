class submitReviewModel {
  final String userId;
  final String rating;
  final String comment;

  submitReviewModel({this.userId,this.rating ,this.comment});
  factory submitReviewModel.fromJson(Map json) {
    return submitReviewModel(
      userId: json['userId'],
      rating: json['rating'],
      comment: json['comment'],
    );
  }
  Map toMap() {
    var map = new Map();
    map["userId"] = userId;
    map["rating"] = rating;
    map["comment"] = comment;
    return map;
  }
}