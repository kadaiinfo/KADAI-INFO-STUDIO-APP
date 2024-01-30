import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:settings_ui/settings_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: WebViewWithErrorHandling(),
    );
  }
}

class WebViewWithErrorHandling extends StatefulWidget {
  @override
  _WebViewWithErrorHandlingState createState() => _WebViewWithErrorHandlingState();
}

class _WebViewWithErrorHandlingState extends State<WebViewWithErrorHandling> {
  late WebViewController _controller;
  bool _isLoading = true;
  int _currentIndex = 0;

  final _urls = [
    'https://kadaiinfo.com/',
    'https://kadaiinfo.com/contents/',
    'https://manaba.kic.kagoshima-u.ac.jp/',
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
      body: _currentIndex != 3 ? 
        Stack(
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
        ) : 
        SettingsPage(), // SettingsPageを表示する

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (_currentIndex != 3) { // 'その他'が選択された場合、WebViewを更新しない
              _controller.loadUrl(_urls[_currentIndex]);
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '記事',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'コンテンツ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Manaba',
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



class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('一般'),
            tiles: [
              SettingsTile(
                title: const Text('通知'),
                leading: const Icon(Icons.notifications_active_outlined),
                trailing: const Icon(Icons.navigate_next),
                onPressed: (BuildContext context) {
                  // 通知設定ページへの遷移などの処理をここに書く




                },
              ),
            ],
          ),
          SettingsSection(
            title: const Text('このアプリについて'),
            tiles: [
              SettingsTile(
                title: const Text('KADAI INFOについて'),
                trailing: const Icon(Icons.launch),
                onPressed: (BuildContext context) {
                  // 'KADAI INFOについて'ページへの遷移などの処理をここに書く
                  //URLに遷移する
  
                },
              ),
              SettingsTile(
                title: const Text('お問合せ'),
                trailing: const Icon(Icons.launch),
                onPressed: (BuildContext context) {
                  // お問い合わせページへの遷移などの処理をここに書く

                },
              ),
              SettingsTile(
                title: const Text('利用規約'),
                trailing: const Icon(Icons.launch),
                onPressed: (BuildContext context) {
                  // ライセンスページへの遷移などの処理をここに書く



                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

