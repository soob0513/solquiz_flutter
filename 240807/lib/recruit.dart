import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Recruit extends StatefulWidget {
  const Recruit({super.key});

  @override
  State<Recruit> createState() => _RecruitState();
}


class _RecruitState extends State<Recruit> {
  var txtList = ['[해안] 발전소 모집', '[내륙] 발전소 모집','[내륙] 발전소 모집','[해안] 발전소 모집'];
  var txtList2 = ['전남 / 해안', '광주 / 내륙','전남 / 해안', '광주 / 내륙'];

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

      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: double.infinity,
              height: 50,
              padding: EdgeInsets.fromLTRB(20, 0, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('모집 게시판', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                  IconButton(
                      icon: Icon(Icons.add),
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
                itemCount: txtList.length,
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
                                child: Image.asset('image/solQuiz_logo2.png', width: 70, )),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  SizedBox(height: 10,),
                                  Text('${txtList[index]}',style: TextStyle(fontSize: 20),),
                                  SizedBox(height: 10,),
                                  Text('${txtList2[index]}',style: TextStyle(fontSize: 17,),),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      SizedBox(width: 35,),
                                      LinearPercentIndicator(
                                        width: 120.0,
                                        animation: true,
                                        animationDuration: 100,
                                        lineHeight: 3.0,
                                        // leading: const Text("left"),
                                        // trailing: const Text("right"),
                                        percent: 0.7,
                                        trailing: Text("70.0%", style: TextStyle(fontSize: 13),),
                                        progressColor: Color(0xffff9201),
                                        barRadius: Radius.circular(10),
                                      ),
                                      IconButton(
                                        onPressed: (){
                                          Navigator.pushNamed(context, '/recruitmore');
                                        },
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
          // horizontal: 10,
          // vertical: 5
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('모집글을 등록하시겠습니까?', style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                // SizedBox(width: 10,),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close, size: 20,),
                )
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
