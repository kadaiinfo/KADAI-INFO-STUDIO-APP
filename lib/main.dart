//インポートしたものは、pubspec.yamlに記載する必要があります。
//記載した後はターミナルでflutter pub getを実行してください。
import 'package:flutter/material.dart'; // Flutterのマテリアルデザインウィジェットをインポートします。
import 'package:webview_flutter/webview_flutter.dart'; // WebViewを表示するためのパッケージをインポートします。
//import 'package:firebase_core/firebase_core.dart'; //今後通知を実装するために必要なパッケージをインポートします。
//import 'package:firebase_messaging/firebase_messaging.dart'; //今後通知を実装するために必要なパッケージをインポートします。

import 'setting_page.dart'; // settingファイルをインポート
import 'contets_page.dart'; // contetsファイルをインポート

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light),
      home: WebViewWithErrorHandling(),
    );
  }
}

class WebViewWithErrorHandling extends StatefulWidget {
  @override
  _WebViewWithErrorHandlingState createState() =>
      _WebViewWithErrorHandlingState();
}

class _WebViewWithErrorHandlingState extends State<WebViewWithErrorHandling> {
  late WebViewController _controller;
  bool _isLoading = true;
  int _currentIndex = 0;

  final _urls = [
    'https://kadaiinfo.com/',
    //'https://kadaiinfo.com/contents/', //コンテンツページをwebviewさせようと考えていたが、拡張性を持たせるため、flutter上で作ることにした。
    'https://manaba.kic.kagoshima-u.ac.jp/',
  ];

  @override
  Widget build(BuildContext context) {
    Widget _body;

    switch (_currentIndex) {
      case 0:
      case 2:
        _body = Stack(
          children: [
            WebView(
              initialUrl: _urls[_currentIndex],
              onWebViewCreated: (WebViewController controller) {
                _controller = controller;
              },
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (String url) {
                setState(() {
                  _isLoading = false;
                });
              },
              onPageStarted: (String url) {
                setState(() {
                  _isLoading = true;
                });
              },
            ),
            if (_isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        );
        break;
      case 1:
        _body = ContentsPage();
        break;
      case 3:
        _body = SettingsPage();
        break;
      default:
        _body = Center(child: Text('ページが見つかりません'));
        break;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black54),
          elevation: 0,
        ),
      ),
      body: _body,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'コンテンツ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'manaba',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'その他',
          ),
        ],
      ),
    );
  }
}
