// 더보기 페이지들의 appbar
// 뒤로가기 버튼 추가된 버전!!

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'db/tb_member.dart';

class Appbar2 extends StatefulWidget {
  const Appbar2({super.key});


  @override
  State<Appbar2> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar2> {

  final storage = FlutterSecureStorage();
  dynamic userInfo = ''; // storage에 있는 유저 정보를 저장

  checkUserState() async {
    userInfo = await storage.read(key: 'login');
    print('checkUserState 함수 : ' + userInfo);
    userInfo = json.decode(userInfo);
    print('checkUserState 함수 안의 아이디 : ' + userInfo["id"]);
    if (userInfo == null) {
      print('로그인 페이지로 이동');
      Navigator.pushNamed(context, '/login'); // 로그인 페이지로 이동
    } else {
      print('로그인 중');
    }
  }

  // 로그아웃 함수
  logout() async {
    await storage.delete(key: 'login');
    Navigator.pushNamed(context, '/login');
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUserState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(onPressed: (){Navigator.pop(context);},
                        icon: Icon(Icons.arrow_back,),
                        style: ButtonStyle(
                          iconColor: MaterialStateProperty.all<Color>(Colors.black54),

                        ),),
                    Image.asset('image/solQuiz_logo3.png', width: 110,),
                  ],
                ),
              ),
              Container(
                child: IconButton(
                  icon: Icon(Icons.logout_outlined),
                  style: ButtonStyle(
                    iconColor: MaterialStateProperty.all<Color>(Colors.black54),
                  ),
                  onPressed: () {
                    print('icon logout');
                    logout();
                  },
                ),
              )
            ]
        ),
      ),
    );
  }
}