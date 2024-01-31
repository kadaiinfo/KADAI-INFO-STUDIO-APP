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
          elevation: 0, // AppBarの影をなくす
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // コンテンツに余白を付ける
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 左揃え
          children: [
            Row(
              children: [
                Icon(
                  Icons.widgets, // アイコンの設定
                  size: 48.0, // アイコンのサイズ
                  color: Colors.grey, // アイコンの色
                ),
                SizedBox(width: 8.0), // アイコンとテキストの間のスペース
                Text(
                  'Contents 1', // 表示するテキスト
                  style: TextStyle(
                    fontSize: 16.0, // テキストのサイズ
                    color: Colors.black54, // テキストの色
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.0), // アイテム間のスペース

            Row(
              children: [
                Icon(
                  Icons.widgets,
                  size: 48.0,
                  color: Colors.grey,
                ),
                SizedBox(width: 8.0),
                Text(
                  'Contents 2',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.0),

            Row(
              children: [
                Icon(
                  Icons.widgets,
                  size: 48.0,
                  color: Colors.grey,
                ),
                SizedBox(width: 8.0),
                Text(
                  'Contents 3',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.0),

            Row(
              children: [
                Icon(
                  Icons.widgets,
                  size: 48.0,
                  color: Colors.grey,
                ),
                SizedBox(width: 8.0),
                Text(
                  'Contents 4',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.0),
            Row(
              children: [
                Icon(
                  Icons.widgets,
                  size: 48.0,
                  color: Colors.grey,
                ),
                SizedBox(width: 8.0),
                Text(
                  'Contents 5',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.0),

            // ここに将来的に他のコンテンツを追加する
          ],
        ),
      ),
    );
  }
}
