class BusesListModel {
  bool? status;
  int? responsecode;
  String? message;
  List<BusesListData>? data;

  BusesListModel({this.status, this.responsecode, this.message, this.data});

  BusesListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responsecode = json['responsecode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BusesListData>[];
      json['data'].forEach((v) {
        data!.add(new BusesListData.fromJson(v));
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

class BusesListData {
  int? id;
  String? busNumber;
  String? status;
  String? busLocation;

  BusesListData({this.id, this.busNumber, this.status, this.busLocation});

  BusesListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    busNumber = json['bus_number'];
    status = json['status'];
    busLocation = json['bus_location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bus_number'] = this.busNumber;
    data['status'] = this.status;
    data['bus_location'] = this.busLocation;
    return data;
  }
}
