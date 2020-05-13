import 'package:data_finder_web/model/entity/base_file_info.dart';
import 'package:data_finder_web/model/entity/directory_info.dart';
import 'package:data_finder_web/model/entity/file_info.dart';
import 'package:data_finder_web/network/api.dart';
import 'package:data_finder_web/page/file_info_page.dart';
import 'package:data_finder_web/util/toast_utils.dart';
import 'package:flutter/material.dart';

class DirectoryInfoPage extends StatefulWidget {
  final _directoryPath;
  final _srcDirectoryPath;

  DirectoryInfoPage(this._directoryPath, this._srcDirectoryPath);

  static void start(BuildContext context, String directoryPath,
      {String srcDirectoryPath}) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            DirectoryInfoPage(directoryPath, srcDirectoryPath)));
  }

  @override
  State<StatefulWidget> createState() =>
      _DirectoryInfoPage(_directoryPath, _srcDirectoryPath);
}

class _DirectoryInfoPage extends State<DirectoryInfoPage> {
  final _directoryPath;
  final _srcDirectoryPath;
  String fileName;
  DirectoryInfo _directoryInfo;
  TextEditingController _controller;

  _DirectoryInfoPage(this._directoryPath, this._srcDirectoryPath) {
    fileName = _directoryPath.substring(_directoryPath.lastIndexOf("/") + 1);
  }

  @override
  void initState() {
    super.initState();
    getDirInfo();
    _controller = TextEditingController(text: _directoryPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(fileName)),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: Column(
          children: <Widget>[_buildSearchView(context), _buildContent(context)],
        ));
  }

  _buildSearchView(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
          height: 38,
          child: TextField(
            controller: _controller,
            maxLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '路径',
            ),
          ),
        )),
        Container(
          width: 10,
        ),
        RaisedButton(
            child: Text("转到"),
            color: Colors.lightBlue,
            textColor: Colors.white,
            onPressed: () {
              var path = _controller.text;
              if (path == _directoryPath) {
                return;
              }
              DirectoryInfoPage.start(context, _controller.text,
                  srcDirectoryPath: _directoryPath);
            })
      ],
    );
  }

  _buildContent(BuildContext context) {
    return Expanded(
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
              itemCount:
                  _directoryInfo == null ? 0 : _directoryInfo.info.total + 1,
              itemBuilder: (context, position) {
                if (position == 0) {
                  return InkWell(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 4),
                      child: Text("返回上级目录",
                          style: TextStyle(
                              color: Colors.blueAccent, fontSize: 16)),
                    ),
                    onTap: () {
                      var parent = _directoryInfo.parent;
                      if (parent == _srcDirectoryPath) {
                        Navigator.pop(context);
                        return;
                      }
                      DirectoryInfoPage.start(context, _directoryInfo.parent,
                          srcDirectoryPath: _directoryPath);
                    },
                  );
                }
                var info = _directoryInfo.children[position - 1];
                return InkWell(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          info.getIconType(),
                          width: 24,
                          height: 24,
                        ),
                        Container(
                          padding: EdgeInsets.all(6),
                        ),
                        _buildFileCell(context, info)
                      ],
                    ),
                  ),
                  onTap: () {
                    if (info.isFile()) {
                      FileInfoPage.start(context, info.path);
                    } else {
                      DirectoryInfoPage.start(context, info.path,
                          srcDirectoryPath: _directoryPath);
                    }
                  },
                );
              }),
        ),
      ),
    );
  }

  void getDirInfo() async {
    var info = await ApiRequest.getDirectoryInfo(_directoryPath);
    print(info);
    if (!info.success) {
      ToastUtils.showLong(context, info.message);
      Navigator.pop(context);
      return;
    }
    setState(() {
      _directoryInfo = info.data;
    });
  }

  _buildFileCell(BuildContext context, BaseFileInfo info) {
    if (info.isFile()) {
      FileInfo fileInfo = info;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(info.name,
                  style: TextStyle(color: Colors.orangeAccent, fontSize: 16)),
              Container(
                width: 10,
              ),
              Text(fileInfo.getFileSize(),
                  style: TextStyle(color: Colors.grey, fontSize: 14))
            ],
          ),
          Text(fileInfo.getModifyTime(),
              style: TextStyle(color: Colors.grey, fontSize: 14)),
        ],
      );
    }
    return Text(info.name,
        style: TextStyle(color: Colors.lightBlue, fontSize: 16));
  }
}
