import '../data/table_data.dart';

class TableResponse {
  String? timestamp;
  bool? status;
  String? message;
  List<TableData>? data;

  TableResponse({this.timestamp, this.status, this.message, this.data});

  TableResponse.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    message = json['message'];
    data = List<TableData>.from(json["data"].map((x) => TableData.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] =  List<dynamic>.from(this.data!.map((x) => x.toJson()));
    }
    return data;
  }
}


