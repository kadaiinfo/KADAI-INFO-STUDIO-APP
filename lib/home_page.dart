// トップページを管理するファイルです。
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatelessWidget {
  final String homeUrl = 'https://kadaiinfo.com/';

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: homeUrl,
      javascriptMode: JavascriptMode.unrestricted,
      // ... その他のWebView設定
    );
  }
}
