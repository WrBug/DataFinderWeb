import 'package:data_finder_web/model/entity/file_info.dart';
import 'package:data_finder_web/model/entity/home_info.dart';
import 'http_utils.dart';

class ApiRequest {
  static Future<List<HomeInfo>> homeInfo() async {
    var response = await HttpUtils.post("/home");
    List<HomeInfo> list = [];
    response.data.forEach((item) {
      var info = HomeInfo.fromJson(item);
      list.add(info);
    });
    return list;
  }

  static getList(String path) async {
    var response = await HttpUtils.post("/list", body: {"path": path});
    print(response.data);
  }

  static Future<FileInfo> getFileInfo(String path) async {
    var response = await HttpUtils.post("/get_file_info", body: {"file": path});
    return FileInfo.fromJson(response.data);
  }
}
