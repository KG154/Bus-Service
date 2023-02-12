import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shuttleservice/module/model/auth/login_model.dart';
import 'package:shuttleservice/module/model/home/buses_list_model.dart';
import 'package:shuttleservice/module/model/success_model.dart';
import 'package:shuttleservice/services/internet_service.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/shared_preference.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

class BusesProvider {
  http.Client httpClient = http.Client();

  ///get site list
  Future<BusesListModel?> getBusesList(bodyData) async {
    final hasInternet = await checkInternets();
    if (hasInternet == null || !hasInternet) {
      MyToasts().errorToast(toast: Validate.noInternet);
      return null;
    } else {
      // final url = "$baseUrl/get_bus_list";
      final url = "${Utils.baseUrl}/get_bus_list";
      try {
        LoginUserData? userModel = await Storage.getUser();
        log("${userModel?.userId} & ${userModel?.token} & ${url}", name: "get_bus_list HeaderData");
        log(bodyData.toString(), name: "add_site BodyData");

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
          BusesListModel data = BusesListModel.fromJson(responseBody);
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
          BusesListModel data = BusesListModel.fromJson(responseBody);
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
  Future<SuccessModel?> addBuses(bodyData) async {
    final hasInternet = await checkInternets();
    if (hasInternet == null || !hasInternet) {
      MyToasts().errorToast(toast: Validate.noInternet);
      return null;
    } else {
      final url = "${Utils.baseUrl}/add_bus";
      // final url = "$baseUrl/add_bus";
      try {
        LoginUserData? userModel = await Storage.getUser();
        log("${userModel?.userId} & ${userModel?.token} & ${url}", name: "add_bus HeaderData");
        log(bodyData.toString(), name: "add_bus BodyData");

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
  Future<SuccessModel?> editBuses(bodyData) async {
    final hasInternet = await checkInternets();
    if (hasInternet == null || !hasInternet) {
      MyToasts().errorToast(toast: Validate.noInternet);
      return null;
    } else {
      final url = "${Utils.baseUrl}/edit_bus";
      // final url = "$baseUrl/edit_bus";
      try {
        LoginUserData? userModel = await Storage.getUser();
        log("${userModel?.userId} & ${userModel?.token} & ${url}", name: "edit_bus HeaderData");
        log(bodyData.toString(), name: "edit_bus BodyData");

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

  Future<SuccessModel?> deleteBuses(bodyData) async {
    final hasInternet = await checkInternets();
    if (hasInternet == null || !hasInternet) {
      MyToasts().errorToast(toast: Validate.noInternet);
      return null;
    } else {
      final url = "${Utils.baseUrl}/delete_bus";
      // final url = "$baseUrl/delete_bus";
      try {
        LoginUserData? userModel = await Storage.getUser();
        log("${userModel?.userId} & ${userModel?.token} & ${url}", name: "delete_bus HeaderData");
        log(bodyData.toString(), name: "delete_bus BodyData");

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
