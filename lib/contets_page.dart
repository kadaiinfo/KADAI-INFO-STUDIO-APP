// コンテンツページの管理をここで行います。
//このページは、これから開発が発展していくことを想定して作成しています。
import 'package:flutter/material.dart';

class ContentsPage extends StatelessWidget {
  const ContentsPage({Key? key}) : super(key: key);

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
      body: Container(
        child: Center(
          child: Text('comming soon...'),
        ),
      ),
    );
  }
}
