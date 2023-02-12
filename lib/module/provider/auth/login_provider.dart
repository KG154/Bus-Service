import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shuttleservice/module/model/auth/login_model.dart';
import 'package:shuttleservice/services/internet_service.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/shared_preference.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

class LoginProvider {
  // http.Client httpClient = http.Client();

  Future<LogInEditUserModel?> loginUser(bodyData) async {
    final hasInternet = await checkInternets();
    if (hasInternet == null || !hasInternet) {
      MyToasts().errorToast(toast: Validate.noInternet);
      return null;
    } else {
      // final url = "$baseUrl/user_login";
      final url = "${Utils.baseUrl}/user_login";
      try {
        log(bodyData.toString(), name: "Login BodyData");
        log(url, name: "Login BodyData");

        final response = await http.post(Uri.parse(url), body: bodyData);
        //Set data in Model
        final responseBody = returnResponse(response);
        if (response.statusCode == 200) {
          log(response.statusCode.toString(), name: "statusCode");
          log(response.body);
          LogInEditUserModel data = LogInEditUserModel.fromJson(responseBody);
          return data;
        } else if (response.statusCode == 101 || response.statusCode == 102) {
          log(response.statusCode.toString(), name: "statusCode");
          MyToasts().errorToast(toast: Validate.somethingWentWrong);
          return null;
        } else if (response.statusCode == 404) {
          log(response.statusCode.toString(), name: "statusCode");
          MyToasts().errorToast(toast: Validate.somethingWentWrong);
          return null;
        } else {
          LogInEditUserModel data = LogInEditUserModel.fromJson(responseBody);
          return data;
        }
      } on SocketException catch (e) {
        throw Exception(e);
      } on FormatException catch (e) {
        throw Exception(Validate.badReq);
      } catch (exception) {
        return null;
      }
    }
  }

  Future<LogInEditUserModel?> loginUserDetails(String? token, int? userId) async {
    final hasInternet = await checkInternets();
    if (hasInternet == null || !hasInternet) {
      MyToasts().errorToast(toast: Validate.noInternet);
      return null;
    } else {
      final url = "${Utils.baseUrl}/get_user_details";
      // final url = "$baseUrl/get_user_details";
      log("${userId} & ${token} & ${url}", name: "get_user_details HeaderData");
      try {
        log(url, name: "get_user_details BodyData");

        final response = await http.post(
          Uri.parse(url),
          headers: {"UserId": "${userId}", "Token": "${token}"},
        );
        //Set data in Model
        final responseBody = returnResponse(response);
        if (response.statusCode == 200) {
          log(response.statusCode.toString(), name: "statusCode");
          log(response.body);
          LogInEditUserModel data = LogInEditUserModel.fromJson(responseBody);
          return data;
        } else if (response.statusCode == 101 || response.statusCode == 102) {
          log(response.statusCode.toString(), name: "statusCode");
          MyToasts().errorToast(toast: Validate.somethingWentWrong);
          return null;
        } else if (response.statusCode == 404) {
          log(response.statusCode.toString(), name: "statusCode");
          MyToasts().errorToast(toast: Validate.somethingWentWrong);
          return null;
        } else if (response.statusCode == 500) {
          log(response.statusCode.toString(), name: "statusCode");
          MyToasts().errorToast(toast: Validate.somethingWentWrong);
          return null;
        } else {
          LogInEditUserModel data = LogInEditUserModel.fromJson(responseBody);
          return data;
        }
      } on SocketException catch (e) {
        throw Exception(e);
      } on FormatException catch (e) {
        throw Exception(Validate.badReq);
      } catch (exception) {
        return null;
      }
    }
  }
}
