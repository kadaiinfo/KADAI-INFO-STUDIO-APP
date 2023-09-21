// Flutterの基本的なライブラリと、WebViewを扱うためのライブラリをインポート
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// メイン関数：Flutterアプリのエントリーポイント
void main() {
  runApp(MyApp());
}

// MyAppクラス：アプリ全体のルートウィジェット
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // アプリのテーマを設定
      theme: ThemeData(
        // 明るさを明るいテーマに設定
        brightness: Brightness.light,
      ),

      home: Scaffold(
        // アプリの背景色を白に設定
        backgroundColor: Colors.white,
        // 以下の部分はAppBarの設定ですが、コメントアウトされているので現在は表示されません。
        // appBar: AppBar(
        //   title: Text(
        //     'KADAI INFO',
        //     style: TextStyle(color: Colors.black),
        //   ),
        //   backgroundColor: Colors.white,
        // ),
        // 本体部分。上部に30ピクセルの余白を持つWebView。
        body: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: WebViewWithErrorHandling(),
        ),
      ),
    );
  }
}

// WebViewを含むウィジェット。エラーハンドリングも含めたWebViewの表示を行う。
class WebViewWithErrorHandling extends StatefulWidget {
  @override
  _WebViewWithErrorHandlingState createState() =>
      _WebViewWithErrorHandlingState();
}

class _WebViewWithErrorHandlingState extends State<WebViewWithErrorHandling> {
  late WebViewController _controller;
  bool _isLoading = true; // WebViewの読み込み状況を表すフラグ

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 横方向のスワイプジェスチャを検出するウィジェット
        GestureDetector(
          onHorizontalDragEnd: (details) {
            // 左方向のスワイプを検出
            if (details.velocity.pixelsPerSecond.dx > 500) {
              if (_controller != null) {
                _controller.goBack(); // WebViewのページを一つ前に戻る
              }
            }
          },
          // 実際のWebViewのウィジェット
          child: WebView(
            initialUrl: 'https://kadaiinfo.com/',
            onWebViewCreated: (WebViewController controller) {
              _controller = controller;
            },
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (String url) {
              // ページの読み込みが完了したら、ローディングフラグをfalseにする。
              setState(() {
                _isLoading = false;
              });
            },
            onPageStarted: (String url) {
              // ページの読み込みを開始したら、ローディングフラグをtrueにする。
              setState(() {
                _isLoading = true;
              });
            },
          ),
        ),
        // ページが読み込み中の場合、ローディングインジケーターを表示する。
        if (_isLoading)
          Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
