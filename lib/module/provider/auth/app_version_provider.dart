import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shuttleservice/module/model/auth/check_app_version_model.dart';
import 'package:shuttleservice/services/internet_service.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

class CheckAppVersionProvider {
  http.Client httpClient = http.Client();

  Future<CheckAppVersionModel?> checkAppVersion(bodyData) async {
    final hasInternet = await checkInternets();
    if (hasInternet == null || !hasInternet) {
      MyToasts().errorToast(toast: Validate.noInternet);
      return null;
    } else {
      final url = "$baseUrl/check_version";
      try {
        log(bodyData.toString(), name: "check_version BodyData");
        log(url, name: "check_version BodyData");

        final response = await http.post(Uri.parse(url), body: bodyData);
        //Set data in Model
        final responseBody = returnResponse(response);
        if (response.statusCode == 200) {
          log(response.statusCode.toString(), name: "statusCode");
          log(response.body);
          CheckAppVersionModel data = CheckAppVersionModel.fromJson(responseBody);
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
          CheckAppVersionModel data = CheckAppVersionModel.fromJson(responseBody);
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
