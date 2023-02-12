import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shuttleservice/module/model/auth/login_model.dart';
import 'package:shuttleservice/module/model/success_model.dart';
import 'package:shuttleservice/services/internet_service.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/shared_preference.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

class EditProfileProvider {
  http.Client httpClient = http.Client();

  Future<LogInEditUserModel?> editUserProfile(bodyData) async {
    final hasInternet = await checkInternets();
    if (hasInternet == null || !hasInternet) {
      MyToasts().errorToast(toast: Validate.noInternet);
      return null;
    } else {
      final url = "${Utils.baseUrl}/edit_user";
      // final url = "$baseUrl/edit_user";
      try {
        LoginUserData? userModel = await Storage.getUser();
        log("${userModel?.userId} & ${userModel?.token} & ${url}", name: "edit_user HeaderData");
        log(bodyData.toString(), name: "edit_user BodyData");

        final response = await http.post(
          Uri.parse(url),
          headers: {"UserId": "${userModel?.userId}", "Token": "${userModel?.token}"},
          body: bodyData,
        );
        //Set data in Model
        final responseBody = returnResponse(response);
        if (response.statusCode == 200) {
          log(response.statusCode.toString(), name: "statusCode");
          log(response.body, name: "edit_user");
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

  Future<SuccessModel?> changePassword(bodyData) async {
    final hasInternet = await checkInternets();
    if (hasInternet == null || !hasInternet) {
      MyToasts().errorToast(toast: Validate.noInternet);
      return null;
    } else {
      final url = "${Utils.baseUrl}/change_password";
      // final url = "$baseUrl/change_password";
      try {
        LoginUserData? userModel = await Storage.getUser();
        log("${userModel?.userId} & ${userModel?.token} & ${url}", name: "change_password HeaderData");
        log(bodyData.toString(), name: "change_password BodyData");

        final response = await http.post(
          Uri.parse(url),
          headers: {"UserId": "${userModel?.userId}", "Token": "${userModel?.token}"},
          body: bodyData,
        );
        //Set data in Model
        final responseBody = returnResponse(response);
        if (response.statusCode == 200) {
          log(response.statusCode.toString(), name: "statusCode");
          log(response.body, name: "edit_user");
          SuccessModel data = SuccessModel.fromJson(responseBody);
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
          SuccessModel data = SuccessModel.fromJson(responseBody);
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
