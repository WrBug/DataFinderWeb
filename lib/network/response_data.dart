class ResponseData {
  dynamic data;
  bool success;

  ResponseData({this.data, this.success});

  ResponseData.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['success'] = this.success;
    return data;
  }
}
