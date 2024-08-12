import 'package:flutter/material.dart';
import 'package:solquiz_2/board.dart';
import 'package:solquiz_2/recruit.dart';
import 'package:solquiz_2/mainPage.dart';
import 'package:solquiz_2/predict.dart';
import 'package:solquiz_2/myPage.dart';


class Navigationbar extends StatefulWidget {
  const Navigationbar({super.key});

  @override
  State<Navigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  int index = 0;
  List<Widget> pageList = [ Board(), Predict(), SolarEnv(), Recruit(), MyPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Image.asset('image/solQuiz_logo1.png',width: 130,),
      //   backgroundColor: Colors.white,
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.notifications),
      //       style: ButtonStyle(
      //         iconColor: MaterialStateProperty.all<Color>(Colors.grey),
      //       ),
      //       onPressed: (){
      //         print('icon alert');
      //       },
      //     ),
      //     IconButton(
      //       icon: Icon(Icons.logout_outlined),
      //       style: ButtonStyle(
      //         iconColor: MaterialStateProperty.all<Color>(Colors.grey),
      //       ),
      //       onPressed: (){
      //         print('icon logout');
      //       },
      //     ),
      //
      //   ],
      // ),
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


