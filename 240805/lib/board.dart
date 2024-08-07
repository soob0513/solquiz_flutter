import 'package:flutter/material.dart';

class Board extends StatelessWidget {
  const Board({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset('image/solQuiz_logo1.png',width: 130,),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            style: ButtonStyle(
              iconColor: MaterialStateProperty.all<Color>(Colors.grey),
            ),
            onPressed: (){
              print('icon alert');
            },
          ),
          IconButton(
            icon: Icon(Icons.logout_outlined),
            style: ButtonStyle(
              iconColor: MaterialStateProperty.all<Color>(Colors.grey),
            ),
            onPressed: (){
              print('icon logout');
            },
          ),
        ],
      ),
      // appBar: AppBar(
      //   title: Text('공지사항', style: TextStyle(fontWeight: FontWeight.bold),),
      //   backgroundColor: Colors.white,
      // ),
      body: Container(
        child: Column(
          children: [
          Container(
          width: double.infinity,
          height: 50,
          padding: EdgeInsets.fromLTRB(12, 0, 0, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('공지사항', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),

            ],
          ),
        ),
            SingleChildScrollView(
              // controller: _controller,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      width: 350,
                      height: 250,
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
                        children: [
                          Image.asset('image/moomin9.jpg', width: 180,),
                          SizedBox(height: 8,),
                          Text('[공지] 집에 가고 싶다', style: TextStyle(fontSize: 20, color: Color(0xff1e1e1e)),),
                        ],
                      ),

                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 350,
                      height: 250,
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
                        children: [
                          Image.asset('image/nim.jpg', width: 180,),
                          SizedBox(height: 8,),
                          Text('[공지] 귀여운 님피아', style: TextStyle(fontSize: 20, color: Color(0xff1e1e1e)),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
