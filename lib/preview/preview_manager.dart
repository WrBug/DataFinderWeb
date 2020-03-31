import 'package:data_finder_web/model/entity/preview_info.dart';
import 'package:data_finder_web/preview/database_previw_provider.dart';
import 'package:data_finder_web/preview/preview_provider.dart';

class PreviewManager {
  static List<PreviewProvider> list = [DatabasePreviewProvider()];

  static void goPreview(PreviewInfo info) {
    list.forEach((provider) {
      if (provider.match(info.getMimeType())) {
        provider.go(info);
      }
    });
  }
}
