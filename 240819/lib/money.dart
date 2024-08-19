import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Money extends StatefulWidget {
  const Money({super.key});

  @override
  State<Money> createState() => _MoneyState();
}

class _MoneyState extends State<Money> {
  int index = 0;

  final storage = FlutterSecureStorage();
  dynamic userInfo = ''; // storage에 있는 유저 정보를 저장

  bool juneSelected = false;
  bool julySelected = false;
  bool augustSelected = true;

  @override
  void initState() {
    super.initState();
    _asyncMethod(); // storage 안에 있는 로그인 정보 받아오기
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
  }

  // 로그아웃 함수
  logout() async {
    await storage.delete(key: 'login');
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // title: Image.asset('image/solQuiz_logo3.png', width: 120,),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined),
            color: Colors.black54,
            onPressed: () {
              print('icon logout');
              logout();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(7),
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
                    minimumSize: Size(99, 32),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    backgroundColor:
                    juneSelected ? Colors.black : Colors.white,
                  ),
                  onPressed: juneSelectedPress,
                  child: Row(
                    children: [
                      if (juneSelected)
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Icon(Icons.check, color: Colors.white, size: 20,),
                        ),
                      Text(
                        '6월 수익',
                        style: TextStyle(
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
                    minimumSize: Size(99, 32),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    backgroundColor:
                    julySelected ? Colors.black : Colors.white,
                  ),
                  child: Row(
                    children: [
                      if (julySelected)
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Icon(Icons.check, color: Colors.white, size: 20,),
                        ),
                      Text(
                        '7월 수익',
                        style: TextStyle(
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
                    minimumSize: Size(99, 32),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    backgroundColor:
                    augustSelected ? Colors.black : Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (augustSelected)
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Icon(Icons.check, color: Colors.white, size: 20,),
                        ),
                      SizedBox(width: 10,),
                      Text(
                        '8월 수익',
                        style: TextStyle(
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
    );
  }
  void onItemTap(int i){
    setState(() {
      index = i;
    });
  }

  void juneSelectedPress() {
    setState(() {
      juneSelected = true;
      julySelected = false;
      augustSelected = false;
    });
  }

  void julySelectedPress() {
    setState(() {
      juneSelected = false;
      julySelected = true;
      augustSelected = false;
    });
  }

  void augustSelectedPress() {
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
      height: 300,
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
          SizedBox(height: 8),
          Text(
            '6월 누적 발전 수익',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 10),
          Text('2024.06.01 ~ 2024.06.30',
              style: TextStyle(
                color: Color(0xFF757575),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              )),
          SizedBox(height: 10),
          Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFFCAC4D0))))),
          SizedBox(height: 45),
          Row(
            children: [
              SizedBox(width: 5),
              Text('SMP 수익',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  )),
              SizedBox(width: 25),
              Text(
                '4,245,478 원 (13.8MWh)',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              SizedBox(width: 5),
              Text('REC 발행 개수',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  )),
              SizedBox(width: 139),
              Text(
                '13.8 개',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          SizedBox(height: 3),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     TextButton(
          //       onPressed: () {},
          //       child: Row(
          //         children: [
          //           Text(
          //             '수익 전체보기',
          //             style: TextStyle(
          //               color: Color(0xFF757575),
          //               fontSize: 14,
          //               fontFamily: 'Inter',
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //           IconButton(
          //             onPressed: () {},
          //             icon: Icon(Icons.arrow_forward, color: Colors.black),
          //             style: IconButton.styleFrom(
          //                 foregroundColor: Color(0xFFFF9201)),
          //           ),
          //         ],
          //       ),
          //       style: TextButton.styleFrom(foregroundColor: Color(0xFFFF9201)),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }

  Widget JulyContainer() {
    return Container(
      width: 350,
      height: 300,
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
          SizedBox(height: 8),
          Text(
            '7월 누적 발전 수익',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 10),
          Text('2024.07.01 ~ 2024.07.31',
              style: TextStyle(
                color: Color(0xFF757575),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              )),
          SizedBox(height: 10),
          Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFFCAC4D0))))),
          SizedBox(height: 45),
          Row(
            children: [
              SizedBox(width: 5),
              Text('SMP 수익',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  )),
              SizedBox(width: 25),
              Text(
                '5,123,478 원 (15.2MWh)',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              SizedBox(width: 5),
              Text('REC 발행 개수',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  )),
              SizedBox(width: 139),
              Text(
                '15.2 개',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          SizedBox(height: 3),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     TextButton(
          //       onPressed: () {},
          //       child: Row(
          //         children: [
          //           Text(
          //             '수익 전체보기',
          //             style: TextStyle(
          //               color: Color(0xFF757575),
          //               fontSize: 14,
          //               fontFamily: 'Inter',
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //           IconButton(
          //             onPressed: () {},
          //             icon: Icon(Icons.arrow_forward, color: Colors.black),
          //             style: IconButton.styleFrom(
          //                 foregroundColor: Color(0xFFFF9201)),
          //           ),
          //         ],
          //       ),
          //       style: TextButton.styleFrom(foregroundColor: Color(0xFFFF9201)),
          //     )
          //   ],
          // )
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
          SizedBox(height: 8),
          Text(
            '8월 누적 발전 수익',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 10),
          Text('2024.08.01 ~ 2024.08.31',
              style: TextStyle(
                color: Color(0xFF757575),
                fontSize: 17,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              )),
          SizedBox(height: 20),
          Container(width: double.infinity, height: 1, color: Colors.grey[400],),
          SizedBox(height: 45),
          Row(
            children: [
              SizedBox(width: 5),
              Text('SMP 수익',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  )),
              SizedBox(width: 18),
              Text(
                '6,789,478 원 (18.4MWh)',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              SizedBox(width: 5),
              Text('REC 발행 개수',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  )),
              SizedBox(width: 139),
              Text(
                '18.4 개',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
