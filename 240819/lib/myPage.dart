import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:solquiz_2/db/member.dart';
import 'package:solquiz_2/db/tb_member.dart';
import 'package:solquiz_2/profileEdit.dart';
import 'package:http/http.dart' as http;
import 'package:solquiz_2/recruit_more.dart';
import 'package:solquiz_2/solarplant_name.dart';
import 'dart:convert';

import 'appbar.dart';
import 'db/tb_solar_board.dart';
import 'db/tb_solar_comment.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  final storage = FlutterSecureStorage();
  dynamic userInfo = ''; // storage에 있는 유저 정보를 저장
  double powersum = 0;
  int idx = 0;
  String str = '';
  int recruitIdx = 0;

  checkUserState() async {
    userInfo = await storage.read(key: 'login');
    print('checkUserState 함수 : '+ userInfo);
    userInfo = json.decode(userInfo);
    print('checkUserState 함수 안의 아이디 : '+ userInfo["id"]);
    if (userInfo == null) {
      print('로그인 페이지로 이동');
      Navigator.pushNamed(context, '/login'); // 로그인 페이지로 이동
    } else {
      print('로그인 중');
      _sendQuery();
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
  var idxList = [];


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUserState();
    });
    _b_state();
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
            print(_member);
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
    _recruit_more();
  }

  // 참여현황 리스트 띄우기 + percent를 띄워보자
  final String _url2 = 'http://10.0.2.2:3000/recruit/myrecruit';
  List<RecruitComment> _recruitcomment = [];
  List<RecruitMore> RecruitmoreList = <RecruitMore>[];
  List<String?> BstateList = [];

  Future<void> _recruit_more() async {
    // print('꼬부기 ' + '${idx}');
    try {
      final response2 = await http.post(Uri.parse(_url2),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'userInfo' : userInfo})
      );

      if (response2.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response2.body);
        print("브케인");

        if (jsonResponse is Map<String, dynamic>) {
          // 단일 객체인 경우
          final recruitcomment = RecruitComment.fromJson(jsonResponse);
          setState(() {
            _recruitcomment = [recruitcomment];
            print('단일 객체인 경우 ${_recruitcomment[0]}');

            print('리자몽 ' + _recruitcomment[0].PLANT_POWER.toString());
            print('리자몽 ' + _recruitcomment[0].PLANT_POWER.runtimeType.toString());

            List<int> powerList = _recruitcomment[0].PLANT_POWER.map((e) => int.parse(e!)).toList();
            powerList.forEach((e) => powersum += e);
            print('피카츄 ' + ' $powerList');
            print('가디' + powersum.toString());

            idxList = List<int>.generate(_recruitcomment[0].PLANT_POWER.length, (i) => i++);
            print('잠만보 ${idxList}');
            print('메타몽 ${idxList[0].runtimeType}');
            print('브이젤 ${_recruitcomment[0]}');
            // print('쉐이미' + _recruitcomment[0].);

            print('피츄' + _recruitcomment[0].B_STATE.toString());
            BstateList =  _recruitcomment[0].B_STATE;
            print('피카츄' + BstateList.toString());
          });
        } else if (jsonResponse is List) {
          // 배열인 경우
          final recruitcomment = jsonResponse.map((data) {
            if (data is Map<String, dynamic>) {
              return RecruitComment.fromJson(data);
            } else {
              return null; // 데이터가 올바른 형식이 아닌 경우
            }
          }).whereType<RecruitComment>().toList();

          setState(() {
            _recruitcomment = recruitcomment;
            print('_recruitcomment을 뽑아보자 ${_recruitcomment}');
            print('_recruitcomment[0]을 뽑아보자 ${_recruitcomment[0]}');
          });
        }
      }
    } catch (e) {
      print(e);
    }
    _b_state();
  }

  final String _url3 = 'http://10.0.2.2:3000/mypage/bstate';
  List<dynamic> _recruitboard2 = [];
  dynamic sp_state = '';

  // 발전소 모집 현황 모집 마감 버튼
  Future<void> _b_state() async {
    try {
      final response3 = await http.post(Uri.parse(_url3),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'userInfo' : userInfo})
      );

      if (response3.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response3.body);
        print('폼폼푸린' + jsonResponse.toString());
        print('폼폼푸린폼폼' + jsonResponse.runtimeType.toString());

        print('마이멜로디' + jsonResponse['b_state'].toString());
        print('마이멜로디' + jsonResponse['b_state'].runtimeType.toString());
        setState(() {
          sp_state = jsonResponse['b_state'][0];
          print('파치리스' + sp_state);
        });
      }
    } catch (e) {
      print('여기는 안돼 '+ e.toString());
    }
  }

  // 모집마감 버튼 상태 바꾸기
  final String _url4 = 'http://10.0.2.2:3000/mypage/bchange';
  Future<void> _change_sta() async {
    try {
      final response4 = await http.post(Uri.parse(_url4),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'userInfo' : userInfo})
      );

      if (response4.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response4.body);
        print("꼬부기 연결 성공");

        if (jsonResponse == 'success') {
          print('모집마감 버튼 통신 - ' + jsonResponse);
          _b_state();

        } else if (jsonResponse == 'failed') {
          print("모집마감 버튼 통신 response : " + jsonResponse);
          print('모집마감 버튼 실패');
        }
      }
    } catch (e) {
      print('여기는 안돼 '+ e.toString());
    }
  }

  // 승인 완료 버튼
  final String _url5 = 'http://10.0.2.2:3000/mypage/mypagewait';
  Future<void> _change_wait(int a) async {
    print('님피아' + a.toString());
    userInfo = await storage.read(key: 'login');
    print('님피아 : '+ userInfo);
    userInfo = json.decode(userInfo);

    try {
      final response4 = await http.post(Uri.parse(_url5),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'idx' : a, 'userInfo' : userInfo})
      );

      if (response4.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response4.body);
        print("터검니 연결 성공");

        if (jsonResponse == 'success') {
          print('승인 대기 버튼 통신 - ' + jsonResponse);
          _recruit_more();

        } else if (jsonResponse == 'failed') {
          print("승인 대기 통신 response : " + jsonResponse);
          print('승인 대기 버튼 실패');
        }
      }
    } catch (e) {
      print('여기는 안돼 '+ e.toString());
    }
    // _recruit_more();
  }

  // 발전소 모집 현황에서 모집글로 이동
  final String _url6 = 'http://10.0.2.2:3000/mypage/mypagerecruit';

  Future<void> _my_recruit_more() async {
    print('마이페이지 모집글 상세 페이지로 이동');
    try {
      final response6 = await http.post(Uri.parse(_url6),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'userInfo' : userInfo})
      );
      print('마릴리' + userInfo.toString());

      if (response6.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response6.body);
        print("토게피 연결 성공");
        print('깜지곰' + jsonResponse.toString());
        setState(() {
          recruitIdx = (int.parse(jsonResponse))- 1;
          print(recruitIdx);
        });
        if (jsonResponse == 'success') {
          print('승인 대기 버튼 통신 - ' + jsonResponse);

        } else if (jsonResponse == 'failed') {
          print("승인 대기 통신 response : " + jsonResponse);
          print('승인 대기 버튼 실패');
        }
      }
    } catch (e) {
      print('여기는 안돼 6'+ e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Appbar(),
          ),
          body: _error.isNotEmpty
              ? Center(child: Text(_error),)
              : _member.isEmpty
              ? Center(child: CircularProgressIndicator(
            color: Colors.white,
          ))
              : Center(
                child: SingleChildScrollView(
                  child : Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1.5,
                          blurRadius: 5,
                          offset: Offset(0, 3), // 그림자 위치 변경
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  ClipRRect(
                                    child: Image.asset(
                                      'image/moomin9.jpg',
                                      width: 50,
                                      height: 50,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(80)),
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(width: 5
                                            ,),
                                          Text(
                                            '${_member[0].MEM_NAME[0]}',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${_member[0].MEM_EMAIL[0]}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(width: 80,),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => profileEdit()),
                                );
                              },
                              child: Text(
                                '정보 수정',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                // alignment: Alignment(x, y),
                                backgroundColor: Colors.grey[400],
                                minimumSize: Size(17, 10),
                                // fixedSize: Size(30, 7),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 13, vertical: 7),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1.5,
                          blurRadius: 5,
                          offset: Offset(0, 3), // 그림자 위치 변경
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('발전소 관리', style: TextStyle(fontSize: 18, color: Colors.black54,),),
                        SizedBox(height: 8,),
                        Row(
                          children: [
                            SizedBox(width: 8,),
                            TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                              ),
                              onPressed: (){
                                Navigator.pushNamed(
                                    context,
                                    '/solarplantname',
                                    arguments: _member[0].MEM_NAME[0]
                                );
                              } ,
                              child: Text('내 발전소 등록',
                                style: TextStyle(fontSize: 18, color: Colors.black),),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 8,),
                            TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                              ),
                              onPressed: (){} ,
                              child: Text('내 발전소'
                                  ' 정보 수정하기',
                                style: TextStyle(fontSize: 18, color: Colors.black),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1.5,
                          blurRadius: 5,
                          offset: Offset(0, 3), // 그림자 위치 변경
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('발전소 모집 현황', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
                            SizedBox(width: 50,),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: sp_state == 'ing' ? Color(0xffff9201) : Colors.grey,
                                  minimumSize: Size(12, 10),
                                  padding: EdgeInsets.symmetric(horizontal: 13,vertical: 7),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text('모집 마감',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () => {_change_sta()}
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward_ios_outlined),
                              style: ButtonStyle(
                                iconColor: MaterialStateProperty.all<Color>(Colors.black),
                              ),
                              onPressed: (){
                                _my_recruit_more();
                                print('파오리' + recruitIdx.toString());
                                Navigator.pushNamed(
                                    context, '/recruitmore',
                                    arguments: recruitIdx);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 8,),
                        Row(
                          children: [
                            SizedBox(width: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('목표 : 20㎿h', style: TextStyle(fontSize: 19,),),
                                SizedBox(width: 160,),
                                Text('${((powersum/20)*100).toStringAsFixed(1)}%', style: TextStyle(fontSize: 19,),),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Container(width: double.infinity, height: 1, color: Colors.grey[300],),
                        SizedBox(height: 10,),
                        for (index in idxList) Container(
                                      margin: EdgeInsets.all(3),
                                      height: 30,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('${index +1}. ${_recruitcomment[0].PLACE[index]} · ${_recruitcomment[0].SB_TYPE[index]! == 'Inland'? '내륙' : '해안'} · ${_recruitcomment[0].PLANT_POWER[index]}MWh'
                                            , style: TextStyle(fontSize: 16),),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: BstateList[index] == 'wait'? Color(0xffff9201) : Colors.grey[400],
                                                minimumSize: Size(12, 10),
                                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                              ),
                                              child: Text(BstateList[index] == 'wait'? '승인 대기' : '승인 완료',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),

                                              ),onPressed: () => {
                                                  setState(() {
                                                    idx = index +1;
                                                    print('$idx');
                                                    _change_wait(idx);
                                                  })
                                              }
                                          ),
                                        ],
                                      ),
                          ),
                      ],
                    ),
                  ),
                ],
                            ),
                          ),
              )
      ),
    );
  }
}