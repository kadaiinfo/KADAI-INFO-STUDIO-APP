//パッケージはpubspec.yamlに記述することでインポートできるようになります。
import 'package:flutter/material.dart';
//これはボトムナビゲーションバーをカスタマイズするためのパッケージです。
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

//以下ようにしてファイルをインポートできます。
//mainが長くなったら別ファイルに切り分けて開発していくのがいいです。
import 'home_page.dart'; //トップぺージのファイルをインポート
import 'manaba_page.dart'; //manabaページのファイルをインポート
import 'contents_page.dart'; //コンテンツページのファイルをインポート
import 'setting_page.dart'; //設定ページのファイルをインポート

//ここはFlutterのおまじないです。
//main関数はアプリのエントリーポイントです。
//ここからアプリが始まります。
void main() {
  runApp(MyApp());
}

//ここもFlutterのおまじないです。
//MyAppクラスはアプリのルートとなるクラスです。
//StatelessWidgetを継承したクラスで、
//MaterialAppウィジェットを返すbuildメソッドを持っています。
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      home: MainNavigationScreen(),
    );
  }
}

//ここもFlutterのおまじないです。
//StatefulWidgetを継承したMainNavigationScreenクラスを作成します。
//_MainNavigationScreenState() は _MainNavigationScreenState クラスの新しいインスタンスを作成します。
//このクラスは MainNavigationScreen ウィジェットの状態を管理します。
class MainNavigationScreen extends StatefulWidget {
  MainNavigationScreen({Key? key}) : super(key: key); // keyパラメータを追加

  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

//このクラスはアプリケーションのメインナビゲーションを管理し、
//ナビゲーションバーを使って異なるページ（HomePage、ContentsPage、ManabaPage、SettingsPage）に切り替えることができます。
class _MainNavigationScreenState extends State<MainNavigationScreen> {
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
        padding: EdgeInsets.only(bottom: 16), // ナビゲーションバーの下に16の余白を追加
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
}
