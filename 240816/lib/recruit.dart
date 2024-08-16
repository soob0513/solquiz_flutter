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

  final String _url = 'http://10.0.2.2:3000/recruitsql/bselect'; // 서버 URL
  List<RecruitBoards> _recruit_boards = []; // Boards 객체 리스트
  String _error = '';
  var index = 0;
  List<int> idxList = [0];

  get percentList => null;
  var powerList = [0];
  var powersumList = null;



  @override
  void initState() {
    super.initState();
    _sendQuery(); // 위젯에서 받은 SQL 쿼리를 사용합니다.
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
        final dynamic jsonResponse = json.decode(response.body);
        print("연결 성공");
        print(jsonResponse);

        if (jsonResponse is Map<String, dynamic>) {
          // 단일 객체인 경우
          final recruit_boards = RecruitBoards.fromJson(jsonResponse);
          setState(() {
            _recruit_boards = [recruit_boards];
            print('_recruit_boards임 :  ${_recruit_boards}');

            idxList = List<int>.generate(_recruit_boards[0].MEM_ID.length, (i) => i++);
            print('idxList 생성 됐니 ${idxList}');
            print('idxList 타입 내놔 ${idxList[0].runtimeType}');

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
            print(_recruit_boards);
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
      print('모집 게시판 userInfo : ' + userInfo);
    } else {
      print('로그인이 필요합니다');
    }
  }



  late final double percent;
  var re_idx = 0;


  
  // 참여현황 percent를 띄워야 한다
  final String _url2 = 'http://10.0.2.2:3000/recruit/recruitmore';
  List<RecruitComment> _recruitcomment = [];
  final List<RecruitMore> RecruitmoreList = <RecruitMore>[];



  Future<void> _recruit_more() async {
    print('_recruit_more 함수 안임');
    Iterable<int> commentList = idxList.map((e) => e);
    print('리스트 만들었음'+ '${commentList}');

    Map<String, dynamic> power_map = {};

    for (int i = 0; i < idxList.length; i++) {
      // print('${i}');


      try {
        final response2 = await http.post(Uri.parse(_url2),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({'idx': i.toString()})
        );

        if (response2.statusCode == 200) {
          final dynamic jsonResponse = json.decode(response2.body);
          print("모집 게시판 _url2 페이지 연결 성공");


          if (jsonResponse is Map<String, dynamic>) {
            // 단일 객체인 경우
            final recruitcomment = RecruitComment.fromJson(jsonResponse);
            setState(() {
              _recruitcomment = [recruitcomment];
              print('단일 객체인 경우 ${_recruitcomment[0].PLACE}');

              // var powerList = idxList.map((e)=> _recruitcomment[0].PLANT_POWER[e]);
              // print('powerList 만들었음' + '${powerList}');

              // power_map['${idxList}'] = powerList['0'];

              List<int> powerList = _recruitcomment[0].PLANT_POWER.map((e) => int.parse(e!)).toList();

              double sum = 0;
              powerList.forEach((e) => sum += e);

              power_map['${i}'] = sum;
              print('쿠로미 ' + ' ${i}'+ ' ${power_map}');

              powersumList = power_map;
              print('powerList key 값 확인해보자'+'${powersumList}');
              /*
              for (var per in _recruitcomment[0].PLANT_POWER)
                percentList.add(double.parse(per!));
              // print('percentList 생성됐나 ${percentList}');
              for (double per in percentList)
                percentSum = percentSum + per;
               */
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

    print('마이멜로디' + '$power_map');
    print('포챠코 ' + '${power_map['0'].runtimeType}');  // List<String> -> List<int> 변경 성공!
    // print('파워퍼프걸 ' + '${power_map['0'][0].runtimeType}');


    /*
    for (int i = 0; i < power_map.length; i++) {
      double sum$i = 0;
      for (int j = 0; j < power_map['$i']; j++) {
        sum$i = sum$i + double.parse(power_map['i'][j]);

        print('뭐가 null 이냐' + '$index');
        print('폼폼푸린' + '${sum$i}');
      }
    }
    */


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
            : powersumList == {}
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
              child: powersumList.length == 0
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
                              child: Image.asset(
                                'image/solQuiz_logo2.png', width: 120,),
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
                                              Column(
                                                children: [
                                                  IconButton(
                                                    alignment: Alignment
                                                        .topRight,
                                                    onPressed: () {},
                                                    icon: Icon(Icons
                                                        .favorite_border_sharp,
                                                      color: Colors.black54,),
                                                    style: IconButton.styleFrom(
                                                      padding: EdgeInsets.zero,
                                                    ),
                                                  ),
                                                  SizedBox(height: 17,),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      LinearPercentIndicator(
                                        width: 140.0,
                                        animation: true,
                                        animationDuration: 100,
                                        lineHeight: 3.0,
                                        // leading: const Text("left"),
                                        // trailing: const Text("right"),
                                        percent: (powersumList["$index"]/20 >= 1.0 ? 1.0 : powersumList["$index"]/20),
                                        trailing: Text(
                                          '${(powersumList["$index"]/20)*100}%',
                                          style: TextStyle(fontSize: 15),),
                                        progressColor: Color(0xffff9201),
                                        barRadius: Radius.circular(10),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          print('모집 게시판 더보기 ${index}');

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
      ),
    );
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
                    // IconButton(
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   icon: const Icon(Icons.close, size: 20,),
                    // )
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        percentList.add(0.5);
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


  Future<void> addRecruit() async {
    final String _url = 'http://10.0.2.2:3000/recruitsql/addrecruit';

    try {
      final response = await http.post(
          Uri.parse(_url),
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
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                  super.widget));
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