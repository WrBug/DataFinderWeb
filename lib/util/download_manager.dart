import 'package:data_finder_web/network/http_utils.dart';

class DownloadManager {
  static void download(String path) {
    HttpUtils.download(path);
  }
}
