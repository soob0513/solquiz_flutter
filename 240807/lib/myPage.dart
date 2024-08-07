import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  var recruitList = ['전남 / 해안 / 5MWh', '충청 / 내륙 / 10MWh', '대전 / 내륙 / 15MWh',];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Image.asset('image/solQuiz_logo3.png',width: 120,),
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
        body: SingleChildScrollView(
          child : Column(
            children: [
              Container(
                width: double.infinity,
                height: 50,
                padding: EdgeInsets.fromLTRB(12, 0, 0, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 8,),
                    Text('마이페이지', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                  ],
                ),
              ),
              Container(
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          child: Image.asset(
                            'image/moomin9.jpg',
                            width: 50,
                            height: 50,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(80)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '사용자 이름',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'andslkfj@smhrd.com',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 55,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            '정보 수정',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            // alignment: Alignment(x, y),
                            backgroundColor: Colors.grey[400],
                            minimumSize: Size(17, 10),
                            // fixedSize: Size(30, 7),
                            padding: EdgeInsets.symmetric(
                                horizontal: 13, vertical: 7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('발전소 관리', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        SizedBox(width: 8,),
                        TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                          onPressed: (){} ,
                          child: Text('내 발전소 현황',
                            style: TextStyle(fontSize: 18, color: Colors.black),),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 8,),
                        TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                          onPressed: (){} ,
                          child: Text('내 발전소 정보 수정하기',
                            style: TextStyle(fontSize: 18, color: Colors.black),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('모집 게시판 관리', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        SizedBox(width: 8,),
                        TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                          onPressed: (){} ,
                          child: Text('모집 게시판 찜 목록',
                            style: TextStyle(fontSize: 18, color: Colors.black),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('발전소 모집 현황', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
                        SizedBox(width: 50,),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffff9201),
                              minimumSize: Size(12, 10),
                              padding: EdgeInsets.symmetric(horizontal: 13,vertical: 7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Text('모집 마감',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () => {}
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios_outlined),
                          style: ButtonStyle(
                            iconColor: MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          onPressed: (){
                            Navigator.pushNamed(context, '/recruitmore');
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('목표 : 20㎿h', style: TextStyle(fontSize: 19,),),
                            SizedBox(width: 180,),
                            Text('70%', style: TextStyle(fontSize: 19,),),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(width: double.infinity, height: 1, color: Colors.grey[300],),
                    SizedBox(height: 10,),
                    Scrollbar(
                      thickness: 1.0,
                      radius: Radius.circular(8.0),
                      child: ListView.builder(
                          primary: false,
                          shrinkWrap: true, // 내부 콘텐츠에 맞춰서 높이 결정
                          itemCount: recruitList.length,
                          itemBuilder: (context, index) =>
                              GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  height: 30,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${index +1}. ${recruitList[index]}', style: TextStyle(fontSize: 16),),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey[400],
                                            minimumSize: Size(12, 10),
                                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                          ),
                                          child: Text('승인 완료',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () => {}
                                      ),
                                    ],
                                  ),
                                ),
                              )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
