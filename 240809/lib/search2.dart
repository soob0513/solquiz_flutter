import 'package:flutter/material.dart';

class Search2 extends StatelessWidget {
  const Search2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('아이디 찾기'),
      ),
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(height: 100,),
              // Container(
              //   padding: EdgeInsets.all(50),
              //     child: Image.asset('image/solQuiz_logo3.png', width: 200,)
              // ),
              Container(
                  child: Column(
                    children: [
                      Text('홍길동님의 아이디는', style: TextStyle(fontSize: 22,),),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('ghdrlfehd', style: TextStyle(fontSize: 27, color: Color(0xffff9201), fontWeight: FontWeight.bold),),
                          Text('  입니다.', style: TextStyle(fontSize: 22,),),
                        ],
                      ),
                    ],
                  )),
              SizedBox(height: 80,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    minimumSize: Size(310, 42),
                    backgroundColor: Color(0xFFFF9201),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                onPressed: () {},
                child: Text('로그인',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              SizedBox(height: 12,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    minimumSize: Size(310, 42),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(
                        width: 1,
                        color: Color(0xffff9201),
                      ),
                    )),
                onPressed: () {},
                child: Text('비밀번호 찾기',
                    style: TextStyle(fontSize: 18, color: Color(0xffff9201))),
              ),
              SizedBox(height: 12,),

            ],
          ),
      ),
    );
  }
}
