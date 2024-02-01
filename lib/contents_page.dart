import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContentsPage extends StatelessWidget {
  final String ContentsUrl = 'https://kadaiinfo.com/contents';

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: ContentsUrl,
      javascriptMode: JavascriptMode.unrestricted,
      // ... その他のWebView設定
    );
  }
}


// class ContentsPage extends StatelessWidget {
//   const ContentsPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // デバイスの横幅に基づいてサイズを計算
//     double width = MediaQuery.of(context).size.width / 3 - 4.0;
//     double width2 = MediaQuery.of(context).size.width / 2 - 4.0;

//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(0.0),
//         child: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//         ),
//       ),
//       body: SingleChildScrollView(
//         // SingleChildScrollViewを追加
//         child: Padding(
//           padding: const EdgeInsets.all(0.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Text(
//                     'CONTENTS',
//                     style: TextStyle(
//                       fontSize: 32.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   _buildIcon_long(context, 1, 'Contents 1', Colors.red, width2),
//                   _buildIcon_long(
//                       context, 2, 'Contents 2', Colors.blue, width2),
//                 ],
//               ),
//               SizedBox(height: 4.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   _buildIcon(context, 1, 'Contents 1', Colors.red, width),
//                   _buildIcon(context, 2, 'Contents 2', Colors.blue, width),
//                   _buildIcon(context, 3, 'Contents 3', Colors.green, width),
//                 ],
//               ),
//               SizedBox(height: 4.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   _buildIcon(context, 4, 'Contents 4', Colors.orange, width),
//                   _buildIcon(context, 5, 'Contents 5', Colors.purple, width),
//                   _buildIcon(context, 6, 'Contents 6', Colors.blue, width),
//                 ],
//               ),
//               SizedBox(height: 4.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   _buildIcon(context, 7, 'Contents 7', Colors.orange, width),
//                   _buildIcon(context, 8, 'Contents 8', Colors.purple, width),
//                   _buildIcon(context, 9, 'Contents 9', Colors.blue, width),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildIcon(BuildContext context, int index, String label, Color color,
//       double width) {
//     return GestureDetector(
//       onTap: () => _onIconTapped(context, index),
//       child: Container(
//         width: width,
//         height: width,
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(24.0),
//         ),
//         child: Center(
//           child: Text(
//             label,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 16.0,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildIcon_long(BuildContext context, int index, String label,
//       Color color, double width) {
//     return GestureDetector(
//       onTap: () => _onIconTapped(context, index),
//       child: Container(
//         width: width,
//         height: width * 2,
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(24.0),
//         ),
//         child: Center(
//           child: Text(
//             label,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 16.0,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _onIconTapped(BuildContext context, int index) {
//     // 各アイコンがタップされた時の処理
//     // 例: URLに飛ぶか、ページに遷移する
//     // launchURL('https://example.com/${index}'); // URLを開く場合
//     // Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(index: index))); // 新しいページに遷移する場合
//   }

//   void launchURL(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }
