class IconUtils {
  static String getIcon(String icon) {
    switch (icon) {
      case 'Apk':
        return 'assets/ic_apk.png';
      case 'Database':
        return 'assets/ic_database.png';
      case 'Xml':
        return 'assets/ic_xml.png';
      case 'Dir':
        return 'assets/ic_dir.png';
      case 'SdCard':
        return 'assets/ic_sd_card.png';
    }
    return 'assets/ic_file.png';
  }
}
