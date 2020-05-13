import 'package:data_finder_web/util/icon_utils.dart';

class HomeInfo {
  String iconType;
  String name;
  String path;
  bool readable;
  String fileType;

  HomeInfo({this.iconType, this.name, this.path, this.readable, this.fileType});

  HomeInfo.fromJson(Map<String, dynamic> json) {
    iconType = json['iconType'];
    name = json['name'];
    path = json['path'];
    readable = json['readable'];
    fileType = json['fileType'];
  }

  String getIcon() => IconUtils.getIcon(iconType);

  bool isFile() {
    return fileType == 'FILE';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iconType'] = this.iconType;
    data['name'] = this.name;
    data['path'] = this.path;
    data['readable'] = this.readable;
    data['fileType'] = this.fileType;
    return data;
  }
}