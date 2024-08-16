import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:solquiz_2/solarplant_addr.dart';
import 'package:flutter/services.dart';

class SolarplantName extends StatefulWidget {
  const SolarplantName({super.key});

  @override
  State<SolarplantName> createState() => _SolarplantNameState();
}

class _SolarplantNameState extends State<SolarplantName> {
  String? solarplantnameError;

  TextEditingController solarplantnameCon = TextEditingController();

  void validateFields() {
    setState(() {
      // 이름 필드 확인
      if (solarplantnameCon.text.trim().isEmpty) {
        solarplantnameError = '발전소 이름을 입력해주세요';
      } else {
        solarplantnameError = null;
      }
    });
  }

  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    // 비동기로 flutter secure storage 정보를 불러오는 작업
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _asyncMethod();
    });
  }

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
          content: Text(message, style: TextStyle(fontSize: 17)),
          actions: <Widget>[
            Container(
              width: 60,
              height: 40,
              child: TextButton(
                child: Text('확인', style: TextStyle(color: Colors.white)),
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
          ],
        );
      },
    );
  }

  void NextButton() {
    String solarplantname = solarplantnameCon.text.toString();
    validateFields();
    if (solarplantnameError == null) {
      Navigator.pushNamed(
        context,
        '/solarplantaddr',
        arguments: solarplantname
      );
    } else {
      showPopup('해당 양식을 올바르게 입력해주세요.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Image.asset(
          'image/solQuiz_logo3.png',
          width: 130,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          style: ButtonStyle(
            iconColor: MaterialStateProperty.all<Color>(Colors.black87),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: (){NextButton();},
            style: ButtonStyle(
              iconColor: MaterialStateProperty.all<Color>(Colors.black87),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Column(
            children: [
              SizedBox(height: 130),
              Text(
                '발전소 이름을 입력해주세요',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(height: 100),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                  child: TextFormField(
                    controller: solarplantnameCon,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      label: Align(
                        alignment: Alignment.center,
                        child: Text('발전소 이름', style: TextStyle(fontSize: 19),),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFA3A3A3)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xfffd9a06)),
                      ),
                      labelStyle: TextStyle(color: Color(0xFFA3A3A3)),
                      errorText: solarplantnameError,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z ㄱ-ㅎ|가-힣|·|：]')),
                    ],
                    onChanged: (value) {
                      validateFields();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
