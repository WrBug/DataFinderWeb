import 'package:data_finder_web/model/entity/file_info.dart';
import 'package:data_finder_web/network/api.dart';
import 'package:data_finder_web/util/download_manager.dart';
import 'package:data_finder_web/util/icon_utils.dart';
import 'package:flutter/material.dart';

class FileInfoPage extends StatefulWidget {
  final filePath;

  FileInfoPage(this.filePath);

  @override
  State<StatefulWidget> createState() => _FileInfoPage(filePath);

  static void start(BuildContext context, String filePath) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => FileInfoPage(filePath)));
  }
}

class _FileInfoPage extends State<FileInfoPage> {
  final filePath;
  String fileName;
  FileInfo _fileInfo;

  _FileInfoPage(this.filePath) {
    fileName = filePath.substring(filePath.lastIndexOf("/") + 1);
  }

  @override
  void initState() {
    super.initState();
    getFileInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(fileName)),
      body: _buildBody(context),
    );
  }

  void getFileInfo() async {
    var info = await ApiRequest.getFileInfo(filePath);
    setState(() {
      _fileInfo = info;
    });
  }

  _buildBody(BuildContext context) {
    return _fileInfo == null ? _buildProgress(context) : _buildContent(context);
  }

  _buildProgress(BuildContext context) {
    return Container();
  }

  _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 128,
                child: Image.asset(
                  IconUtils.getIcon(_fileInfo.type),
                  width: 128,
                  height: 128,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildRow("文件名", _fileInfo.name),
                  _buildRow("大小", _fileInfo.getFileSize()),
                  _buildRow("MD5", _fileInfo.md5),
                  _buildRow("修改时间", _fileInfo.getModifyTime()),
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          ),
          _buildButton("预览", _fileInfo.preview, () {
            DownloadManager.download(_fileInfo.downloadUrl);
          }),
          _buildButton("下载", _fileInfo.readable, () {
            DownloadManager.download(_fileInfo.downloadUrl);
          })
        ],
      ),
    );
  }

  _buildRow(String title, String name) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 80,
          child: Text(
            title,
            style: TextStyle(color: Colors.lightBlue, fontSize: 16),
          ),
        ),
        SelectableText(
          name,
          style: TextStyle(fontSize: 16),
          toolbarOptions: ToolbarOptions(copy: true),
        )
      ],
    );
  }

  _buildButton(String text, bool enable, VoidCallback onPressed) {
    return Row(children: <Widget>[
      Expanded(
        child: RaisedButton(
          color: Colors.lightBlue,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.white,
          textColor: Colors.white,
          child: Text(text),
          onPressed: enable ? onPressed : null,
        ),
      )
    ]);
  }
}
