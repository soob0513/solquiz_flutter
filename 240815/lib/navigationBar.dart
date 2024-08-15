import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:solquiz_2/board.dart';
import 'package:solquiz_2/db/tb_member.dart';
import 'package:solquiz_2/recruit.dart';
import 'package:solquiz_2/mainPage.dart';
import 'package:solquiz_2/predict.dart';
import 'package:solquiz_2/predict.dart' as predictP;
import 'package:solquiz_2/myPage.dart';
import 'package:solquiz_2/weather/SampleWeather.dart';


class Navigationbar extends StatefulWidget {
  const Navigationbar({super.key});
  // const Navigationbar({Key? key, required this.user}) : super(key: key);
  // final Member user;

  @override
  State<Navigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  int index = 2;

  List<Widget> pageList = [
    Board(),
    Predict(),
    SolarEnv(),
    Recruit(),
    MyPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[index],

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


