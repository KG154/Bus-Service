import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shuttleservice/module/model/auth/login_model.dart';
import 'package:shuttleservice/module/model/home/users_list_model.dart';
import 'package:shuttleservice/module/model/success_model.dart';
import 'package:shuttleservice/services/internet_service.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/shared_preference.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

class UsersProvider {
  http.Client httpClient = http.Client();

  ///get site list
  Future<UsersListModel?> getUsersList(bodyData) async {
    final hasInternet = await checkInternets();
    if (hasInternet == null || !hasInternet) {
      MyToasts().errorToast(toast: Validate.noInternet);
      return null;
    } else {
      final url = "${Utils.baseUrl}/get_user_list";
      // final url = "$baseUrl/get_user_list";
      try {
        LoginUserData? userModel = await Storage.getUser();
        log("${userModel?.userId} & ${userModel?.token} & ${url}", name: "get_user_list HeaderData");
        log(bodyData.toString(), name: "get_user_list BodyData");

        final response = await http.post(
          Uri.parse(url),
          headers: {"UserId": "${userModel?.userId}", "Token": "${userModel?.token}"},
          body: bodyData,
        );

        //Set data in Model
        final responseBody = returnResponse(response);

        if (response.statusCode == 200) {
          log(response.statusCode.toString(), name: "statusCode");
          log(response.body);
          UsersListModel data = UsersListModel.fromJson(responseBody);
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
          UsersListModel data = UsersListModel.fromJson(responseBody);
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

  ///add site
  Future<SuccessModel?> addUsers(bodyData) async {
    final hasInternet = await checkInternets();
    if (hasInternet == null || !hasInternet) {
      MyToasts().errorToast(toast: Validate.noInternet);
      return null;
    } else {
      final url = "${Utils.baseUrl}/add_user";
      // final url = "$baseUrl/add_user";
      try {
        LoginUserData? userModel = await Storage.getUser();
        log("${userModel?.userId} & ${userModel?.token} & ${url}", name: "add_user HeaderData");
        log(bodyData.toString(), name: "add_user BodyData");

        final response = await http.post(
          Uri.parse(url),
          headers: {"UserId": "${userModel?.userId}", "Token": "${userModel?.token}"},
          body: bodyData,
        );

        //Set data in Model
        final responseBody = returnResponse(response);

        if (response.statusCode == 200) {
          log(response.statusCode.toString(), name: "statusCode");
          log(response.body);
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


  ///edit site & change status
  Future<SuccessModel?> editUser(bodyData) async {
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
          log(response.body);
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
