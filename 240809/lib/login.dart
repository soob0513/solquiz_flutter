import 'package:flutter/material.dart';
import 'package:solquiz_2/join.dart';
import 'package:solquiz_2/search.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController idCon = TextEditingController();
  TextEditingController pwCon = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                      child: Image.asset(
                    'image/solQuiz_logo2.png',
                    width: 300,
                    height: 300,
                  )),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextField(
                      controller: idCon,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:BorderSide(color:Color(0xFFA3A3A3))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xfffd9a06))),
                        labelText: 'ID 입력',
                        labelStyle: TextStyle(color: Color(0xFFA3A3A3)),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextField(
                      controller: pwCon,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:BorderSide(color:Color(0xFFA3A3A3))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xfffd9a06))),
                        labelText: 'PW 입력',
                        labelStyle: TextStyle(color: Color(0xFFA3A3A3)),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        minimumSize: Size(310, 42),
                        backgroundColor: Color(0xFFFF9201),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    onPressed: () {},
                    child: Text('로그인',
                        style: TextStyle(fontSize: 17.5, color: Colors.white)),
                  ),
                  SizedBox(height: 12,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        minimumSize: Size(310, 42),
                        backgroundColor: Color(0xFFFF9201),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => Join()));
                    },
                    child: Text('회원가입',
                        style: TextStyle(fontSize: 17, color: Colors.white)),
                  ),
                  SizedBox(height: 12,),
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //         minimumSize: Size(310, 42),
                  //         backgroundColor: Color(0xfffee500),
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(5),
                  //         )),
                  //     onPressed: () {},
                  //     child:Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Image.asset('image/kakaotalk_sharing_btn_small.png', width: 26,),
                  //         SizedBox(width: 5,),
                  //         Text('카카오 계정으로 로그인',
                  //              style: TextStyle(fontSize: 17, color: Colors.black)),
                  //       ],
                  //     ),
                  //
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: (){print('카카오톡 로그인');},
                    child: Container(
                        child: Image.asset('image/kakao_login_large_wide.png', width: 313,)
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => Search()));
                      },
                          child: Text('아이디 찾기 | 비밀번호 찾기',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFFA3A3A3),
                                  decoration: TextDecoration.underline)))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
