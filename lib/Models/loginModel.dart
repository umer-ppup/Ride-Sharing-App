class loginPost {
  final String userId;
  final String email;
  final String password;

  loginPost({this.userId,this.email, this.password});

  factory loginPost.fromJson(Map json) {
    return loginPost(
      userId: json['userId'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "email": email,
    "password": password,
  };

  Map toMap() {
    var map = new Map();
    map["userId"] = userId;
    map["email"] = email;
    map["password"] = password;

    return map;
  }
}