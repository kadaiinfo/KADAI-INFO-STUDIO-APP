//インポートしたものは、pubspec.yamlに記載する必要があります。
//記載した後はターミナルでflutter pub getを実行してください。
import 'package:flutter/material.dart'; // Flutterのマテリアルデザインウィジェットをインポートします。
import 'package:webview_flutter/webview_flutter.dart'; // WebViewを表示するためのパッケージをインポートします。
import 'package:firebase_core/firebase_core.dart'; //今後通知を実装するために必要なパッケージをインポートします。
import 'package:firebase_messaging/firebase_messaging.dart'; //今後通知を実装するために必要なパッケージをインポートします。

import 'setting_page.dart'; // settingファイルをインポート

void main() {
  runApp(MyApp()); // アプリケーションを起動し、MyAppをルートウィジェットとして設定します。
}

// アプリケーションのルートとなるウィジェットを定義します。
class MyApp extends StatelessWidget {
  // StatelessWidgetを継承したMyAppクラスを定義します。
  @override
  Widget build(BuildContext context) {
    // buildメソッドをオーバーライドします。ウィジェットのUIをここで構築します。
    return MaterialApp(
      // MaterialAppウィジェットを返します。アプリのルートとなります。
      theme: ThemeData(
        // アプリ全体のテーマを設定します。
        brightness: Brightness.light, // 明るいテーマを適用します。
      ),
      home:
          //homeプロパティにWebViewWithErrorHandlingウィジェットを設定します。これが初期画面になります。
          WebViewWithErrorHandling(),
    );
  }
}

// WebViewを表示し、エラーハンドリングをするためのStatefulWidgetクラス。
class WebViewWithErrorHandling extends StatefulWidget {
  @override
  _WebViewWithErrorHandlingState createState() =>
      _WebViewWithErrorHandlingState();
  // createState()は新しいStateオブジェクトを作成します。_WebViewWithErrorHandlingStateは後で定義します。
}

// _WebViewWithErrorHandlingのStateクラス。UIの状態を管理します。
class _WebViewWithErrorHandlingState extends State<WebViewWithErrorHandling> {
  late WebViewController _controller; // WebViewのコントローラ。ページの読み込みやナビゲーションを制御します。
  bool _isLoading = true; // ページが読み込み中かどうかを示すフラグ。
  int _currentIndex = 0; // 現在表示しているURLのインデックス。_urlsリストで使用します。

  // 表示するウェブページのURLリスト。
  final _urls = [
    'https://kadaiinfo.com/', // トップページのURL
    'https://kadaiinfo.com/contents/', // コンテンツページのURL
    'https://manaba.kic.kagoshima-u.ac.jp/', // ManabaのURL
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0), // AppBarの高さを設定
        child: AppBar(
          backgroundColor: Colors.white, // AppBarの背景色を白に設定
          iconTheme: IconThemeData(color: Colors.black54), // アイコンの色を設定
          elevation: 0, // AppBarの影をなくす
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [],
          ),
        ),
      ),
      body: _currentIndex != 3
          ? Stack(
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
            )
          : SettingsPage(), // SettingsPageを表示する

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (_currentIndex != 3) {
              // 'その他'が選択された場合、WebViewを更新しない
              _controller.loadUrl(_urls[_currentIndex]);
            }
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
