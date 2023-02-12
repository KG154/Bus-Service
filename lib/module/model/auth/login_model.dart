class LogInEditUserModel {
  bool? status;
  int? responsecode;
  String? message;
  LoginUserData? data;

  LogInEditUserModel({this.status, this.responsecode, this.message, this.data});

  LogInEditUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responsecode = json['responsecode'];
    message = json['message'];
    data = json['data'] != null ? new LoginUserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['responsecode'] = this.responsecode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LoginUserData {
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
  String? createdAt;
  bool? isDashboard;
  bool? isUsers;
  bool? isSites;
  bool? isBus;
  bool? isTrip;
  String? endSiteName;
  dynamic endSiteId;
  String? startSiteName;
  dynamic startSiteId;

  LoginUserData({
    this.token,
    this.userId,
    this.userType,
    this.userName,
    this.userPhone,
    this.emailId,
    this.deviceType,
    this.deviceToken,
    this.applicationVersion,
    this.userAccess,
    this.verifyCode,
    this.userPassword,
    this.createdAt,
    this.isDashboard,
    this.isUsers,
    this.isSites,
    this.isBus,
    this.isTrip,
    this.endSiteName,
    this.endSiteId,
    this.startSiteName,
    this.startSiteId,
  });

  LoginUserData.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['created_at'];
    isDashboard = json['is_dashboard'];
    isUsers = json['is_users'];
    isSites = json['is_sites'];
    isBus = json['is_bus'];
    isTrip = json['is_trip'];
    endSiteName = json['end_site_name'];
    endSiteId = json['end_site_id'];
    startSiteName = json['start_site_name'];
    startSiteId = json['start_site_id'];
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
    data['created_at'] = this.createdAt;
    data['is_dashboard'] = this.isDashboard;
    data['is_users'] = this.isUsers;
    data['is_sites'] = this.isSites;
    data['is_bus'] = this.isBus;
    data['is_trip'] = this.isTrip;
    data['end_site_name'] = this.endSiteName;
    data['end_site_id'] = this.endSiteId;
    data['start_site_name'] = this.startSiteName;
    data['start_site_id'] = this.startSiteId;
    return data;
  }
}
