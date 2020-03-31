import 'dart:html';

class WindowManager {
  static void openPageOnNewTab(String url,[String options]) {
    window.open(url, options);
  }
}
