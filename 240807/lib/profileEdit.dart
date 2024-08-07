import 'package:flutter/material.dart';
import 'package:solquiz_2/changePw.dart';

class profileEdit extends StatefulWidget {
  const profileEdit({super.key});

  @override
  State<profileEdit> createState() => _profileEditState();
}

class _profileEditState extends State<profileEdit> {

  void showPopup(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)),
          backgroundColor: Colors.white,
          title: Text('알림'),
          content: Text(message, style: TextStyle(fontSize: 17),),
          actions: <Widget>[
            Container(
              width: 60,
              height: 40,
              child: TextButton(
                child: Text('네', style: TextStyle(color: Colors.white),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                    backgroundColor: Color(0xfffd9a06)
                ),
              ),
            ),
            TextButton(
              child: Text('아니요'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                  foregroundColor: Color(0xFFA3A3A3)
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '내 정보',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontFamily: 'Abhaya Libre',
            fontWeight: FontWeight.w400,
            height: 0.07,
            letterSpacing: 0.40,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
            child: Container(
              padding: EdgeInsets.fromLTRB(35, 0, 20,0),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: Column(
                  children:[
                Row(
                children: [
                  SizedBox(height: 50,),
                Container(
                child: Text('이름', style: TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                  fontFamily: 'Abhaya Libre',
                  fontWeight: FontWeight.w400,)
                ),
                ),
                  SizedBox(width: 235,),
                  Container(
                    child: Text('홍길동',style: TextStyle(
                     color: Color(0xFFA3A3A3),
                     fontSize: 16,
                      fontFamily: 'Abhaya Libre',
                      fontWeight: FontWeight.w400,
                    ),
                    ),
                  )
                ],
                            ),
                    Row(
                      children: [
                        SizedBox(height: 40,),
                        Container(
                          child: Text('휴대폰 번호', style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontFamily: 'Abhaya Libre',
                            fontWeight: FontWeight.w400,)
                          ),
                        ),
                        SizedBox(width: 110,),
                        Container(
                          child: Text('010-1234-5678',style: TextStyle(
                            color: Color(0xFFA3A3A3),
                            fontSize: 17,
                            //fontFamily: 'Abhaya Libre',
                            fontWeight: FontWeight.w400,
                          ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(height: 40,),
                        Container(
                          child: Text('비밀번호 변경', style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontFamily: 'Abhaya Libre',
                            fontWeight: FontWeight.w400,)
                          ),
                        ),
                        SizedBox(width: 165,),
                        IconButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_) => changePw()));
                        },
                            icon: Icon(Icons.keyboard_arrow_right,size: 30,)
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(height: 40,),
                        Container(
                          child: Text('계정 로그인', style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontFamily: 'Abhaya Libre',
                            fontWeight: FontWeight.w400,)
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 330,),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(310, 42),
                        backgroundColor: Color(0xFFFF9201),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    onPressed: () {},
                    child: Text('로그아웃',
                        style: TextStyle(fontSize: 17, color: Colors.white)),
                  ),
                  TextButton(
                      onPressed: () {
                        showPopup('탈퇴하시겠습니까?');
                      },
                      child: Text('회원탈퇴',
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFFA3A3A3),
                              decoration: TextDecoration.underline)))
                  ],
                  ),
              ),
                ),
      ),
    );
  }
}
