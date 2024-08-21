import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:solquiz_2/solarplant_name.dart';

import 'login.dart';

class Join extends StatefulWidget {
  const Join({super.key});

  @override
  State<Join> createState() => _JoinState();
}

class _JoinState extends State<Join> {

  final String _url = 'http://192.168.219.54:3000/join/joinpage'; // 서버 URL
  String _error = '';

  TextEditingController idCon = TextEditingController();
  TextEditingController pwCon = TextEditingController();
  TextEditingController checkpwCon = TextEditingController();
  TextEditingController nameCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  String? idError;
  String? pwError;
  String? phoneError;
  String? emailError;
  String? nameError;

  Future<void> sendJoinData() async{
    String id = idCon.text.toString();
    String pw = pwCon.text.toString();
    String name = nameCon.text.toString();
    String phone = phoneCon.text.toString();
    String email = emailCon.text.toString();

    print('id : ' + id);
    print('pw : ' + pw);
    print('name : ' + name);
    print('phone : ' + phone);
    print('email : ' + email);

    try {
      final response = await http.post(Uri.parse(_url),
        headers : {'Content-Type': 'application/json'},
        body: json.encode({'id': id,'pw': pw, 'name' : name, 'phone' : phone, 'email' : email}),
      );

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        print("연결 성공");
        // print("통신 response : "+ jsonResponse);

        if (jsonResponse == 'success') {
          print('회원 가입 성공 - ' +jsonResponse);

        }else if (jsonResponse == 'failed'){
          print("회원가입 통신 response : "+ jsonResponse);
          print('회원가입 실패');
          showPopup('아이디와 비밀번호를 다시 확인해주세요');
        }
      }
    } catch (e) {
      print(e);
      return null;
    }
  }


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
              padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: Image.asset(
                      'image/solQuiz_logo3.png',
                      width: 200,
                      height: 50,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    '회원으로 함께 해주세요',
                    style: TextStyle(fontSize: 23),
                  ),
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 3, 10, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: idCon,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFFA3A3A3)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xfffd9a06)),
                                  ),
                                  labelText: '아이디',
                                  labelStyle: TextStyle(color: Color(0xFFA3A3A3)),
                                  errorText: idError,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                                  backgroundColor: Color(0xFFFF9201),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: ()  {
                                  setState(() {
                                    idError = null;
                                    checkDuplicateId();
                                  });
                                },
                                child: Text(
                                  '중복체크',
                                  style: TextStyle(fontSize: 15, color: Colors.white,),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: pwCon,
                          obscureText: true,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFA3A3A3))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xfffd9a06))),
                            labelText: '비밀번호 ',
                            labelStyle: TextStyle(color: Color(0xFFA3A3A3)),
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: checkpwCon,
                          obscureText: true,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFA3A3A3)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xfffd9a06)),
                            ),
                            labelText: '비밀번호 확인',
                            labelStyle: TextStyle(color: Color(0xFFA3A3A3)),
                            errorText: pwError,
                            errorStyle: TextStyle(color: Colors.red),
                          ),
                          onChanged: (value) {
                            validateFields();
                          },
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: nameCon,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFA3A3A3)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xfffd9a06)),
                            ),
                            labelText: '이름',
                            labelStyle: TextStyle(color: Color(0xFFA3A3A3)),
                            errorText: nameError,
                          ),
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.allow(RegExp(r'[ㄱ-ㅎㅏ-ㅣ가-힣]')),
                          // ],
                          onChanged: (value) {
                            validateFields();
                          },
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: phoneCon,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFFA3A3A3)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xfffd9a06)),
                                  ),
                                  labelText: '휴대폰 번호',
                                  labelStyle: TextStyle(color: Color(0xFFA3A3A3)),
                                  hintText: "'-' 없이 입력해주세요",
                                  hintStyle: TextStyle(color: Color(0xFFA3A3A3)),
                                  errorText: phoneError,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onChanged: (value) {
                                  validateFields();
                                },
                              ),
                            ),
                            // SizedBox(
                            //   width: 80,
                            //   height: 40,
                            //   child: ElevatedButton(
                            //     style: ElevatedButton.styleFrom(
                            //       padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                            //       backgroundColor: Color(0xFFFF9201),
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(5),
                            //       ),
                            //     ),
                            //     onPressed: () async {
                            //       await checkDuplicateId();
                            //     },
                            //     child: Text(
                            //       '인증하기',
                            //       style: TextStyle(fontSize: 15, color: Colors.white,),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),

                        SizedBox(height: 10,),
                        TextFormField(
                          controller: emailCon,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFA3A3A3)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xfffd9a06)),
                            ),
                            labelText: '이메일',
                            labelStyle: TextStyle(color: Color(0xFFA3A3A3)),
                            errorText: emailError,
                          ),
                          onChanged: (value) {
                            validateFields();
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            minimumSize: Size(350, 42),
                            backgroundColor: Color(0xFFFF9201),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            validateFields();
                            sendJoinData();

                            if (pwError == null &&
                                idError == null &&
                                nameError == null &&
                                phoneError == null &&
                                emailError == null) {

                              showPopup('회원가입이 완료되었습니다!');


                            } else {
                              showPopup('해당 양식을 올바르게 입력해주세요.');
                            }
                          },
                          child: Text(
                            '회원가입',
                            style: TextStyle(fontSize: 19, color: Colors.white),
                          ),
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
    );
  }
  Future<void> checkDuplicateId() async {
    final String _url2 = 'http://192.168.219.54:3000/join/checkduplicateId';
    final response = await http.post(Uri.parse(_url2),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'id': '${idCon.text}'}),
    );


    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result == 'exists') {
        setState(() {
          idError = '이미 사용 중인 아이디입니다';
        });
      } else {
        setState(() {
          idError = null;
        });
      }
    } else {
      throw Exception('Failed to check ID');
    }

  }

  void validateFields() {
    setState(() {
      // 비밀번호 확인
      if (pwCon.text != checkpwCon.text) {
        pwError = '비밀번호가 다릅니다';
      } else {
        pwError = null;
      }

      // 이름 필드 확인
      if (nameCon.text.trim().isEmpty) {
        nameError = '이름을 입력해주세요';
      } else {
        nameError = null;
      }

      // 전화번호 필드 확인
      if (phoneCon.text.trim().isEmpty) {
        phoneError = '휴대폰번호를 입력해주세요';
      } else {
        phoneError = null;
      }

      // 이메일 필드 확인
      if (emailCon.text.trim().isEmpty) {
        emailError = '이메일을 입력해주세요';
      } else {
        emailError = null;
      }
    });
  }

  void showPopup(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('알림'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('확인', style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/login');
              },
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                  ),
                  backgroundColor: Color(0xfffd9a06)
              ),
            ),
          ],
        );
      },
    );
  }
}
