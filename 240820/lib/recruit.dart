import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:solquiz_2/appbar.dart';
import 'package:solquiz_2/recruit_more.dart';

import 'db/tb_solar_board.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'db/tb_solar_comment.dart';

class Recruit extends StatefulWidget {
  const Recruit({super.key});

  @override
  State<Recruit> createState() => _RecruitState();
}


class _RecruitState extends State<Recruit> {

  final storage = FlutterSecureStorage();
  dynamic userInfo = ''; // storage에 있는 유저 정보를 저장

  // -------------------------------------------------------------
  // 1. storage 안에 있는 로그인 정보 받아오기 : _asyncMethod()
  final String _url = 'http://192.168.219.54:3000/recruitsql/bselect';

  // 2. 모집글 추가 함수 : addRecruit()
  final String _url2 = 'http://192.168.219.54:3000/recruitsql/addrecruit';

  // 3. 참여현황 percent를 띄워야 한다 : _recruit_more()
  final String _url3 = 'http://192.168.219.54:3000/recruit/recruitmore';
  //---------------------------------------------------------
  List<RecruitBoards> _recruit_boards = []; // Boards 객체 리스트
  String _error = '';
  var index = 0;
  List<int> idxList = [];
  List<int> idxList2 = [];

  get percentList => {};
  var powerList = [0];
  var powersumList = {};


  @override
  void initState() {
    super.initState();
    _asyncMethod(); // storage 안에 있는 로그인 정보 받아오기
  }

