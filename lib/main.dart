import 'package:data_finder_web/model/entity/home_info.dart';
import 'package:data_finder_web/page/directory_info_page.dart';
import 'package:data_finder_web/page/file_info_page.dart';
import 'package:flutter/material.dart';

import 'model/entity/file_info.dart';
import 'network/api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DataFinder',
      theme: ThemeData.light(),
      home: Home('DataFinder'),
    );
  }
}

class Home extends StatefulWidget {
  final String title;

  Home(this.title) {}

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<HomeInfo> _homeInfoList = [];
  List<FileInfo> _historyInfo = [];

  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData() {
    getHomeInfo();
    getHistory();
  }

  void getHomeInfo() async {
    var list = await ApiRequest.homeInfo();
    setState(() {
      _homeInfoList.clear();
      _homeInfoList.addAll(list);
    });
  }

  void getHistory() async {
    var history = await ApiRequest.getHistory();
    setState(() {
      _historyInfo.clear();
      _historyInfo.addAll(history);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          _buildFastExplorer(context),
          Padding(padding: EdgeInsets.all(20)),
          _buildHistoryFile(context)
        ]),
      ),
    );
  }

  Widget _buildFastExplorer(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "快速访问",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
            _buildFastExplorerListView(context)
          ],
        ),
      ),
    );
  }

  Widget _buildFastExplorerListView(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _homeInfoList.length,
        itemBuilder: (context, index) {
          final homeInfo = _homeInfoList[index];
          return InkWell(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    homeInfo.getIcon(),
                    width: 24,
                    height: 24,
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        homeInfo.name,
                        style: TextStyle(color: Colors.lightBlue, fontSize: 16),
                      ),
                      Text(
                        homeInfo.path,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      )
                    ],
                  )
                ],
              ),
            ),
            onTap: () {
              if (homeInfo.isFile()) {
                FileInfoPage.start(context, homeInfo.path);
              } else {
                DirectoryInfoPage.start(context, homeInfo.path);
              }
            },
          );
        });
  }

  _buildHistoryFile(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "访问历史",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
            _buildHistoryFileListView(context)
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryFileListView(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _historyInfo.length,
        itemBuilder: (context, index) {
          final historyInfo = _historyInfo[index];
          return InkWell(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    historyInfo.getIconType(),
                    width: 24,
                    height: 24,
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        historyInfo.name,
                        style: TextStyle(color: Colors.lightBlue, fontSize: 16),
                      ),
                      Text(
                        historyInfo.path,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      )
                    ],
                  )
                ],
              ),
            ),
            onTap: () {
              if (historyInfo.isFile()) {
                FileInfoPage.start(context, historyInfo.path);
              } else {
                DirectoryInfoPage.start(context, historyInfo.path);
              }
            },
          );
        });
  }
}
