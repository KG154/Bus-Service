class EndTripListModel {
  bool? status;
  int? responsecode;
  String? message;
  List<EndTripData>? data;

  EndTripListModel({this.status, this.responsecode, this.message, this.data});

  EndTripListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responsecode = json['responsecode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <EndTripData>[];
      json['data'].forEach((v) {
        data!.add(new EndTripData.fromJson(v));
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

class EndTripData {
  int? id;
  String? driveName;
  String? driveMoble;
  dynamic fromCount;
  dynamic toCount;
  String? fromDate;
  String? toDate;
  String? fromTime;
  String? toTime;
  dynamic fromSideid;
  String? fromSiteName;
  dynamic toSideid;
  String? toSiteName;
  dynamic busid;
  String? busNumber;
  dynamic fromUserid;
  String? fromUserName;
  String? fromEmailId;
  String? fromUserPhone;
  dynamic toUserid;
  String? toUserName;
  String? toEmailId;
  String? toUserPhone;

  EndTripData({this.id,
    this.driveName,
    this.driveMoble,
    this.fromCount,
    this.toCount,
    this.fromDate,
    this.toDate,
    this.fromTime,
    this.toTime,
    this.fromSideid,
    this.fromSiteName,
    this.toSideid,
    this.toSiteName,
    this.busid,
    this.busNumber,
    this.fromUserid,
    this.fromUserName,
    this.fromEmailId,
    this.fromUserPhone,
    this.toUserid,
    this.toUserName,
    this.toEmailId,
    this.toUserPhone,});

  EndTripData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driveName = json['drive_name'];
    driveMoble = json['drive_moble'];
    fromCount = json['from_count'];
    toCount = json['to_count'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
    fromSideid = json['from_sideid'];
    fromSiteName = json['from_site_name'];
    toSideid = json['to_sideid'];
    toSiteName = json['to_site_name'];
    busid = json['busid'];
    busNumber = json['bus_number'];
    fromUserid = json['from_userid'];
    fromUserName = json['from_user_name'];
    fromEmailId = json['from_email_id'];
    fromUserPhone = json['from_user_phone'];
    toUserid = json['to_userid'];
    toUserName = json['to_user_name'];
    toEmailId = json['to_email_id'];
    toUserPhone = json['to_user_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['drive_name'] = this.driveName;
    data['drive_moble'] = this.driveMoble;
    data['from_count'] = this.fromCount;
    data['to_count'] = this.toCount;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    data['from_sideid'] = this.fromSideid;
    data['from_site_name'] = this.fromSiteName;
    data['to_sideid'] = this.toSideid;
    data['to_site_name'] = this.toSiteName;
    data['busid'] = this.busid;
    data['bus_number'] = this.busNumber;
    data['from_userid'] = this.fromUserid;
    data['from_user_name'] = this.fromUserName;
    data['from_email_id'] = this.fromEmailId;
    data['from_user_phone'] = this.fromUserPhone;
    data['to_userid'] = this.toUserid;
    data['to_user_name'] = this.toUserName;
    data['to_email_id'] = this.toEmailId;
    data['to_user_phone'] = this.toUserPhone;
    return data;
  }
}
