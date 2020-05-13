import 'package:data_finder_web/util/icon_utils.dart';

abstract class BaseFileInfo {
  String name;
  String path;
  String iconType;
  String fileType;

  bool isFile() {
    return fileType == 'FILE';
  }

  String getIconType() => IconUtils.getIcon(iconType);

  Map<String, dynamic> toJson();
}
