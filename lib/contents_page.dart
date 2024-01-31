// コンテンツページの管理をここで行います。
//このページは、これから開発が発展していくことを想定して作成しています。
import 'package:flutter/material.dart';

class ContentsPage extends StatelessWidget {
  const ContentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        // SingleChildScrollViewを追加
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(20, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: InkWell(
                  onTap: () => _onIconTapped(index + 1),
                  child: Row(
                    children: [
                      Icon(
                        Icons.widgets,
                        size: 48.0,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Contents ${index + 1}',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  void _onIconTapped(int index) {
    // ここに各アイコンがタップされた時の処理を書く
  }
}
