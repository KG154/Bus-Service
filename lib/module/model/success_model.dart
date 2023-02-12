class SuccessModel {
  bool? status;
  int? responsecode;
  String? message;

  SuccessModel({this.status, this.responsecode, this.message});

  SuccessModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responsecode = json['responsecode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['responsecode'] = this.responsecode;
    data['message'] = this.message;
    return data;
  }
}


class TripExportModel {
  bool? status;
  int? responsecode;
  String? message;
  String? data;

  TripExportModel({this.status, this.responsecode, this.message, this.data});

  TripExportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responsecode = json['responsecode'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['responsecode'] = this.responsecode;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}

