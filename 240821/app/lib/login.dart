import 'package:flutter/material.dart';
import 'package:solquiz_2/join.dart';
import 'package:solquiz_2/navigationBar.dart';
import 'package:solquiz_2/search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'kakao.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final String _url = 'http://192.168.219.54:3000/login/loginpage'; // 서버 URL
  String _error = '';

  TextEditingController idCon = TextEditingController();
  TextEditingController pwCon = TextEditingController();

  final storage = FlutterSecureStorage();
  dynamic userInfo = ''; // storage에 있는 유저 정보를 저장

  @override
  void initState() {
    super.initState();

    // 비동기로 flutter secure storage 정보를 불러오는 작업
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    // 데이터가 없을때는 null을 반환
    userInfo = await storage.read(key:'login');

    // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어가게 합니다.
    if (userInfo != null) {
      print('로그인 _asyncMethod userInfo : ' + userInfo);


      Navigator.push(context, MaterialPageRoute(builder: (_) => Navigationbar()));
    } else {
      print('로그인이 필요합니다');
    }
  }


  Future<void> sendLoginData() async {
    String id = idCon.text.toString();
    String pw = pwCon.text.toString();

    print('id : ' + id);
    print('pw : ' + pw);

    try {
      final response = await http.post(Uri.parse(_url),
          headers : {'Content-Type': 'application/json'},
          body: json.encode({'id': id,'pw':pw}),
      );
      var val = jsonEncode({'id': id,'pw':pw});
      await storage.write(
        key: 'login',
        value: val
      );

      print('로그인 flutter secure storage 접속 성공!');

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        print("연결 성공");
        // print("통신 response : "+ jsonResponse);

        if (jsonResponse == 'success') {
          print(jsonResponse);
          _asyncMethod();

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Navigationbar()),
          );
        }else if (jsonResponse == 'failed'){
          print("통신 response : "+ jsonResponse);
          print('로그인 실패');
          showPopup('아이디와 비밀번호를 다시 확인해주세요');
        }
      }

    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                      child: Image.asset(
                    'image/solQuiz_logo2.png',
                    width: 300,
                    height: 300,
                  )),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextField(
                      controller: idCon,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:BorderSide(color:Color(0xFFA3A3A3))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xfffd9a06))),
                        labelText: 'ID 입력',
                        labelStyle: TextStyle(color: Color(0xFFA3A3A3)),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextField(
                      controller: pwCon,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:BorderSide(color:Color(0xFFA3A3A3))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xfffd9a06))),
                        labelText: 'PW 입력',
                        labelStyle: TextStyle(color: Color(0xFFA3A3A3)),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        minimumSize: Size(310, 42),
                        backgroundColor: Color(0xFFFF9201),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    onPressed: () {
                      sendLoginData();
                    },
                    child: Text('로그인',
                        style: TextStyle(fontSize: 17.5, color: Colors.white)),
                  ),
                  SizedBox(height: 12,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        minimumSize: Size(310, 42),
                        backgroundColor: Color(0xFFFF9201),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => Join()));
                    },
                    child: Text('회원가입',
                        style: TextStyle(fontSize: 17, color: Colors.white)),
                  ),
                  SizedBox(height: 12,),
                  GestureDetector(
                    // onTap: (){print('dd');},
                    onTap:(() {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => KakaoLoginWebView(),
                      ));
                    }),
                    child: Container(
                        child: Image.asset('image/kakao_login_large_wide.png', width: 313,)
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => Search()));
                      },
                          child: Text('아이디 찾기 | 비밀번호 찾기',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFFA3A3A3),
                                  decoration: TextDecoration.underline)))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void showPopup(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          // alignment: Alignment.bottomCenter,
          insetPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 25,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('아이디와 비밀번호를 다시 확인해주세요.', style: TextStyle(fontSize: 18,),),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
