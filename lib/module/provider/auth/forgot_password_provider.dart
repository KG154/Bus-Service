import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shuttleservice/module/model/auth/forgot_password_model.dart';
import 'package:shuttleservice/module/model/success_model.dart';
import 'package:shuttleservice/services/internet_service.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

class ForGotPasswordProvider {
  http.Client httpClient = http.Client();

  Future<ForgotPasswordModel?> forgotPassword(bodyData) async {
    final hasInternet = await checkInternets();
    if (hasInternet == null || !hasInternet) {
      MyToasts().errorToast(toast: Validate.noInternet);
      return null;
    } else {
      // final url = "$baseUrl/forgot_password";
      final url = "${Utils.baseUrl}/forgot_password";
      try {
        log(bodyData.toString(), name: "Forgot HeaderData");
        log(url, name: "Forgot BodyData");

        final response = await http.post(Uri.parse(url), body: bodyData);
        //Set data in Model
        final responseBody = returnResponse(response);
        if (response.statusCode == 200) {
          log(response.statusCode.toString(), name: "statusCode");
          log(response.body, name: "Forgot");
          ForgotPasswordModel data = ForgotPasswordModel.fromJson(responseBody);
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
          ForgotPasswordModel data = ForgotPasswordModel.fromJson(responseBody);
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

  Future<SuccessModel?> verification(bodyData) async {
    final hasInternet = await checkInternets();
    if (hasInternet == null || !hasInternet) {
      MyToasts().errorToast(toast: Validate.noInternet);
      return null;
    } else {
      // final url = "$baseUrl/verify_code";
      final url = "${Utils.baseUrl}/verify_code";
      try {
        log(bodyData.toString(), name: "verify HeaderData");
        log(url, name: "verify BodyData");

        final response = await http.post(Uri.parse(url), body: bodyData);
        //Set data in Model
        final responseBody = returnResponse(response);
        if (response.statusCode == 200) {
          log(response.statusCode.toString(), name: "statusCode");
          log(response.body, name: "verify");
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
