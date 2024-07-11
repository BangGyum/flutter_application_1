import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Android Studio에서 sdk 를 설치하고, 거기서 에뮬을 만들고 와서 여기서 사용
// 버전은 한국에서 대부분 안드로이드 10 이상을 사용중이므로 10으로 잡음
void main() { //이 형식은 MyApp에서 정의된 앱을 실행하라고 flutter에 지시할 뿐
  runApp(MyApp());
}

class MyApp extends StatelessWidget { //MyApp은 StatelessWidget을 확장.
        //위젯은 모든 Flutter 앱을 빌드하는데 사용하는 요소. 앱 자체도 위젯이다.
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

class MyAppState extends ChangeNotifier { //MyAppState 클래스는 앱의 상태를 정의
            //Flutter에는 앱 상태를 관리하는 여러 강력한 방법이 존재
            // 설명하기 쉬운 것 중 하나는 ChangeNotifier
  var current = WordPair.random(); //앱이 작동하는 데 필요한 데이터를 정의
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