import 'package:flutter/material.dart';
import 'package:solquiz_2/solarplant_name.dart';
import 'package:flutter/services.dart';


class SolarplantAddr extends StatefulWidget {
  const SolarplantAddr({super.key});

  @override
  State<SolarplantAddr> createState() => _SolarplantAddrState();
}

class _SolarplantAddrState extends State<SolarplantAddr> {
  String? solarplantaddError;
  String? solarplantpowerError;

  List<bool> regions = List.generate(10, (index) => false);
  int selectedIndex = -1;

  TextEditingController solarplantaddCon = TextEditingController();
  TextEditingController solarplantpowerCon = TextEditingController();

  void onRegionPress(int index) {
    setState(() {
      selectedIndex = index;
      // 모든 값을 false로 설정하고, 선택된 인덱스만 true로 설정
      for (int i = 0; i < regions.length; i++) {
        regions[i] = i == index;
      }
    });
  }

  void validateFields() {
    setState(() {
      // 이름 필드 확인
      if (solarplantaddCon.text.trim().isEmpty) {
        solarplantaddError = '발전소 주소를 입력해주세요';
      } else {
        solarplantaddError = null;
      }
      if (solarplantpowerCon.text.trim().isEmpty) {
        solarplantpowerError = '생산전력을 입력해주세요';
      } else {
        solarplantpowerError = null;
      }

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
          content: Text(message, style: TextStyle(fontSize: 17),),
          actions: <Widget>[
            Container(
              width: 60,
              height: 40,
              child: TextButton(
                child: Text('확인', style: TextStyle(color: Colors.white),),
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
              Navigator.push(context, MaterialPageRoute(builder: (_) => SolarplantName()));
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
                padding: EdgeInsets.fromLTRB(20, 35, 20, 0),
                child: Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '지역 상세',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          )
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(5, (row) {
                        return Row(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(2, (col) {
                            int index = row * 2 + col;
                            if (index >= regions.length) return SizedBox();
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 7.5),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(155, 38),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  backgroundColor:
                                  regions[index] ? Color(0xFFFD9A06) : Color(0xFFD9D9D9),
                                ),
                                onPressed: () {
                                  onRegionPress(index);
                                },
                                child: Text(
                                  RegionName(index),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          }),
                        );
                      }),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: solarplantaddCon,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFA3A3A3)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xfffd9a06)),
                          ),
                          labelText: '상세주소',
                          labelStyle: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold),
                          hintText: '발전소 상세 주소를 입력해주세요',
                          hintStyle: TextStyle(color: Color(0xFFA3A3A3)),
                        errorText: solarplantaddError
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[ㄱ-ㅎㅏ-ㅣ가-힣]')),
                      ],
                      onChanged: (value){
                         validateFields();
                      },
                    ),
                    SizedBox(height: 50),
                    Row(
                      children: [
                        Text('생산 전력', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: solarplantpowerCon,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xFFA3A3A3)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xfffd9a06)),
                              ),
                              labelStyle: TextStyle(color: Colors.black),
                              errorText: solarplantpowerError
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            onChanged: (value){
                              validateFields();
                            },
                          ),
                        ),
                        Text('Wh', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Color(0xfffd9a06),
          padding: EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 60),
                    backgroundColor: Color(0xFFFD9A06) ,
                    shadowColor: Colors.transparent
                ),
                onPressed: () {
                  validateFields();
                  if (solarplantaddError == null &&
                  solarplantpowerError == null) {
                      showPopup('등록되었습니다.');
                  } else {
                    showPopup('해당 양식을 올바르게 입력해주세요.');
                  }
                },
                child: Text(
                  '등록',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  String RegionName(int index) {
    switch (index) {
      case 0: return '서울/인천/경기';
      case 1: return '강원';
      case 2: return '광주/전남';
      case 3: return '전북';
      case 4: return '충북';
      case 5: return '세종/대전/충남';
      case 6: return '대구/경북';
      case 7: return '부산/울산/경남';
      case 8: return '제주';
      case 9: return '기타';
      default: return '';
    }
  }
}
