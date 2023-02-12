import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shuttleservice/module/model/auth/login_model.dart';
import 'package:shuttleservice/module/model/home/site_manager/end_trip_list_model.dart';
import 'package:shuttleservice/module/model/home/site_manager/start_trip_list_model.dart';
import 'package:shuttleservice/module/model/home/users_list_model.dart';
import 'package:shuttleservice/module/model/success_model.dart';
import 'package:shuttleservice/services/internet_service.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/shared_preference.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

class CreateTripProvider {
  http.Client httpClient = http.Client();

  ///start trip
  Future<EndTripListModel?> startTripList(bodyData) async {
    final hasInternet = await checkInternets();
    if (hasInternet == null || !hasInternet) {
      MyToasts().errorToast(toast: Validate.noInternet);
      return null;
    } else {
      final url = "${Utils.baseUrl}/get_trip_list";
      // final url = "$baseUrl/get_trip_list";
      try {
        LoginUserData? userModel = await Storage.getUser();
        log("${userModel?.userId} & ${userModel?.token} & ${url}", name: "get_trip_list HeaderData");
        log(bodyData.toString(), name: "get_trip_list BodyData");

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
          EndTripListModel data = EndTripListModel.fromJson(responseBody);
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
          EndTripListModel data = EndTripListModel.fromJson(responseBody);
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

  Future<EndTripListModel?> endTripList(bodyData) async {
    final hasInternet = await checkInternets();
    if (hasInternet == null || !hasInternet) {
      MyToasts().errorToast(toast: Validate.noInternet);
      return null;
    } else {
      final url = "${Utils.baseUrl}/end_trip_list";
      // final url = "$baseUrl/end_trip_list";
      try {
        LoginUserData? userModel = await Storage.getUser();
        log("${userModel?.userId} & ${userModel?.token} & ${url}", name: "end_trip_list HeaderData");
        log(bodyData.toString(), name: "end_trip_list BodyData");

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
          EndTripListModel data = EndTripListModel.fromJson(responseBody);
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
          EndTripListModel data = EndTripListModel.fromJson(responseBody);
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
  Future<SuccessModel?> endTrip(bodyData) async {
    final hasInternet = await checkInternets();
    if (hasInternet == null || !hasInternet) {
      MyToasts().errorToast(toast: Validate.noInternet);
      return null;
    } else {
      final url = "${Utils.baseUrl}/end_trip";
      // final url = "$baseUrl/end_trip";
      try {
        LoginUserData? userModel = await Storage.getUser();
        log("${userModel?.userId} & ${userModel?.token} & ${url}", name: "end_trip HeaderData");
        log(bodyData.toString(), name: "add_trip BodyData");

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
        } else if (response.statusCode == 500) {
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

  ///add site
  Future<SuccessModel?> addTrip(bodyData, {String? type}) async {
    final hasInternet = await checkInternets();
    if (hasInternet == null || !hasInternet) {
      MyToasts().errorToast(toast: Validate.noInternet);
      return null;
    } else {
      final url = type == "Edit" ? "${Utils.baseUrl}/update_trip" : "${Utils.baseUrl}/add_trip";
      // final url = type == "Edit" ? "$baseUrl/update_trip" : "$baseUrl/add_trip";
      try {
        LoginUserData? userModel = await Storage.getUser();
        log("${userModel?.userId} & ${userModel?.token} & ${url}", name: "add_trip HeaderData");
        log(bodyData.toString(), name: "add_trip BodyData");

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
        } else if (response.statusCode == 500) {
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

  Future<SuccessModel?> deleteTrip(bodyData) async {
    final hasInternet = await checkInternets();
    if (hasInternet == null || !hasInternet) {
      MyToasts().errorToast(toast: Validate.noInternet);
      return null;
    } else {
      final url = "${Utils.baseUrl}/delete_trip";
      // final url = "$baseUrl/delete_trip";
      try {
        LoginUserData? userModel = await Storage.getUser();
        log("${userModel?.userId} & ${userModel?.token} & ${url}", name: "delete_trip HeaderData");
        log(bodyData.toString(), name: "delete_trip BodyData");

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
        } else if (response.statusCode == 500) {
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
