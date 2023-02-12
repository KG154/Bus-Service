class StartTripListModel {
  bool? status;
  int? responsecode;
  String? message;
  List<StartTripData>? data;

  StartTripListModel({this.status, this.responsecode, this.message, this.data});

  StartTripListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responsecode = json['responsecode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StartTripData>[];
      json['data'].forEach((v) {
        data!.add(new StartTripData.fromJson(v));
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

class StartTripData {
  dynamic busid;
  String? busNumber;
  String? fromDate;
  String? driveMoble;
  String? driveName;
  List<BusStatusData>? busStatusData;

  StartTripData({
    this.busid,
    this.busNumber,
    this.fromDate,
    this.driveMoble,
    this.driveName,
    this.busStatusData,
  });

  StartTripData.fromJson(Map<String, dynamic> json) {
    busid = json['busid'];
    busNumber = json['bus_number'];
    fromDate = json['from_date'];
    driveMoble = json['drive_moble'];
    driveName = json['drive_name'];
    if (json['bus_status_data'] != null) {
      busStatusData = <BusStatusData>[];
      json['bus_status_data'].forEach((v) {
        busStatusData!.add(new BusStatusData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['busid'] = this.busid;
    data['bus_number'] = this.busNumber;
    data['from_date'] = this.fromDate;
    data['drive_moble'] = this.driveMoble;
    data['drive_name'] = this.driveName;
    if (this.busStatusData != null) {
      data['bus_status_data'] = this.busStatusData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BusStatusData {
  int? tripId;
  String? fromTime;
  String? toTime;
  dynamic fromCount;
  dynamic toCount;
  dynamic fromUserId;
  String? fromUserName;
  String? fromEmailId;
  String? fromUserPhone;
  String? toEmailId;
  String? toUserPhone;
  dynamic toUserid;
  String? toUserName;
  int? fromSideid;
  String? fromSiteName;
  int? toSideid;
  String? toSiteName;

  BusStatusData({
    this.tripId,
    this.fromTime,
    this.toTime,
    this.fromCount,
    this.toCount,
    this.fromUserId,
    this.fromUserName,
    this.fromEmailId,
    this.fromUserPhone,
    this.toEmailId,
    this.toUserPhone,
    this.toUserid,
    this.toUserName,
    this.fromSideid,
    this.fromSiteName,
    this.toSideid,
    this.toSiteName,
  });

  BusStatusData.fromJson(Map<String, dynamic> json) {
    tripId = json['trip_id'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
    fromCount = json['from_count'];
    toCount = json['to_count'];
    fromUserId = json['from_user_id'];
    fromUserName = json['from_user_name'];
    fromEmailId = json['from_email_id'];
    fromUserPhone = json['from_user_phone'];
    toEmailId = json['to_email_id'];
    toUserPhone = json['to_user_phone'];
    toUserid = json['to_userid'];
    toUserName = json['to_user_name'];
    fromSideid = json['from_sideid'];
    fromSiteName = json['from_site_name'];
    toSideid = json['to_sideid'];
    toSiteName = json['to_site_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trip_id'] = this.tripId;
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    data['from_count'] = this.fromCount;
    data['to_count'] = this.toCount;
    data['from_user_id'] = this.fromUserId;
    data['from_user_name'] = this.fromUserName;
    data['from_email_id'] = this.fromEmailId;
    data['from_user_phone'] = this.fromUserPhone;
    data['to_email_id'] = this.toEmailId;
    data['to_user_phone'] = this.toUserPhone;
    data['to_userid'] = this.toUserid;
    data['to_user_name'] = this.toUserName;
    data['from_sideid'] = this.fromSideid;
    data['from_site_name'] = this.fromSiteName;
    data['to_sideid'] = this.toSideid;
    data['to_site_name'] = this.toSiteName;
    return data;
  }
}
