import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ManabaPage extends StatefulWidget {
  @override
  _ManabaPageState createState() => _ManabaPageState();
}

class _ManabaPageState extends State<ManabaPage> {
  final String manabaUrl = 'https://manaba.kic.kagoshima-u.ac.jp/';
  InAppWebViewController? _controller; // InAppWebViewコントローラーのインスタンス

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
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(manabaUrl)),
        onWebViewCreated: (InAppWebViewController controller) {
          _controller = controller;
        },
        // ... その他のWebView設定
      ),
    );
  }
}

// クッキーを取得
Future<List<Cookie>> getCookies(String url) async {
  CookieManager cookieManager = CookieManager.instance();
  List<Cookie> cookies = await cookieManager.getCookies(url: Uri.parse(url));
  return cookies;
}

// クッキーを設定
void setCookie(String url, String name, String value) async {
  CookieManager cookieManager = CookieManager.instance();
  await cookieManager.setCookie(
    url: Uri.parse(url),
    name: name,
    value: value,
    // 他に必要なパラメータがあれば設定
  );
}
