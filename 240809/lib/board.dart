import 'package:flutter/material.dart';

class Board extends StatelessWidget {
  const Board({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset('image/solQuiz_logo3.png',width: 110,),
        // title: Image.asset('image/solQuiz_logo1.png',width: 200,),
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
      body:
      // Container(
      //   child: Column(
      //     children: [
      //     Container(
      //     width: double.infinity,
      //     height: 50,
      //     padding: EdgeInsets.fromLTRB(12, 0, 0, 5),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         SizedBox(width: 8,),
      //         Text('공지사항', style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,),),
      //
      //       ],
      //     ),
      //   ),
            SingleChildScrollView(
              // controller: _controller,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      width: 350,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color : Colors.grey.withOpacity(0.5),
                            spreadRadius: 1.5,
                            blurRadius: 5,
                            offset: Offset(0,3),  // 그림자 위치 변경
                          ),
                        ],
                      ),
                      child : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Image.asset('image/solQuiz_logo3.png', width: 150,),
                            padding: EdgeInsets.fromLTRB(80, 30, 20, 30),
                          ),
                          SizedBox(height: 8,),
                          Text('[공지] 발전량 예측 제도', style: TextStyle(fontSize: 18, color: Color(0xff1e1e1e)),),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 350,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color : Colors.grey.withOpacity(0.5),
                            spreadRadius: 1.5,
                            blurRadius: 5,
                            offset: Offset(0,3),  // 그림자 위치 변경
                          ),
                        ],
                      ),
                      child : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Image.asset('image/solQuiz_logo3.png', width: 150,),
                            padding: EdgeInsets.fromLTRB(80, 30, 20, 30),
                          ),
                          SizedBox(height: 8,),
                          Text('[공지] 예측제도 참여 안내', style: TextStyle(fontSize: 18, color: Color(0xff1e1e1e)),),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 350,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color : Colors.grey.withOpacity(0.5),
                            spreadRadius: 1.5,
                            blurRadius: 5,
                            offset: Offset(0,3),  // 그림자 위치 변경
                          ),
                        ],
                      ),
                      child : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Image.asset('image/solQuiz_logo3.png', width: 150,),
                            padding: EdgeInsets.fromLTRB(80, 30, 20, 30),
                          ),
                          SizedBox(height: 8,),
                          Text('[공지] 예측제도 참여 안내', style: TextStyle(fontSize: 18, color: Color(0xff1e1e1e)),),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 350,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color : Colors.grey.withOpacity(0.5),
                            spreadRadius: 1.5,
                            blurRadius: 5,
                            offset: Offset(0,3),  // 그림자 위치 변경
                          ),
                        ],
                      ),
                      child : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Image.asset('image/solQuiz_logo3.png', width: 150,),
                            padding: EdgeInsets.fromLTRB(80, 30, 20, 30),
                          ),
                          SizedBox(height: 8,),
                          Text('[공지] 예측제도 참여 안내', style: TextStyle(fontSize: 18, color: Color(0xff1e1e1e)),),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                  ],
                ),
              ),
            ),
          // ],
        // ),
    // )
    //   ),
    );
  }
}
