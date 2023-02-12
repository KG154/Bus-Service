class SiteListModel {
  bool? status;
  int? responsecode;
  String? message;
  List<SiteListData>? data;

  SiteListModel({this.status, this.responsecode, this.message, this.data});

  SiteListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responsecode = json['responsecode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SiteListData>[];
      json['data'].forEach((v) {
        data!.add(new SiteListData.fromJson(v));
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

class SiteListData {
  int? id;
  String? name;
  String? status;
  String? sidetype;


  SiteListData({this.id, this.name, this.status,this.sidetype});

  SiteListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    sidetype = json['sidetype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['sidetype'] = this.sidetype;
    return data;
  }
}
