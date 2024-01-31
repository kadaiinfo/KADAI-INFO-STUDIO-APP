// manabaのページを表示するためのページ
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ManabaPage extends StatelessWidget {
  final String manabaUrl = 'https://manaba.kic.kagoshima-u.ac.jp/';

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: manabaUrl,
      javascriptMode: JavascriptMode.unrestricted,
      // ... その他のWebView設定
    );
  }
}
