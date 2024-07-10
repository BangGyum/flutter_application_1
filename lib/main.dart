import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Android Studio에서 sdk 를 설치하고, 거기서 에뮬을 만들고 와서 여기서 사용
// 버전은 한국에서 대부분 안드로이드 10 이상을 사용중이므로 10으로 잡음
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold( //앱 디자인을 머리 가슴 배로 나뉜 위젯 , appBar, body, bottomNavigationBar
    //여기서 ctrl space 같이 누르면 무엇을 사용할 수 있는지 확인 가능
    appBar: AppBar( title: Text("연습중")),
      body: Column(
        children: [
          Text('A random AWESOME Best Best idea:'),
          Text(appState.current.asLowerCase),
           ElevatedButton(
            onPressed: () {
              print('button pressed!');
            },
            child: Text('Next'),
          ),
        ],
      ),
    bottomNavigationBar: BottomAppBar( child: Text('배') ),
    );
  }
}