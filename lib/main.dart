import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//https://codelabs.developers.google.com/codelabs/flutter-codelab-first?hl=ko#4
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green), //전체적인 앱 색이 이걸로 적용되게 됩니다. 
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

  var favorites = <WordPair>[]; //like 버튼을 누르면 좋아요. 제네릭을 사용하여 단어 쌍만 포함될 수 있도록 지정. 

  void toggleFavorite() { //like 목록에서 현재 단어 쌍을 삭제하거나(이미있으니깐), 추가하는 경우(없어니깐 else)
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //y축 중앙에 위치
          children: [
            SizedBox(height: 10),
            BigCard(pair : pair), // Text(pair.asLowerCase) 인데 text 에  ctrl + .  해서 
            //Text(pair.asPascalCase),
            //Text(pair.asLowerCase),
             ElevatedButton(
              onPressed: () {
                appState.getNext();  // ← This instead of print().
              },
              child: Text('Next'),
            ),
          ],
        ),
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
    final style = theme.textTheme.displayMedium!.copyWith( //heme.textTheme,을 사용하여 앱의 글꼴 테마에 액세스, bodyMedium(중간 크기의 표준 텍스트용) 또는 caption(이미지 설명용), headlineLarge(큰 헤드라인용) 등의 멤버가 포함
                  //displayMedium 속성은 디스플레이 텍스트를 위한 큰 스타일
                  //테마의 displayMedium 속성은 이론적으로 null일 수 있음. 근데 dart는 null 이 될 수 있는 객체의 메소드 호출x
                  //따라서 ! 연산자('bang연산자')를 사용하여 개발자가 dart에게 인지하고 있음을 알려줌.
      color: theme.colorScheme.onPrimary

    );
    return Card( //return Padding에서 Refactor메뉴를 불러와 Wrap with widget 선택, 이러면 상위 위젯 지정 가능
      color: theme.colorScheme.primary, //primary가 앱을 정의하는 가장 두드러진 색상
      child: Padding(
        padding: const EdgeInsets.all(20.0), //Flutter는 가능한 경우 상속 대신 컴포지션을 사용. 여기서 패딩은 Text의 속성이 아니라 위젯.
        //child: Text(pair.asLowerCase, style: style,),
        child: Text(
          pair.asPascalCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
