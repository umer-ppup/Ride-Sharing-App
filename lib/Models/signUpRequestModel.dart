class signUpPostModel {
   String name;
   String email;
   String password;
   String phone;

  signUpPostModel({this.name,this.email, this.password,this.phone});

  factory signUpPostModel.fromJson(Map json) {
    return signUpPostModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
    );
  }

   Map<String, dynamic> toJson() => {
     "name": name,
     "email": email,
     "password": password,
     "phone": phone,
   };

  Map toMap() {
    var map = new Map();
    map["userId"] = name;
    map["email"] = email;
    map["password"] = password;
    map["phone"] = phone;

    return map;
  }
}