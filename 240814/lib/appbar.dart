import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'db/tb_member.dart';

class Appbar extends StatefulWidget {
  const Appbar({super.key});


  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {

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

  final String _url = 'http://10.0.2.2:3000/login/mypage'; // 서버 URL
  List<Member> _member = []; // Boards 객체 리스트
  String _error = '';
  var index = 0;


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
        padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('image/solQuiz_logo3.png', width: 110,),
              Container(
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.notifications),
                      style: ButtonStyle(
                        iconColor: MaterialStateProperty.all<Color>(Colors.black54),
                      ),
                      onPressed: () {
                        print('icon alert');
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.logout_outlined),
                      style: ButtonStyle(
                        iconColor: MaterialStateProperty.all<Color>(Colors.black54),
                      ),
                      onPressed: () {
                        print('icon logout');
                        logout();
                      },
                    ),
                  ],
                ),
              )
            ]
        ),
      ),
    );
  }
}