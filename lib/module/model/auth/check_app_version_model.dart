class CheckAppVersionModel {
  bool? status;
  int? responsecode;
  String? message;
  String? isApplicationUpdate;
  String? baseUrl;
  String? fileUrl;

  CheckAppVersionModel({this.status, this.responsecode, this.message, this.isApplicationUpdate, this.baseUrl, this.fileUrl});

  CheckAppVersionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responsecode = json['responsecode'];
    message = json['message'];
    isApplicationUpdate = json['is_application_update'];
    baseUrl = json['base_url'];
    fileUrl = json['file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['responsecode'] = this.responsecode;
    data['message'] = this.message;
    data['is_application_update'] = this.isApplicationUpdate;
    data['base_url'] = this.baseUrl;
    data['file_url'] = this.fileUrl;
    return data;
  }
}
