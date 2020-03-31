import 'dart:convert';

import 'package:data_finder_web/network/response_data.dart';
import 'package:data_finder_web/util/window_manager.dart';
import 'package:dio/adapter_browser.dart';
import 'package:dio/browser_imp.dart';
import 'package:dio/dio.dart';
import 'dart:html';

class HttpUtils {
  static var _dio;
  static String _url;

  static Dio _getDio() {
    String url = getUrl();
    if (_dio == null) {
      var apiUrl = url + "/api";
      _dio = new DioForBrowser(new BaseOptions(
          baseUrl: apiUrl,
          connectTimeout: 5000,
          receiveTimeout: 100000,
          // 5s
          headers: {"api": "1.0.0"},
          contentType: Headers.formUrlEncodedContentType,
          // Transform the response data to a String encoded with UTF8.
          // The default value is [ResponseType.JSON].
          responseType: ResponseType.plain));
      var adapter = BrowserHttpClientAdapter();
      adapter.withCredentials = true;
      _dio.httpClientAdapter = adapter;
    }
    return _dio;
  }

  static Future<ResponseData> post(String path,
      {Map<String, dynamic> body}) async {
    var response = await _getDio().post(path, data: body);
    Map<String, dynamic> result = jsonDecode(response.data);
    print(result);
    return ResponseData.fromJson(result);
  }

  static void download(String path) {
    WindowManager.openPageOnNewTab(getUrl() + path);
  }

  static String getUrl() {
    var host = window.location.hostname;
    var port = window.location.port;
    host = "172.18.212.47";
    port = "57335";
    var u = window.location.protocol + "//" + host + ":" + port;
    if (u != _url) {
      _url = u;
      _dio = null;
    }
    print(u);
    return _url;
  }
}
