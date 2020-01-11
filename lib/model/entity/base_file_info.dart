import 'package:data_finder_web/util/icon_utils.dart';

abstract class BaseFileInfo {
  String name;
  String path;
  String type;
  String fileType;

  bool isFile() {
    return fileType == 'FILE';
  }

  String getIcon() => IconUtils.getIcon(type);

  Map<String, dynamic> toJson();
}
