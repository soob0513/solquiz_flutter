import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:solquiz_2/appbar_more.dart';
import 'appbar_more.dart';


class Money extends StatefulWidget {
  const Money({super.key});

  @override
  State<Money> createState() => _MoneyState();
}



class _MoneyState extends State<Money> {

  final String _url = 'http://192.168.219.54:3000/smprecsql/money';

  // 돈 천 단위로 콤마 표기
  var f = NumberFormat('###,###,###,###');

  int index = 0;
  int ans = 0;
  bool juneSelected = false;
  bool julySelected = false;
  bool augustSelected = true;
  String _error = '';

  // 현재 날짜와 시간 가져오기
  DateTime now = DateTime.now();
  // 현재 월 가져오기 (1부터 12까지의 값)
  // int currentMonth = int.parse(now.month);

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    // _sendQuery(); // 초기 데이터 로드
  }


  Future<void> _sendQuery(int a) async {
    print(a);
    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({'month' : a}),
      );

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        print("연결 성공");
        print(jsonResponse);
        setState(() {
          ans = jsonResponse;
        });
      } else {
        setState(() {
          _error = 'Failed to execute query';
          print("else문 에러 :");
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        print("try문 에러 : ${e}");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Appbar2(),
          ),
          body: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(7, 18, 7, 7),
                  child: Text(
                    '수익',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        minimumSize: Size(50, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor:
                        juneSelected ? Colors.black : Colors.white,
                      ),
                      onPressed: juneSelectedPress,
                      child: Row(
                        children: [
                          if (juneSelected)
                            Icon(Icons.check, color: Colors.white, size: 20,),
                          SizedBox(width: 5,),
                          Text(
                            '${now.month-2}월 수익',
                            style: TextStyle(
                              fontSize: 16,
                              color: juneSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: julySelectedPress,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        minimumSize: Size(50, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor:
                        julySelected ? Colors.black : Colors.white,
                      ),
                      child: Row(
                        children: [
                          if (julySelected)
                            Icon(Icons.check, color: Colors.white, size: 20,),
                          Text(
                            '${now.month-1}월 수익',
                            style: TextStyle(
                              fontSize: 16,
                                color:
                                julySelected ? Colors.white : Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: augustSelectedPress,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        minimumSize: Size(50, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor:
                        augustSelected ? Colors.black : Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (augustSelected)
                            Icon(Icons.check, color: Colors.white, size: 20,),
                          SizedBox(width: 5,),
                          Text(
                            '${now.month}월 수익',
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                augustSelected ? Colors.white : Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                _buildContainer(),
              ],
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: 80,
            child: BottomNavigationBar(
              currentIndex: index,
      
              onTap: onItemTap,
      
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.campaign),
                  label: '공지사항',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.leaderboard),
                  label: '발전량예측',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.wb_sunny_rounded),
                  label: '태양광',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.assignment),
                  label: '모집게시판',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: '마이페이지',
                ),
              ],
              // 라벨 스타일
              showSelectedLabels: true,
              showUnselectedLabels: true,
      
              // bottom 영역 스타일 지정
              backgroundColor: const Color(0xffff9201),
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.white,
      
              // 디자인
              selectedIconTheme: IconThemeData(
                size: 27,
              ),
              unselectedIconTheme: IconThemeData(
                size: 27,
              ),
      
              selectedLabelStyle: TextStyle(
                fontSize: 14,
              ),
            ),
          )
      ),
    );
  }
  void onItemTap(int i){
    setState(() {
      index = i;
    });
  }

  void juneSelectedPress() {
    _sendQuery(DateTime.now().month-2);
    setState(() {
      juneSelected = true;
      julySelected = false;
      augustSelected = false;
    });
  }

  void julySelectedPress() {
    _sendQuery(DateTime.now().month-1);
    setState(() {
      juneSelected = false;
      julySelected = true;
      augustSelected = false;
    });
  }

  void augustSelectedPress() {
    _sendQuery(DateTime.now().month);
    setState(() {
      juneSelected = false;
      julySelected = false;
      augustSelected = true;
    });
  }

  Widget _buildContainer() {
    if (juneSelected) {
      return JuneContainer();
    } else if (julySelected) {
      return JulyContainer();
    } else if (augustSelected) {
      return AugustContainer();
    } else {
      return SizedBox.shrink();
    }
  }

  Widget JuneContainer() {
    return Container(
      width: 350,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1.5,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8,),
          Row(
            children: [
              SizedBox(width: 8,),
              Text(
                '${now.month-2}월 누적 발전 수익',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 8,),
              Text('2024.07.01 ~ 2024.07.31',
                  style: TextStyle(
                    color: Color(0xFF757575),
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  )),
            ],
          ),
          SizedBox(height: 20),
          Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFFCAC4D0))))),
          SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('${f.format(ans)} 원',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  )),
              SizedBox(width: 20,),
            ],
          ),
          SizedBox(width: 25, height: 25,),
        ],
      ),
    );
  }

  Widget JulyContainer() {
    return Container(
      width: 350,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1.5,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8,),
          Row(
            children: [
              SizedBox(width: 8,),
              Text(
                '${now.month-1}월 누적 발전 수익',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 8,),
              Text('2024.07.01 ~ 2024.07.31',
                  style: TextStyle(
                    color: Color(0xFF757575),
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  )),
            ],
          ),
          SizedBox(height: 20),
          Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFFCAC4D0))))),
          SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('${f.format(ans)} 원',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  )),
              SizedBox(width: 20,),
            ],
          ),
          SizedBox(width: 25, height: 25,),
        ],
      ),
    );
  }

  Widget AugustContainer() {
    return Container(
      width: 350,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1.5,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8,),
          Row(
            children: [
              SizedBox(width: 8,),
              Text(
                '${now.month}월 누적 발전 수익',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 8,),
              Text('2024.08.01 ~ 2024.08.22',
                  style: TextStyle(
                    color: Color(0xFF757575),
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  )),
            ],
          ),
          SizedBox(height: 20),
          Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFFCAC4D0))))),
          SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('${f.format(ans)} 원',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  )),
              SizedBox(width: 20,),
            ],
          ),
          SizedBox(width: 25, height: 25,),
        ],
      ),
    );
  }
}