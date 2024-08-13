import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:solquiz_2/board.dart';
import 'package:solquiz_2/login.dart';
import 'package:solquiz_2/money.dart';
import 'package:solquiz_2/myPage.dart';
import 'package:solquiz_2/navigationBar.dart';
import 'package:solquiz_2/predict_more.dart';
import 'package:solquiz_2/recruit.dart';
import 'package:solquiz_2/mainPage.dart';
import 'package:solquiz_2/recruit_more.dart';
import 'package:solquiz_2/search.dart';
import 'package:solquiz_2/search2.dart';
import 'package:solquiz_2/solarplant_addr.dart';
import 'package:solquiz_2/solarplant_name.dart';

import 'changePw.dart';
import 'db/heewonapp.dart';
import 'join.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      // 라우트 연결
      routes: {
        '/recruitmore' : (context) => RecruitMore(),
        '/money' : (context) => Money(),
        '/predictmore' : (context) => PredictMore(),
        '/search2' : (context) => Search2(),
      },
      debugShowCheckedModeBanner: false,

      home: Login(),
      // home: DataFetcher(sqlQuery: "SELECT * FROM TB_MEMBER where MEM_pw = '1234'",),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),*/
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}