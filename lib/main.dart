import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
            children: [
              // 必要なIconButtonをここに追加
            ],
          ),
        ),
      ),
      body: _currentIndex < 2
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
          : (_currentIndex == 2 ? ContentsPage() : SettingsPage()),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index < 2) {
              _controller.loadUrl(_urls[_currentIndex]);
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: '記事',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Manaba',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'コンテンツ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '設定',
          ),
        ],
      ),
    );
  }
}

class ContentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0), // AppBarの高さを設定
        child: AppBar(
          backgroundColor: Colors.white, // AppBarの背景色を白に設定
          iconTheme: IconThemeData(color: Colors.black54), // アイコンの色を設定
          elevation: 0, // AppBarの影をなくす
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 必要なIconButtonをここに追加
            ],
          ),
        ),
      ),
      
      body: Center(
        child: Text('Coming soon...'),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0), // AppBarの高さを設定
        child: AppBar(
          backgroundColor: Colors.white, // AppBarの背景色を白に設定
          iconTheme: IconThemeData(color: Colors.black54), // アイコンの色を設定
          elevation: 0, // AppBarの影をなくす
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 必要なIconButtonをここに追加
            ],
          ),
        ),
      ),
      body: Center(
        child: Text('Coming soon...'),
      ),
    );
  }
}
