import 'package:flutter/material.dart';
import 'package:solquiz_2/profileEdit.dart';

class changePw extends StatefulWidget {
  const changePw({super.key});

  @override
  State<changePw> createState() => _ChangePwState();
}

class _ChangePwState extends State<changePw> {
  bool isChecked = false;
  TextEditingController pwCon = TextEditingController();
  TextEditingController newpwCon = TextEditingController();
  TextEditingController newNpwCon = TextEditingController();
  String? newpwError;

  void validateFields() {
    setState(() {
      // 비밀번호 확인
      if (newpwCon.text != newNpwCon.text) {
        newpwError = '비밀번호가 다릅니다';
      } else {
        newpwError = null;
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
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                  foregroundColor: Color(0xfffd9a06)
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
          '비밀번호 변경',
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
            Navigator.push(context, MaterialPageRoute(builder: (_) => profileEdit()));
          },
          icon: Icon(Icons.arrow_back),
        ),
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
                children: [
                  SizedBox(height: 100),
                  TextFormField(
                    controller: pwCon,
                    obscureText: !isChecked,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xfffd9a06))),
                      labelText: '현재 비밀번호',
                      labelStyle: TextStyle(color: Color(0xFFA3A3A3)),
                    ),
                  ),
                  TextFormField(
                    controller: newpwCon,
                    obscureText: !isChecked,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xfffd9a06))),
                      labelText: '새 비밀번호',
                      labelStyle: TextStyle(color: Color(0xFFA3A3A3)),
                    ),
                  ),
                  TextFormField(
                    controller: newNpwCon,
                    obscureText: !isChecked,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xfffd9a06))),
                      labelText: '새 비밀번호 확인',
                      labelStyle: TextStyle(color: Color(0xFFA3A3A3)),
                      errorText: newpwError,
                      errorStyle: TextStyle(color: Colors.red),
                    ),
                    onChanged: (value) {
                      validateFields();
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                        activeColor: Color(0xFFFFD08B),
                        checkColor: Colors.white,
                      ),
                      Text(
                        '비밀번호 보기',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(350, 42),
                      backgroundColor: Color(0xFFFF9201),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      validateFields();
                      if (newpwError == null){
                        showPopup('비밀번호 변경이 완료되었습니다!');
                      } else {
                        showPopup('해당 양식을 올바르게 입력해주세요.');
                      }
                    },
                    child: Text(
                      '비밀번호 변경',
                      style: TextStyle(fontSize: 17, color: Colors.white),
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
}

// class DataCheck extends StatelessWidget {
//   final String newpw;
//   const DataCheck({super.key, required this.newpw});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Container(
//             child: Text('새 비밀번호가 성공적으로 변경되었습니다.'),
//           ),
//         ),
//       ),
//     );
//   }
// }

