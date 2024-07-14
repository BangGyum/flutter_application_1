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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier { //MyAppState 클래스는 앱의 상태를 정의
            //Flutter에는 앱 상태를 관리하는 여러 강력한 방법이 존재
            // 설명하기 쉬운 것 중 하나가 현재 위에서 extends한 ChangeNotifier
            //                      -SomeWidget
            //   MyApp - MyHomPage    
            //                      -OtherWidget
  var current = WordPair.random(); //앱이 작동하는 데 필요한 데이터를 정의

  void getNext() {
    current = WordPair.random(); //임의의 새 WordPair를 current에 재할당. 랜덤 단어 2개짝을 뱉음
    notifyListeners();
  }

}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) { //모든 위젯은 위젯이 하상 최신 상태로 유지되도록 
                            //위젯의 상황이 변경될 때마다 자동으로 호출되는 build() 메서드를 정의
    var appState = context.watch<MyAppState>(); //MyHomePage는 watch 메소드를 사용하여 앱의 현재 상태에 관한 변경사항을 추적
    var pair = appState.current;  
    return Scaffold(  //모든 build 메소드는 위젯 or 중첩된 위젯 트리를 반환해야 합니다. Scaffold는 여기서 최상위 위젯.
      //앱 디자인을 머리 가슴 배로 나뉜 위젯 , appBar, body, bottomNavigationBar
    //여기서 ctrl space 같이 누르면 무엇을 사용할 수 있는지 확인 가능
    appBar: AppBar( title: Text("연습중")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              appState.getNext();  // ← This instead of print().
            },
            child: Text('randomTwoWord'),
          ),
          Text('A random AWESOME Best Best idea:'),
          BigCard(pair: pair), // Text(pair.asLowerCase) 인데 text 에  ctrl + .  해서 
          //Text(pair.asLowerCase),
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

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);  //현재 위젯의 BuildContext를 나타냄. 이 BuildContext를 사용하여 Theme.of(context)를 호출.
    return Card( //return Padding에서 Refactor메뉴를 불러와 Wrap with widget 선택, 이러면 상위 위젯 지정 가능
      color: theme.colorScheme.primary, //primary가 앱을 정의하는 가장 두드러진 색상
      child: Padding(
        padding: const EdgeInsets.all(20.0), //Flutter는 가능한 경우 상속 대신 컴포지션을 사용. 여기서 패딩은 Text의 속성이 아니라 위젯.
        child: Text(pair.asLowerCase),
      ),
    );
  }
}
