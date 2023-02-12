class UsersListModel {
  bool? status;
  int? responsecode;
  String? message;
  List<UsersListData>? data;

  UsersListModel({this.status, this.responsecode, this.message, this.data});

  UsersListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responsecode = json['responsecode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UsersListData>[];
      json['data'].forEach((v) {
        data!.add(new UsersListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['responsecode'] = this.responsecode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UsersListData {
  String? token;
  int? userId;
  String? userType;
  String? userName;
  String? userPhone;
  String? emailId;
  String? deviceType;
  String? deviceToken;
  String? applicationVersion;
  String? userAccess;
  dynamic verifyCode;
  String? userPassword;
  String? endSiteName;
  dynamic endSiteId;
  String? startSiteName;
  dynamic startSiteId;
  bool? password = false;

  UsersListData({this.token, this.userId, this.userType, this.userName, this.userPhone, this.emailId, this.deviceType, this.deviceToken, this.applicationVersion, this.userAccess, this.verifyCode, this.userPassword, this.endSiteName, this.endSiteId, this.startSiteName, this.startSiteId, this.password});

  UsersListData.fromJson(Map<String, dynamic> json) {
    token = json['Token'];
    userId = json['user_id'];
    userType = json['user_type'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
    emailId = json['email_id'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    applicationVersion = json['application_version'];
    userAccess = json['user_access'];
    verifyCode = json['verify_code'];
    userPassword = json['user_password'];
    endSiteName = json['end_site_name'];
    endSiteId = json['end_site_id'];
    startSiteName = json['start_site_name'];
    startSiteId = json['start_site_id'];
    password = json['password'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Token'] = this.token;
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['user_name'] = this.userName;
    data['user_phone'] = this.userPhone;
    data['email_id'] = this.emailId;
    data['device_type'] = this.deviceType;
    data['device_token'] = this.deviceToken;
    data['application_version'] = this.applicationVersion;
    data['user_access'] = this.userAccess;
    data['verify_code'] = this.verifyCode;
    data['user_password'] = this.userPassword;
    data['end_site_name'] = this.endSiteName;
    data['end_site_id'] = this.endSiteId;
    data['start_site_name'] = this.startSiteName;
    data['start_site_id'] = this.startSiteId;
    data['password'] = this.password;
    return data;
  }
}
