import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:solquiz_2/navigationBar.dart';
import 'package:solquiz_2/predict.dart';
import 'package:solquiz_2/recruit.dart';

import 'board.dart';
import 'mainPage.dart';
import 'myPage.dart';


class RecruitMore extends StatefulWidget {
  const RecruitMore({super.key});

  @override
  State<RecruitMore> createState() => _RecruitMoreState();
}

class _RecruitMoreState extends State<RecruitMore> {

  int index = 0;
  List<Widget> pageList = [
    // Board(sqlQuery: 'select * from TB_BOARD '),
    Board(),
    Predict(sqlQuery: 'SELECT * FROM TB_PREDICTION WHERE PRED_IDX = 67',),
    SolarEnv(),
    Recruit(),
    MyPage()];

  List<User> _users = [
    User('광주 / 전남', '해안', 5),
    User('세종 / 대전 / 충남', '내륙', 7),
    User('제주', '해안', 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // title: Image.asset('image/solQuiz_logo1.png',width: 130,),
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
      body: Container(
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
        child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 5, 8, 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffff9201),
                    ),
                    child: Text('모집중', style: TextStyle(color: Colors.white, fontSize: 13,),),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.favorite_border_sharp, color: Colors.black54,),
                      ),
                      IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.edit, color: Colors.black54,),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(40),
                  child: Image.asset('image/solQuiz_logo3.png',width: 200,),
              ),
              SizedBox(height: 25,),
              Row(
                children: [
                  SizedBox(width: 20,),
                  Container(
                    alignment: Alignment.center,
                    child: LinearPercentIndicator(
                      width: 270,
                      animation: true,
                      animationDuration: 100,
                      lineHeight: 3.0,
                      // leading: const Text("left"),
                      // trailing: const Text("right"),
                      percent: 0.7,
                      trailing: Text("70.0%", style: TextStyle(fontSize: 15),),
                      progressColor: Color(0xffff9201),
                      barRadius: Radius.circular(10),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text('[해안] 발전소 모집',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('전남 / 해안',style: TextStyle(fontSize: 20,),),
                  SizedBox(width: 50),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffff9201),
                        minimumSize: Size(12, 10),
                        padding: EdgeInsets.symmetric(horizontal: 13,vertical: 7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text('참여하기',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () => {}
                  ),
                  SizedBox(width: 12,),
                ],
              ),
              SizedBox(height: 20,),
              Container(width: double.infinity, height: 1, color: Colors.grey[400],),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '참여 현황',
                        style: TextStyle(
                            fontSize: 17,fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 8,),
                      _userContainer(_users[0].region1, _users[0].region2, _users[0].env),
                      _userContainer(_users[1].region1, _users[1].region2, _users[1].env),
                      _userContainer(_users[2].region1, _users[2].region2, _users[2].env),

                    ],
                  ),
              ),
              
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
            BottomNavigationBarItem(icon: Icon(Icons.campaign), label : '공지사항',),
            BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label : '발전량예측',),
            BottomNavigationBarItem(icon: Icon(Icons.wb_sunny_rounded), label : '태양광',),
            BottomNavigationBarItem(icon: Icon(Icons.assignment), label : '모집게시판',),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), label : '마이페이지',),
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

          selectedLabelStyle: TextStyle(fontSize: 14,),

        ),
      ),
    );
  }
  void onItemTap(int i){
    setState(() {
      index = i;
    });
  }
}

class User {
  final String region1;
  final String region2;
  final int env;

  User(this.region1, this.region2, this.env);
}

Widget _userContainer(String region1, String region2, int env){
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.all(10),
    child: Row(
      children: [
        Icon(Icons.person),
        SizedBox(width: 10,),
        Container(
          alignment: Alignment.center,
          width: 130,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey[300],
          ),
          child: Text(region1),
        ),
        SizedBox(width: 8,),
        Container(
          alignment: Alignment.center,
          width: 60,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey[300],
          ),
          child: Text(region2),
        ),
        SizedBox(width: 8,),
        Container(
          alignment: Alignment.center,
          width: 60,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey[300],
          ),
          child: Text(env.toString() + ' MWh'),
        ),
      ],
    ),
  );
}

