import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String homeUrl = 'https://kadaiinfo.com/';
  WebViewController? _controller; // WebViewコントローラーのインスタンス

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0), // アプリバーの高さを設定
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0, // 影を消す
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: () async {
              if (_controller != null && await _controller!.canGoBack()) {
                // WebViewの前のページに戻る
                _controller!.goBack();
              } else {
                // WebViewで戻るページがない場合は、アプリの前の画面に戻る
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              }
            },
          ),
        ),
      ),
      body: WebView(
        initialUrl: homeUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController; // コントローラーを設定
        },
        // ... その他のWebView設定
      ),
    );
  }
}
