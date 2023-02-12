class DashboardModel {
  bool? status;
  int? responsecode;
  String? message;
  Data? data;

  DashboardModel({this.status, this.responsecode, this.message, this.data});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responsecode = json['responsecode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  int? sessionId;
  String? sessionDate;
  String? sessionStartAt;
  String? sessionEndAt;
  int? busCounter;
  int? tripCounter;
  int? passenger;
  int? emptyTripCounter;
  int? passengerTripCounter;
  int? onTheWayCounter;
  int? getSchemeCounter;
  int? getNagerCounter;

  Data(
      {this.sessionId,
        this.sessionDate,
        this.sessionStartAt,
        this.sessionEndAt,
        this.busCounter,
        this.tripCounter,
        this.passenger,
        this.emptyTripCounter,
        this.passengerTripCounter,
        this.onTheWayCounter,
        this.getSchemeCounter,
        this.getNagerCounter});

  Data.fromJson(Map<String, dynamic> json) {
    sessionId = json['session_id'];
    sessionDate = json['session_date'];
    sessionStartAt = json['session_start_at'];
    sessionEndAt = json['session_end_at'];
    busCounter = json['bus_counter'];
    tripCounter = json['trip_counter'];
    passenger = json['passenger'];
    emptyTripCounter = json['empty_trip_counter'];
    passengerTripCounter = json['passenger_trip_counter'];
    onTheWayCounter = json['on_the_way_counter'];
    getSchemeCounter = json['get_scheme_counter'];
    getNagerCounter = json['get_nager_counter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session_id'] = this.sessionId;
    data['session_date'] = this.sessionDate;
    data['session_start_at'] = this.sessionStartAt;
    data['session_end_at'] = this.sessionEndAt;
    data['bus_counter'] = this.busCounter;
    data['trip_counter'] = this.tripCounter;
    data['passenger'] = this.passenger;
    data['empty_trip_counter'] = this.emptyTripCounter;
    data['passenger_trip_counter'] = this.passengerTripCounter;
    data['on_the_way_counter'] = this.onTheWayCounter;
    data['get_scheme_counter'] = this.getSchemeCounter;
    data['get_nager_counter'] = this.getNagerCounter;
    return data;
  }
}
