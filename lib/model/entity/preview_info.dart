import 'package:data_finder_web/model/type/mime_type.dart';
import 'package:data_finder_web/model/type/type_utils.dart';

class PreviewInfo {
  dynamic formatData;
  String raw;
  String mimeType;

  PreviewInfo({this.formatData, this.raw, this.mimeType});

  PreviewInfo.fromJson(Map<String, dynamic> json) {
    formatData = json['formatData'];
    raw = json['raw'];
    mimeType = json['mimeType'];
  }

  MimeType getMimeType() {
    return TypeUtils.getMimeType(mimeType);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.formatData != null) {
      data['formatData'] = this.formatData;
    }
    data['raw'] = this.raw;
    data['mimeType'] = this.mimeType;
    return data;
  }
}
