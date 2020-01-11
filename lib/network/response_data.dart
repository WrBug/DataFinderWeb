class ResponseData {
  dynamic data;
  bool success;
  String message;
  int code;

  ResponseData({this.data, this.success, this.message, this.code});

  ResponseData.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    success = json['success'];
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['success'] = this.success;
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}
