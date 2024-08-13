import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'db/tb_solar_board.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Recruit extends StatefulWidget {
  const Recruit({super.key});

  @override
  State<Recruit> createState() => _RecruitState();
}


class _RecruitState extends State<Recruit> {

  final String _url = 'http://10.0.2.2:3000/recruitsql/bselect'; // 서버 URL
  List<RecruitBoards> _recruit_boards = []; // Boards 객체 리스트
  String _error = '';
  var index = 0;

  @override
  void initState() {
    super.initState();
    _sendQuery(); // 위젯에서 받은 SQL 쿼리를 사용합니다.
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
            print(_recruit_boards);
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
  }


  var txtList = ['[해안] 발전소 모집', '[내륙] 발전소 모집','[해안] 발전소 모집','[내륙] 발전소 모집'];
  var txtList2 = ['전남 / 해안', '광주 / 내륙','제주 / 해안', '충청 / 내륙'];
  var percentList = [0.7, 0.6, 0.9, 0.5, 0.6];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset('image/solQuiz_logo3.png',width: 110,),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            style: ButtonStyle(
              iconColor: MaterialStateProperty.all<Color>(Colors.black54),
            ),
            onPressed: (){
              print('icon alert');
            },
          ),
          IconButton(
            icon: Icon(Icons.logout_outlined),
            style: ButtonStyle(
              iconColor: MaterialStateProperty.all<Color>(Colors.black54),
            ),
            onPressed: (){
              print('icon logout');
            },
          ),
        ],
      ),

      body: _error.isNotEmpty
          ? Center(child: Text(_error),)
          : _recruit_boards.isEmpty
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
                          iconColor: MaterialStateProperty.all<Color>(Colors.black54),
                        ),
                        onPressed: () {myDialog(context);}
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
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
                                  child: Image.asset('image/solQuiz_logo2.png', width: 120,),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              SizedBox(height: 10,),
                                              Row(
                                                children: [
                                                  SizedBox(width: 10,),
                                                  Text('[${_recruit_boards[0].SB_TYPE[index] == 'Inland' ? '내륙' : '해안'}] 발전소 모집',style: TextStyle(fontSize: 19),),
                                                ],
                                              ),
                                              SizedBox(height: 10,),
                                              Text('${_recruit_boards[0].PLACE[index]}',style: TextStyle(fontSize: 17,),),
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
                                                      alignment: Alignment.topRight,
                                                      onPressed: (){},
                                                      icon: Icon(Icons.favorite_border_sharp, color: Colors.black54,),
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
                                          width: 150.0,
                                          animation: true,
                                          animationDuration: 100,
                                          lineHeight: 3.0,
                                          // leading: const Text("left"),
                                          // trailing: const Text("right"),
                                          percent: percentList[index],
                                          trailing: Text("${percentList[index]*100}%", style: TextStyle(fontSize: 15),),
                                          progressColor: Color(0xffff9201),
                                          barRadius: Radius.circular(10),
                                        ),
                                        IconButton(
                                          onPressed: (){
                                            Navigator.pushNamed(context, '/recruitmore');
                                          },
                                          style: IconButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                          ),
                                          icon: Icon(Icons.arrow_forward_ios_outlined), color: Colors.black54, iconSize: 20,),
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
                  onPressed: () {},
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
}


// void addList(){
//   txtList.add('[해안] 발전소 모집');
//   txtList2.add('전남 / 해안');
//   print('text');
// }
