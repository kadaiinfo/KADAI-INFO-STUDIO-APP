import 'dart:convert';
import 'dart:io';

//パッケージはpubspec.yamlに記述することでインポートできるようになります。
import 'package:flutter/material.dart';
//これはボトムナビゲーションバーをカスタマイズするためのパッケージです。
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
//これはFirebaseのメッセージングを使うためのパッケージです。

//firebaseのパッケージです。
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//以下ようにしてファイルをインポートできます。
//mainが長くなったら別ファイルに切り分けて開発していくのがいいです。
import 'home_page.dart'; //トップぺージのファイルをインポート
import 'manaba_page.dart'; //manabaページのファイルをインポート
import 'contents_page.dart'; //コンテンツページのファイルをインポート
import 'setting_page.dart'; //設定ページのファイルをインポート
import 'firebase_options.dart'; //Firebaseの設定ファイルをインポート

//push通知のトークンを取得するために書き換えたので、もっと綺麗に書けるかもしれません。
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final messagingInstance = FirebaseMessaging.instance;
  final fcmToken = await messagingInstance.getToken();
  debugPrint('FCM TOKEN: $fcmToken');

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await _initializePlatformSpecifics(
      flutterLocalNotificationsPlugin, messagingInstance);
  _setupForegroundNotificationHandling(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

//ここら辺は通知関連のメソッド
Future<void> _initializePlatformSpecifics(
    FlutterLocalNotificationsPlugin notificationsPlugin,
    FirebaseMessaging messagingInstance) async {
  if (Platform.isIOS) {
    await messagingInstance.requestPermission();
    await messagingInstance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
  } else {
    const androidChannel = AndroidNotificationChannel(
      'default_notification_channel',
      'プッシュ通知のチャンネル名',
      importance: Importance.max,
    );
    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }
}

void _setupForegroundNotificationHandling(
    FlutterLocalNotificationsPlugin notificationsPlugin) {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    final notification = message.notification;
    final android = message.notification?.android;

    if (Platform.isAndroid) {
      await notificationsPlugin.show(
        0,
        notification!.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'default_notification_channel',
            'プッシュ通知のチャンネル名',
            importance: Importance.max,
            icon: android?.smallIcon,
          ),
        ),
        payload: json.encode(message.data),
      );
    }
  });

  notificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    ),
    onDidReceiveNotificationResponse: (NotificationResponse details) {
      final payload = details.payload;
      if (payload != null) {
        final payloadMap = json.decode(payload) as Map<String, dynamic>;
        debugPrint(payloadMap.toString());
      }
    },
  );
}

//ここからがアプリのメイン部分です。

////ここもFlutterのおまじないです。
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
//_MainNavigationScreenState() は _MainNavigationScreenState クラスのインスタンスを作成します。
//このクラスは MainNavigationScreen ウィジェットの状態を管理します。
class MainNavigationScreen extends StatefulWidget {
  MainNavigationScreen({Key? key}) : super(key: key);

  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

//このクラスはアプリケーションのメインナビゲーションを管理し、
//ナビゲーションバーを使って異なるページ（HomePage、ContentsPage、ManabaPage、SettingsPage）に切り替えることができます。
class _MainNavigationScreenState extends State<MainNavigationScreen> {
  //初期ページのインデックスを定義します。この変数がこのページの要です。
  //_をつけるのは、プライベート変数であることを示すためです。
  int _currentIndex = 0;

  //0: HomePage
  //1: ContentsPage
  //2: ManabaPage
  //3: SettingsPage

  @override
  Widget build(BuildContext context) {
    Widget _body;

    // インデックスによって_bodyを切り替えられるようにswitch文にします
    // if文でもいいですが、switch文の方が見やすいです。
    //_bodyとするのは、_bodyが変数で、bodyがScaffoldのプロパティだからです。
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
      //エラーハンドリング
      default:
        _body = Center(child: Text('ページが見つかりません'));
        break;
    }

    // Scaffoldで画面を構成します。
    //3つの構造から成り立っています。
    return Scaffold(
      backgroundColor: Colors.white,

      //上部のバーの設定
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0), // AppBarの高さを設定
        child: AppBar(
          backgroundColor: Colors.white, // AppBarの背景色を白に設定
          iconTheme: IconThemeData(color: Colors.black54), // アイコンの色を設定
          elevation: 0, // AppBarの影をなくす
        ),
      ),

      //bodyプロパティに_bodyを設定
      body: _body,

      //下部のバーの設定
      bottomNavigationBar: Padding(
        //デザイン部分
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

          //処理部分
          //アイコンをタップしたときの処理
          onTap: (index) {
            setState(() {
              //タップしたインデックスを_currentIndexに代入することで、_bodyを切り替える
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
