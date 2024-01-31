//インポートしたものは、pubspec.yamlに記載する必要があります。
//記載した後はターミナルでflutter pub getを実行してください。
import 'package:flutter/material.dart'; // Flutterのマテリアルデザインウィジェットをインポートします。

import 'setting_page.dart'; // settingファイルをインポート
import 'contets_page.dart'; // contetsファイルをインポート
import 'home_page.dart'; // homeファイルをインポート
import 'manaba_page.dart'; // manabaファイルをインポート

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
  //bool _isLoading = true;
  int _currentIndex = 0; //デフォルトのインデックスをトップページに設定します。

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
      // 上部のバー
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black54),
          elevation: 0,
        ),
      ),

      //ボディ
      body: _body,

      // 下部のバー
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed, //これを設定するとタブが選択された時にアニメーションしなくなる。
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        // 下部のバーの詳細を設定します。
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'コンテンツ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'manaba',
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
