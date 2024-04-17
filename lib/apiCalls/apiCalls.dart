import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as https;
import 'package:ride/Constants/appcolor.dart';
import 'package:ride/Constants/varaibleAssets.dart';
import 'package:ride/Models/completeRideModel.dart';
import 'package:ride/Models/signUpRequestModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ride/Models/vechileTypeModel.dart';
import 'package:ride/localjson/localjson.dart';

Future loginpostRequest(String url, {Map body}) async {
  if(Secrets.conditionCheak){
  return https.post(url, body: body).then((https.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return response.body;
  });
  }else{
     Secrets.prefs = await SharedPreferences.getInstance();
     Secrets.prefs.setString('userInfo',body.toString());
  }
}


Future signUpPostRequest(String url, {Map body}) async {
  if(Secrets.conditionCheak){
    return https.post(url, body: body).then((https.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return response.body;
    });
  }else{
    Storage.readData().then((value) async {
      if(value != ""){
        print('Hamza');
        signUpPostModel user = signUpPostModel.fromJson(json.decode(value));
        if(user.email != body['email']){
          signUpPostModel user = new signUpPostModel(
              name: body['name'],
              email: body['email'],
              password: body['password'],
              phone: body['phone']
          );
          await Storage.writeData(json.encode(user));
          return 'success';
        }
        else{
          Fluttertoast.showToast(
              msg: "Already Mail Register",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: AppColors.white[100],
              textColor: AppColors.black[100],
              fontSize: 16.0);
          return '100';
        }
      }
      else{
        print('hhhh');
        signUpPostModel user = new signUpPostModel(
            name: body['name'],
            email: body['email'],
            password: body['password'],
            phone: body['phone']
        );
        await Storage.writeData(json.encode(user));
        return 'success';
      }
    });
  }
}

Future otpPostRequest(String url, {Map body}) async {
  if(Secrets.conditionCheak){
    return https.post(url, body: body).then((https.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return response.body;
    });
  }else{
    Secrets.prefs = await SharedPreferences.getInstance();
    Secrets.prefs.setString('otp',body.toString());
  }
}

Future forgetPasswordPostRequest(String url, {Map body}) async {
  if(Secrets.conditionCheak){
    return https.post(url, body: body).then((https.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return response.body;
    });
  }else{
    Secrets.prefs = await SharedPreferences.getInstance();
    Secrets.prefs.setString('forgetpassword',body.toString());
  }
}

Future getVechileTypeRequest(String url) async {
  if (Secrets.conditionCheak) {
    return https.get(url).then((https.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return vechileTypeModelFromJson(response.body);
    });
  } else {
    final String response = await rootBundle.loadString('assets/data.json');
    var data = await json.decode(response);
    var result = data["vechileType"] as List;
    var dataList = result.map<VechileTypeModel>((json) => VechileTypeModel.fromJson(json)).toList();
    return dataList;
  }
}

Future getRiderLatLng(String url) async {
  if (Secrets.conditionCheak) {
    return https.get(url).then((https.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return vechileTypeModelFromJson(response.body);
    });
  } else {
    final String response = await rootBundle.loadString('assets/data.json');
    var data = await json.decode(response);
    var result = data["vechileType"] as List;
    var dataList = result.map<VechileTypeModel>((json) => VechileTypeModel.fromJson(json)).toList();
    return dataList;
  }
}

Future previousRideGetRequest(String url) async {
  if(Secrets.conditionCheak){
    return https.get(url).then((https.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return completeRideModel.fromJson(json.decode(response.body));
    });
  }else{
    final String response = await rootBundle.loadString('assets/data.json');
    var data = await json.decode(response);
    var result = data["PreviousRide"] as List;
    var dataList = result.map<completeRideModel>((json) => completeRideModel.fromJson(json)).toList();
    return dataList;
  }
}

Future startRidePostRequest(String url, {Map body}) async {
  if(Secrets.conditionCheak){
    return https.post(url, body: body).then((https.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return response.body;
    });
  }else{
  }
}

Future endRidePostRequest(String url, {Map body}) async {
  if(Secrets.conditionCheak){
    return https.post(url, body: body).then((https.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return response.body;
    });
  }else{
  }
}



Future submitRieviewPostRequest(String url, {Map body}) async {
  if(Secrets.conditionCheak){
    return https.post(url, body: body).then((https.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return response.body;
    });
  }else{

  }
}

void getIdByPrefrence(){

}