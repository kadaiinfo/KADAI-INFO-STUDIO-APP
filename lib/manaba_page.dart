import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ManabaPage extends StatefulWidget {
  @override
  _ManabaPageState createState() => _ManabaPageState();
}

class _ManabaPageState extends State<ManabaPage> {
  final String manabaUrl = 'https://manaba.kic.kagoshima-u.ac.jp/';
  WebViewController? _controller; // WebViewコントローラーのインスタンス

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //title: Text('Manaba'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
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
      body: WebView(
        initialUrl: manabaUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController; // コントローラーを設定
        },
        // ... その他のWebView設定
      ),
    );
  }
}
