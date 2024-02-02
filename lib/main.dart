import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'setting_page.dart';
import 'contents_page.dart';
import 'home_page.dart';
import 'manaba_page.dart';

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
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget _body;

    // インデックスによってbodyを変更します。
    switch (_currentIndex) {
      case 0:
        _body = HomePage();
        break;
      case 1:
        _body = ContentsPage();
        break;
      case 2:
        _body = ManabaPage();
        break;
      case 3:
        _body = SettingsPage();
        break;
      default:
        _body = Center(child: Text('ページが見つかりません'));
        break;
    }

    // Scaffoldで画面を構成します。
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0), // AppBarの高さを設定
        child: AppBar(
          backgroundColor: Colors.white, // AppBarの背景色を白に設定
          iconTheme: IconThemeData(color: Colors.black54), // アイコンの色を設定
          elevation: 0, // AppBarの影をなくす
        ),
      ),
      body: _body,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 16), // ナビゲーションバーの下に10の余白を追加
        child: CurvedNavigationBar(
          index: _currentIndex,
          height: 60,
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.widgets, size: 30),
            Icon(Icons.school, size: 30),
            Icon(Icons.settings, size: 30),
          ],
          color: Colors.white, // ナビゲーションバーの背景色
          backgroundColor: Colors.white,
          buttonBackgroundColor: Colors.white, // タブボタンの背景色
          animationDuration: Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setupFirebaseMessaging();
  }

  void setupFirebaseMessaging() async {
    await Firebase.initializeApp();

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // アプリがフォアグラウンドにあるときにプッシュ通知を受信した場合の処理
      print('Message received: ${message.notification?.body}');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // ユーザーがプッシュ通知をタップしてアプリを開いた場合の処理
      print('Message clicked!');
    });
  }
}