  Future<void> _sendQuery() async {
    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        dynamic jsonResponse = '';
        jsonResponse = json.decode(response.body);

        if (jsonResponse is Map<String, dynamic>) {
          // 단일 객체인 경우
          final recruit_boards = RecruitBoards.fromJson(jsonResponse);

          setState(() {
            _recruit_boards = [recruit_boards];
            print('_recruit_boards :  ${_recruit_boards}');

            idxList = List<int>.generate(_recruit_boards[0].MEM_ID.length, (i) => i++);
            idxList2 = idxList;
            print('idxList 생성 ${idxList}');

          });
        } else if (jsonResponse is List) {
          // 배열인 경우
          final recruit_boards = jsonResponse.map((data) {
            if (data is Map<String, dynamic>) {
              return RecruitBoards.fromJson(data);
            } else {
              return null; // 데이터가 올바른 형식이 아닌 경우
            }
          }).whereType<RecruitBoards>().toList();

          setState(() {
            _recruit_boards = recruit_boards;
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
    _recruit_more(); // 참여현황 리스트 받아오기
  }

  _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    // 데이터가 없을때는 null을 반환
    userInfo = await storage.read(key: 'login');
    userInfo = json.decode(userInfo);

    if (userInfo != null) {
      print('모집 게시판 userInfo : ' + userInfo.toString());
    } else {
      print('로그인이 필요합니다');
    }
    _sendQuery(); // 위젯에서 받은 SQL 쿼리를 사용합니다.
  }

  late final double percent;
  var re_idx = 0;

  // 참여현황 percent를 띄워야 한다
  // final String _url3 = 'http://10.0.2.2:3000/recruit/recruitmore';
  List<RecruitComment> _recruitcomment = [];
  final List<RecruitMore> RecruitmoreList = <RecruitMore>[];

  Future<void> _recruit_more() async {

    Iterable<int> commentList = [0];
    commentList = idxList.map((e) => e);

    Map<String, dynamic> power_map = {};

    for (int i = 0; i < idxList.length; i++) {
      // print('${i}');

      try {
        final response2 = await http.post(Uri.parse(_url3),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({'idx': i.toString()})
        );

        if (response2.statusCode == 200) {
          dynamic jsonResponse = '';
          jsonResponse = json.decode(response2.body);
          print("모집 게시판 _url3 페이지 연결 성공");

          if (jsonResponse is Map<String, dynamic>) {
            // 단일 객체인 경우
            final recruitcomment = RecruitComment.fromJson(jsonResponse);
            setState(() {
              _recruitcomment = [recruitcomment];
              print('단일 객체인 경우 ${_recruitcomment[0].PLACE}');

              List<int> powerList = _recruitcomment[0].PLANT_POWER.map((e) => int.parse(e!)).toList();

              double sum = 0;
              powerList.forEach((e) => sum += e);

              power_map['${i}'] = sum;

              powersumList = power_map;
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
          body: powersumList["$index"] == null
              ? Center(child: CircularProgressIndicator(
            color: Colors.white,
          ))
              : Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: double.infinity,
                height: 50,
                padding: EdgeInsets.fromLTRB(20, 0, 0, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('모집 게시판', style: TextStyle(fontSize: 23,),),
                    IconButton(
                        icon: Icon(Icons.add, size: 30,),
                        style: ButtonStyle(
                          iconColor: MaterialStateProperty.all<Color>(
                              Colors.black54),
                        ),
                        onPressed: () {
                          myDialog(context);
                        }
                    ),
                  ],
                ),
              ),
              Expanded(
                child: powersumList == {}
                    ? SizedBox(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  width: 10,
                  height: 10,
                )
                    : ListView.builder(
                  shrinkWrap: true, // 내부 콘텐츠에 맞춰서 높이 결정
                  itemCount: _recruit_boards[0].MEM_ID.length,
                  itemBuilder: (context, index) =>
                      GestureDetector(
                        // onTap: (){},
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.fromLTRB(10, 3, 0, 3),
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
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: _recruit_boards[0].B_STATE[index] == 'ing'
                                      ? Image.asset('image/solQuiz_logo2.png', width: 120,)
                                      : Image.asset('image/solQuiz_logo2_grey.png', width: 120,)
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              SizedBox(height: 10,),
                                              Row(
                                                children: [
                                                  SizedBox(width: 10,),
                                                  Text('[${_recruit_boards[0]
                                                      .SB_TYPE[index] == 'Inland'
                                                      ? '내륙'
                                                      : '해안'}] 발전소 모집',
                                                    style: TextStyle(
                                                        fontSize: 19),),
                                                ],
                                              ),
                                              SizedBox(height: 10,),
                                              Text('${_recruit_boards[0]
                                                  .PLACE[index]}',
                                                style: TextStyle(fontSize: 17,),),
                                              SizedBox(height: 10,),
                                            ],
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                SizedBox(width: 15,),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        powersumList["$index"] == null
                                            ? SizedBox(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                          width: 10,
                                          height: 10,
                                        )
                                            : LinearPercentIndicator(
                                          width: 140.0,
                                          animation: true,
                                          animationDuration: 100,
                                          lineHeight: 3.0,
                                          // leading: const Text("left"),
                                          // trailing: const Text("right"),
                                          percent: ((powersumList["$index"])/20 >= 1.0 ? 1.0 : powersumList["$index"]/20),
                                          trailing: Text(
                                            '${double.parse((((powersumList["$index"])/20)*100).toStringAsFixed(2))}%',
                                            style: TextStyle(fontSize: 15),),
                                          progressColor: _recruit_boards[0].B_STATE[index] == 'ing'? Color(0xffff9201) : Colors.grey,
                                          barRadius: Radius.circular(10),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/recruitmore',
                                                arguments: index);
                                          },
                                          style: IconButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                          ),
                                          icon: Icon(
                                              Icons.arrow_forward_ios_outlined),
                                          color: Colors.black54,
                                          iconSize: 20,),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                ),
              ),
            ],
          ),
          // bottomNavigationBar: SizedBox(
          //   height: 80,
          //   child: BottomNavigationBar(
          //     currentIndex: index,
          //
          //     // onTap: onItemTap,
          //
          //     type: BottomNavigationBarType.fixed,
          //     items: [
          //       BottomNavigationBarItem(icon: Icon(Icons.campaign), label : '공지사항',),
          //       BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label : '발전량예측',),
          //       BottomNavigationBarItem(icon: Icon(Icons.wb_sunny_rounded), label : '태양광',),
          //       BottomNavigationBarItem(icon: Icon(Icons.assignment), label : '모집게시판',),
          //       BottomNavigationBarItem(icon: Icon(Icons.account_circle), label : '마이페이지',),
          //     ],
          //     // 라벨 스타일
          //     showSelectedLabels: true,
          //     showUnselectedLabels: true,
          //
          //     // bottom 영역 스타일 지정
          //     backgroundColor: const Color(0xffff9201),
          //     unselectedItemColor: Colors.white,
          //     selectedItemColor: Colors.white,
          //
          //     // 디자인
          //     selectedIconTheme: IconThemeData(
          //       size: 27,
          //     ),
          //     unselectedIconTheme: IconThemeData(
          //       size: 27,
          //     ),
          //
          //     selectedLabelStyle: TextStyle(fontSize: 14,),
          //
          //   ),
          // ),
        )
    );
  }
  void onItemTap(int i){
    setState(() {
      Navigator.pushNamed(context, '/navigationbar');
    });
  }

  void myDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
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
                    Text('모집글을 등록하시겠습니까?', style: TextStyle(fontSize: 22,),),
                    SizedBox(width: 50,),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        addRecruit();
                      },
                      child: Text(
                        '예',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        // alignment: Alignment(x, y),
                        backgroundColor: Color(0xffff9201),
                        minimumSize: Size(17, 10),
                        // fixedSize: Size(30, 7),
                        padding: EdgeInsets.symmetric(
                            horizontal: 13, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        '아니오',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        // alignment: Alignment(x, y),
                        backgroundColor: Colors.grey,
                        minimumSize: Size(17, 10),
                        // fixedSize: Size(30, 7),
                        padding: EdgeInsets.symmetric(
                            horizontal: 13, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
    );
  }


  // 모집글 추가 함수
  // final String _url2 = 'http://10.0.2.2:3000/recruitsql/addrecruit';
  Future<void> addRecruit() async {
    try {
      final response = await http.post(
          Uri.parse(_url2),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({'id': '${userInfo['id']}'})
      );

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        print("연결 성공");
        print(jsonResponse);

        if (jsonResponse == 'success') {
          print('통신 후의 percentList : ${percentList}');
          Navigator.pushNamed(context, ('/navigationbar'));
        } else if (jsonResponse == 'failed') {
          print('모집글 추가 실패');
        }
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}