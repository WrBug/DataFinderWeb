import 'package:data_finder_web/model/entity/base_file_info.dart';
import 'package:data_finder_web/model/entity/file_info.dart';

class DirectoryInfo extends BaseFileInfo {
  List<BaseFileInfo> children;
  DirNumberInfo info;
  String parent;
  String fileType;
  String name;
  String path;
  String type;

  DirectoryInfo(
      {this.children,
      this.info,
      this.parent,
      this.fileType,
      this.name,
      this.path,
      this.type});

  DirectoryInfo.fromJson(Map<String, dynamic> json) {
    if (json['children'] != null) {
      children = new List<BaseFileInfo>();
      json['children'].forEach((v) {
        if (v['fileType'] == "FILE") {
          children.add(new FileInfo.fromJson(v));
        } else {
          children.add(new DirectoryInfo.fromJson(v));
        }
      });
    }
    info =
        json['info'] != null ? new DirNumberInfo.fromJson(json['info']) : null;
    parent = json['parent'];
    fileType = json['fileType'];
    name = json['name'];
    path = json['path'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    data['parent'] = this.parent;
    data['fileType'] = this.fileType;
    data['name'] = this.name;
    data['path'] = this.path;
    data['type'] = this.type;
    return data;
  }
}

class DirNumberInfo {
  int directoryCount;
  int fileCount;
  int size;
  int total;

  DirNumberInfo({this.directoryCount, this.fileCount, this.size, this.total});

  DirNumberInfo.fromJson(Map<String, dynamic> json) {
    directoryCount = json['directoryCount'];
    fileCount = json['fileCount'];
    size = json['size'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['directoryCount'] = this.directoryCount;
    data['fileCount'] = this.fileCount;
    data['size'] = this.size;
    data['total'] = this.total;
    return data;
  }
}
