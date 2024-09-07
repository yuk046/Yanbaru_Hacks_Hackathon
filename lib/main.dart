import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:munimuniohagi/Pages/akinatorPage.dart';
import 'package:munimuniohagi/Pages/iventListPage.dart';
import 'package:munimuniohagi/Pages/start.dart';
import 'package:munimuniohagi/Pages/userpage.dart';
import 'package:munimuniohagi/firebase_options.dart';
import 'package:munimuniohagi/Pages/gemini.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Firebaseを初期化
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Either of エイサー',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

        // フォントの設定
        fontFamily: 'dotGothic16',
      ),
      home: const StartPage(),
    );
  }
}

class HomePage extends HookWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // BottomNavigationBarのインデックスをuseStateで管理
    final _selectedIndex = useState(0);

    // 画面のサイズを取得
    final screenSize = MediaQuery.of(context).size;

    // 画面幅に基づいてパディングを計算
    final double bottomPadding = screenSize.height * 0.03; // 画面高さの3%
    final double horizontalPadding = screenSize.width * 0.05; // 画面幅の5%
    final double iconTopPadding = 10; // アイコンの上に追加するパディング

    // 各タブに表示するページのリスト
    final List<Widget> _pages = <Widget>[
      const AkinatorPage(),
      const EventListPage(),
      const userPage()
    ];

    // タブが選択された時にインデックスを更新するメソッド
    void _onItemTapped(int index) {
      _selectedIndex.value = index;
    }

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _selectedIndex.value,
        children: _pages,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: bottomPadding,
          left: horizontalPadding,
          right: horizontalPadding,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffE2C6FF), // 背景色
            borderRadius: BorderRadius.circular(30), // 角を丸く
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // 影の色
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 3), // 影の位置
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex.value,
            onTap: _onItemTapped,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: iconTopPadding),
                  child: Icon(Icons.home, size: 30),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: iconTopPadding),
                  child: Icon(Icons.push_pin, size: 30),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: iconTopPadding),
                  child: Icon(Icons.person, size: 30),
                ),
                label: '',
              ),
            ],
            type: BottomNavigationBarType.fixed, // shifting を使用しない
            backgroundColor: Colors.transparent, // 内部の背景を透明に
            elevation: 0, // 標準の影を無効化
            selectedItemColor: Colors.black,
            iconSize: 30,
          ),
        ),
      ),
    );
  }
}
