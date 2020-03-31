import 'package:data_finder_web/model/type/mime_type.dart';

class TypeUtils {
  static MimeType getMimeType(String type) {
    switch (type) {
      case 'Apk':
        return MimeType.Apk;
      case 'Database':
        return MimeType.Database;
      case 'Xml':
        return MimeType.Xml;
      case 'Unknown':
        return MimeType.Unknown;
      case 'FILE':
        return MimeType.FILE;
    }
    return MimeType.Unknown;
  }
}
