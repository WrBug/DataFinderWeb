import 'package:data_finder_web/model/entity/preview_info.dart';
import 'package:data_finder_web/model/type/mime_type.dart';

abstract class PreviewProvider {
  bool match(MimeType type);

  void go(PreviewInfo info);
}
