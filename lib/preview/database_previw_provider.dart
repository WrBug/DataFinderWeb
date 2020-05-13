import 'package:data_finder_web/model/entity/preview_info.dart';
import 'package:data_finder_web/model/type/mime_type.dart';
import 'package:data_finder_web/preview/preview_provider.dart';
import 'package:data_finder_web/util/window_manager.dart';

class DatabasePreviewProvider implements PreviewProvider {
  @override
  void go(PreviewInfo info) {
    WindowManager.openPageOnNewTab(info.formatData["url"]);
  }

  @override
  bool match(MimeType type) {
    return type == MimeType.Database;
  }
}
