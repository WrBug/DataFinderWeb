import 'package:data_finder_web/model/entity/directory_info.dart';
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

  static Future<List<FileInfo>> getHistory() async {
    var response = await HttpUtils.post("/history");
    List<FileInfo> list = [];
    response?.data?.forEach((item) {
      var info = FileInfo.fromJson(item);
      list.add(info);
    });
    return list;
  }

  static Future<ApiResult<FileInfo>> getFileInfo(String path) async {
    var response = await HttpUtils.post("/get_file_info", body: {"file": path});
    if (!response.success) {
      return new ApiResult.failed(response.message);
    }
    return new ApiResult.success(FileInfo.fromJson(response.data));
  }

  static Future<ApiResult<DirectoryInfo>> getDirectoryInfo(String path) async {
    var response =
        await HttpUtils.post("/get_directory_info", body: {"directory": path});
    if (!response.success) {
      return new ApiResult.failed(response.message);
    }
    return new ApiResult.success(DirectoryInfo.fromJson(response.data));
  }
}

class ApiResult<T> {
  T data;
  bool success;
  String message;

  ApiResult.success(T data) {
    this.data = data;
    success = true;
  }

  ApiResult.failed(message) {
    success = false;
    this.message = message;
  }
}
