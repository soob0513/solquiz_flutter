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

      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: double.infinity,
              height: 50,
              padding: EdgeInsets.fromLTRB(12, 0, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('모집 게시판', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),
                  IconButton(
                      icon: Icon(Icons.add),
                      style: ButtonStyle(
                        iconColor: MaterialStateProperty.all<Color>(Colors.grey),
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
                        padding: EdgeInsets.all(3),
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
                                child: Image.asset('image/solQuiz_logo2.png', width: 40, height: 40,)),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  SizedBox(height: 10,),
                                  Text('${txtList[index]}',style: TextStyle(fontSize: 18),),
                                  SizedBox(height: 10,),
                                  Text('${txtList2[index]}',style: TextStyle(fontSize: 13,),),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      SizedBox(width: 40,),
                                      LinearPercentIndicator(
                                        width: 140.0,
                                        animation: true,
                                        animationDuration: 100,
                                        lineHeight: 3.0,
                                        // leading: const Text("left"),
                                        // trailing: const Text("right"),
                                        percent: 0.7,
                                        trailing: Text("70.0%", style: TextStyle(fontSize: 11),),
                                        progressColor: Color(0xfffd9a06),
                                        barRadius: Radius.circular(10),
                                      ),
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     LinearProgressIndicator(
                                  //       value: 0.7,
                                  //       backgroundColor: Colors.grey[200],
                                  //       color: Colors.black45,
                                  //       valueColor: AlwaysStoppedAnimation<Color>(
                                  //           const Color(0xfffd9a06)),
                                  //       minHeight: 7.0,
                                  //       semanticsLabel: 'semanticsLabel',
                                  //       semanticsValue: 'semanticsValue',
                                  //
                                  //     ),
                                  //     // Text('70%'),
                                  //   ],
                                  // ),
                                  SizedBox(height: 8,),

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
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          // alignment: Alignment.bottomCenter,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 50
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text('모집글을 등록하시겠습니까?'),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '예',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      // alignment: Alignment(x, y),
                      backgroundColor: Color(0xffff9201),
                      minimumSize: Size(17, 10),
                      // fixedSize: Size(30, 7),
                      padding: EdgeInsets.symmetric(
                          horizontal: 13, vertical: 7),
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
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      // alignment: Alignment(x, y),
                      backgroundColor: Colors.grey,
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
        );
      },
    );
  }



void showPop(){
  // context : 어플이 사용하고 있는 내용 -> 그대로 사용!
  var context;
  showDialog(context: context, builder: (context){
  return Dialog(
  child: Container(
  width: MediaQuery.of(context).size.width * 0.7,
  height: 380,
  decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
  ),
        child: Column(
          children: [
            Text('모집글을 등록하시겠습니까?'),
            SizedBox(height: 10,),
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(10),
            // ),
            // SizedBox(height: 10,),
            Padding(padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(onPressed: (){}, child: Text('예')),
                  SizedBox(width: 10,),
                  ElevatedButton(onPressed: (){}, child: Text('아니오')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  });
}
}
// void addList(){
//   txtList.add('[해안] 발전소 모집');
//   txtList2.add('전남 / 해안');
//   print('text');
// }
