// その他ページの管理をここで行います。
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0), // AppBarの高さを設定
        child: AppBar(
          backgroundColor: Colors.white, // AppBarの背景色を白に設定
          iconTheme: IconThemeData(color: Colors.black54), // アイコンの色を設定
          elevation: 0, // AppBarの影をなくす
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [],
          ),
        ),
      ),
      body: SettingsList(
        sections: [
          // SettingsSection(
          //   title: const Text('一般'),
          //   tiles: [
          //     SettingsTile(
          //       title: const Text('通知'),
          //       leading: const Icon(Icons.notifications_active_outlined),
          //       trailing: const Icon(Icons.navigate_next),
          //       onPressed: (BuildContext context) {
          //         // 通知設定ページへの遷移などの処理をここに書く
          //       },
          //     ),
          //   ],
          // ),
          SettingsSection(
            title: const Text('このアプリについて'),
            tiles: [
              SettingsTile(
                title: const Text('KADAI INFOについて'),
                trailing: const Icon(Icons.launch),
                onPressed: (BuildContext context) async {
                  const url = 'https://kadaiinfo.com/about-us';
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
              ),
              SettingsTile(
                title: const Text('お問い合わせ'),
                trailing: const Icon(Icons.launch),
                onPressed: (BuildContext context) async {
                  const url = 'https://kadaiinfo.com/contact';
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
              ),
              SettingsTile(
                title: const Text('利用規約'),
                trailing: const Icon(Icons.launch),
                onPressed: (BuildContext context) async {
                  const url = 'https://kadaiinfo.com/privacy-policy';
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 今後、FCMの通知権限をリクエストする関数
  // void requestNotificationPermissions() async {
  //   final messaging = FirebaseMessaging.instance;
  //   await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );
  // }
}
