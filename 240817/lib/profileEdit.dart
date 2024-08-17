import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:solquiz_2/changePw.dart';
import 'package:solquiz_2/db/tb_member.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class profileEdit extends StatefulWidget {
  const profileEdit({super.key});

  @override
  State<profileEdit> createState() => _profileEditState();
}

class _profileEditState extends State<profileEdit> {

  final String _url = 'http://10.0.2.2:3000/login/mypage'; // 서버 URL
  List<Member> _member = []; // Boards 객체 리스트
  String _error = '';
  var index = 0;

  final storage = FlutterSecureStorage();
  dynamic userInfo = '';

  @override
  void initState() {
    super.initState();
    _asyncMethod();

  }
  _asyncMethod() async {
    userInfo = await storage.read(key:'login');
    userInfo = json.decode(userInfo);

    print('미뇽' + userInfo.toString());
    print('신뇽' + userInfo.runtimeType.toString());
    print('망나뇽' + userInfo['id']);
    print('라이츄' + userInfo['id'].runtimeType.toString());

    if (userInfo != null) {
      print('마이페이지 정보수정 _asyncMethod userInfo : ' + userInfo.toString());
    }
    _sendQuery(); // 위젯에서 받은 SQL 쿼리를 사용합니다.
  }

  Future<void> _sendQuery() async {
    try {
      final response = await http.post(
          Uri.parse(_url),
          headers: {
            'Content-Type': 'application/json',
          },
          body : json.encode({'userInfo' : userInfo})
      );

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        print("마이페이지 연결 성공");
        print(jsonResponse);

        if (jsonResponse is Map<String, dynamic>) {
          // 단일 객체인 경우
          final member = Member.fromJson(jsonResponse);
          setState(() {
            _member = [member];
            print('토게피'+_member.toString());
          });
        } else if (jsonResponse is List) {
          // 배열인 경우
          final member = jsonResponse.map((data) {
            if (data is Map<String, dynamic>) {
              return Member.fromJson(data);
            } else {
              return null; // 데이터가 올바른 형식이 아닌 경우
            }
          }).whereType<Member>().toList();

          setState(() {
            _member = member;
            print(_member);
            print(_member[0]);
          });


        } else {
          setState(() {
            _error = 'Unexpected JSON format';
          });
        }
      } else {
        setState(() {
          _error = 'Failed to execute query';
        });
      }


    } catch (e) {
      setState(() {
        _error = 'Error: $e';
      });
    }
  }

  logout() async {
    await storage.delete(key: 'login');
    Navigator.pushNamed(context, '/login');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '내 정보',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 23,
            fontFamily: 'Abhaya Libre',
            fontWeight: FontWeight.w400,
            height: 0.07,
            letterSpacing: 0.40,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.white,
      ),
      body: _error.isNotEmpty
              ? Center(child: Text(_error),)
              : _member.isEmpty
              ? Container(
                color: Colors.white,
                child: Center(
                    child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
              )
          : Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
            child: Container(
              padding: EdgeInsets.fromLTRB(33, 0, 33,0),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: Column(
                  children:[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                    child: Text('이름', style: TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontFamily: 'Abhaya Libre',
                      fontWeight: FontWeight.w400,)
                    ),
                    ),
                      Container(
                        child: Text('${_member[0].MEM_NAME[0]}',style: TextStyle(
                         color: Color(0xFFA3A3A3),
                         fontSize: 20,
                          fontFamily: 'Abhaya Libre',
                          fontWeight: FontWeight.w400,
                        ),
                        ),
                      )
                    ],
                ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text('휴대폰 번호', style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontFamily: 'Abhaya Libre',
                            fontWeight: FontWeight.w400,)
                          ),
                        ),
                        Container(
                          child: Text('${_member[0].MEM_PHONE[0]}',style: TextStyle(
                            color: Color(0xFFA3A3A3),
                            fontSize: 20,
                            //fontFamily: 'Abhaya Libre',
                            fontWeight: FontWeight.w400,
                          ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text('이메일', style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontFamily: 'Abhaya Libre',
                            fontWeight: FontWeight.w400,)
                          ),
                        ),
                        Container(
                          child: Text('${_member[0].MEM_EMAIL[0]}',style: TextStyle(
                            color: Color(0xFFA3A3A3),
                            fontSize: 20,
                            //fontFamily: 'Abhaya Libre',
                            fontWeight: FontWeight.w400,
                          ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text('비밀번호 변경', style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontFamily: 'Abhaya Libre',
                            fontWeight: FontWeight.w400,)
                          ),
                        ),
                        IconButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_) => changePw()));
                        },
                            icon: Icon(Icons.keyboard_arrow_right, size: 30,),
                          style: IconButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text('계정 로그인', style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontFamily: 'Abhaya Libre',
                            fontWeight: FontWeight.w400,)
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Image.asset('image/kakao.png', width: 25,),
                              SizedBox(width: 7,),
                              Text('카카오톡 로그인',style: TextStyle(
                                color: Color(0xFFA3A3A3),
                                fontSize: 19,
                                //fontFamily: 'Abhaya Libre',
                                fontWeight: FontWeight.w400,
                              ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 350,),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(310, 42),
                        backgroundColor: Color(0xFFFF9201),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    onPressed: () {logout();},
                    child: Text('로그아웃',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  TextButton(
                      onPressed: () {
                        showPopup('탈퇴하시겠습니까?');
                      },
                      child: Text('회원탈퇴',
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFFA3A3A3),
                              decoration: TextDecoration.underline)))
                  ],
                  ),
              ),
                ),
      ),
    );
  }
  void showPopup(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)),
          backgroundColor: Colors.white,
          title: Text('알림'),
          content: Text(message, style: TextStyle(fontSize: 17),),
          actions: <Widget>[
            Container(
              width: 60,
              height: 40,
              child: TextButton(
                child: Text('네', style: TextStyle(color: Colors.white),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                    ),
                    backgroundColor: Color(0xfffd9a06)
                ),
              ),
            ),
            TextButton(
              child: Text('아니요'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                  foregroundColor: Color(0xFFA3A3A3)
              ),
            ),
          ],
        );
      },
    );
  }
}
