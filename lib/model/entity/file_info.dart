class FileInfo {
  String downloadUrl;
  String md5;
  int modifyTime;
  bool preview;
  bool readable;
  int size;
  bool writable;
  String fileType;
  String name;
  String path;
  String type;

  FileInfo(
      {this.downloadUrl,
      this.md5,
      this.modifyTime,
      this.preview,
      this.readable,
      this.size,
      this.writable,
      this.fileType,
      this.name,
      this.path,
      this.type});

  String getFileSize() {
    double s = size / 1024.0;
    if (s < 1024) {
      return s.toStringAsFixed(2) + " KB";
    }
    s = s / 1024.0;
    if (s < 1024) {
      return s.toStringAsFixed(2) + " MB";
    }
    s = s / 1024.0;
    if (s < 1024) {
      return s.toStringAsFixed(2) + " GB";
    }
    s = s / 1024.0;
    return s.toStringAsFixed(2) + " TB";
  }

  String getModifyTime() {
    var date = new DateTime.fromMillisecondsSinceEpoch(modifyTime);
    return date.toString();
  }

  FileInfo.fromJson(Map<String, dynamic> json) {
    downloadUrl = json['downloadUrl'];
    md5 = json['md5'];
    modifyTime = json['modifyTime'];
    preview = json['preview'];
    readable = json['readable'];
    size = json['size'];
    writable = json['writable'];
    fileType = json['fileType'];
    name = json['name'];
    path = json['path'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['downloadUrl'] = this.downloadUrl;
    data['md5'] = this.md5;
    data['modifyTime'] = this.modifyTime;
    data['preview'] = this.preview;
    data['readable'] = this.readable;
    data['size'] = this.size;
    data['writable'] = this.writable;
    data['fileType'] = this.fileType;
    data['name'] = this.name;
    data['path'] = this.path;
    data['type'] = this.type;
    return data;
  }
}
