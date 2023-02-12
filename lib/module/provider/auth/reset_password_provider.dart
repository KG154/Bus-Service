import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shuttleservice/module/model/auth/reset_password_model.dart';
import 'package:shuttleservice/services/internet_service.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

class ResetPasswordProvider {
  http.Client httpClient = http.Client();

  Future<ResetPasswordModel?> resetPassword(bodyData) async {
    final hasInternet = await checkInternets();
    if (hasInternet == null || !hasInternet) {
      MyToasts().errorToast(toast: Validate.noInternet);
      return null;
    } else {
      final url = "${Utils.baseUrl}/reset_password";
      // final url = "$baseUrl/reset_password";
      try {
        log(bodyData.toString(), name: "ResetPassword BodyData");
        log(url, name: "ResetPassword BodyData");

        final response = await http.post(Uri.parse(url), body: bodyData);
        //Set data in Model
        final responseBody = returnResponse(response);
        if (response.statusCode == 200) {
          log(response.statusCode.toString(), name: "statusCode");
          log(response.body,name: "Reset Password");
          ResetPasswordModel data = ResetPasswordModel.fromJson(responseBody);
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
          ResetPasswordModel data = ResetPasswordModel.fromJson(responseBody);
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
