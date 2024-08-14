import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:solquiz_2/solarplant_name.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import 'navigationBar.dart';


class SolarplantAddr extends StatefulWidget {
  const SolarplantAddr({super.key});

  @override
  State<SolarplantAddr> createState() => _SolarplantAddrState();
}

class _SolarplantAddrState extends State<SolarplantAddr> {
  String? solarplantaddError;
  String? solarplantpowerError;

  List<bool> regions = List.generate(10, (index) => false);
  List<bool> places = List.generate(2, (index) => false);
  int selectedIndex = -1;

  TextEditingController solarplantaddCon = TextEditingController();
  TextEditingController solarplantpowerCon = TextEditingController();

  List<String> regionList = ['서울/인천/경기', '강원', '광주/전남', '전북', '충북', '세종/대전/충남', '대구/경북', '제주', '부산/울산/경남', '기타'];
  List<String> placeList = ['Coast', 'Inland'];

  void onRegionPress(int index) {
    setState(() {
      selectedIndex = index;
      print('onRegionPress 안' + '${index}');
      // 모든 값을 false로 설정하고, 선택된 인덱스만 true로 설정
      // for (int i = 0; i < regions.length; i++) {
      //   regions[i] = i == index;
      // }
      print(regionList[index]);
    });

    // return regionList[index];
  }

  void onPlacePress(int index) {
    setState(() {
      selectedIndex = index;
      // 모든 값을 false로 설정하고, 선택된 인덱스만 true로 설정
      for (int i = 0; i < places.length; i++) {
        places[i] = i == index;
      }
    });
  }


  void validateFields() {
    setState(() {
      // 이름 필드 확인
      if (solarplantaddCon.text
          .trim()
          .isEmpty) {
        solarplantaddError = '발전소 주소를 입력해주세요';
      } else {
        solarplantaddError = null;
      }
      if (solarplantpowerCon.text
          .trim()
          .isEmpty) {
        solarplantpowerError = '생산전력을 입력해주세요';
      } else {
        solarplantpowerError = null;
      }
    });
  }

  // db 통신
  final storage = FlutterSecureStorage();
  dynamic userInfo = ''; // storage에 있는 유저 정보를 저장

  final String _url = 'http://10.0.2.2:3000/solarplant/sp'; // 서버 URL
  String _error = '';

  @override
  void initState() {
    super.initState();

    // 비동기로 flutter secure storage 정보를 불러오는 작업
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    // 데이터가 없을때는 null을 반환
    userInfo = await storage.read(key:'login');

    // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어가게 합니다.
    if (userInfo != null) {
      print('발전소 등록 페이지 _asyncMethod userInfo : ' + userInfo);
      // {"id":"apple","pw":"banana"}
      // Navigator.pushNamed(context, '/navigationbar');
    }
  }



  // --------db 통신 끝 ---------

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
    final arguments = ModalRoute.of(context)!.settings.arguments;
    print(arguments);
    Future<void> insertSolarPlant() async {
      String id = '${arguments}';
      String sp_addr = solarplantaddCon.text.toString();
      String sp_power = solarplantpowerCon.text.toString();

      print('sp_addr : ' + sp_addr);
      print('sp_power : ' + sp_power);
      print(arguments);


      try {
        final response = await http.post(Uri.parse(_url),
          headers : {'Content-Type': 'application/json'},
          body: json.encode({'id' : id, 'plant_name' : arguments, 'plant_addr': sp_addr,'plant_power':sp_power}),
        );
        var val = jsonEncode({'id' : id, 'plant_name' : arguments, 'plant_addr': sp_addr,'plant_power':sp_power});
        await storage.write(
            key: 'login',
            value: val
        );

        print('발전소 등록 flutter secure storage 접속 성공!');

        if (response.statusCode == 200) {
          final dynamic jsonResponse = json.decode(response.body);
          print("연결 성공");
          // print("통신 response : "+ jsonResponse);

          if (jsonResponse == 'success') {
            print(jsonResponse);
            _asyncMethod();

            // Navigator.pushNamed(
            //   context,
            //   '/mypage'
            // );
          }else if (jsonResponse == 'failed'){
            print("통신 response : "+ jsonResponse);
            print('로그인 실패');
            showPopup('아이디와 비밀번호를 다시 확인해주세요');
          }
        }

      } catch (e) {
        print(e);
        return null;
      }
    }



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
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SolarplantName()));
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
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10,),
                          Text(
                            '지역 구분',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          )
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(1, (row) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(2, (col) {
                            int index = row * 2 + col;
                            if (index >= places.length) return SizedBox();
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7.5),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(155, 38),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  backgroundColor:
                                  places[index] ? Color(0xFFFD9A06) : Color(
                                      0xFFD9D9D9),
                                ),
                                onPressed: () {
                                  onPlacePress(index);
                                },
                                child: Text(
                                  '${PlaceName(index)}',
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
                    SizedBox(height: 10,),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7.5),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(155, 38),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  backgroundColor:
                                  regions[index] ? Color(0xFFFD9A06) : Color(
                                      0xFFD9D9D9),
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
                          labelStyle: TextStyle(color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          hintText: '발전소 상세 주소를 입력해주세요',
                          hintStyle: TextStyle(color: Color(0xFFA3A3A3)),
                          errorText: solarplantaddError
                      ),
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.allow(
                      //       RegExp(r'[ㄱ-ㅎㅏ-ㅣ가-힣]')),
                      // ],
                      onChanged: (value) {
                        validateFields();
                      },
                    ),
                    SizedBox(height: 50),
                    Row(
                      children: [
                        Text('생산 전력', style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            onChanged: (value) {
                              validateFields();
                            },
                          ),
                        ),
                        Text('Wh', style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))
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
                    backgroundColor: Color(0xFFFD9A06),
                    shadowColor: Colors.transparent
                ),
                onPressed: () {
                  validateFields();
                  if (solarplantaddError == null &&
                      solarplantpowerError == null) {
                    showPopup('등록되었습니다.');
                    // insertPlantInfo();
                    // Navigator.pushNamed(context, '/mypage');
                    insertSolarPlant();
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
    String regionName = '';

    switch (index) {
      case 0:
        regionName = '서울/인천/경기';
        return '서울/인천/경기';
      case 1:
        return '강원';
      case 2:
        return '광주/전남';
      case 3:
        return '전북';
      case 4:
        return '충북';
      case 5:
        return '세종/대전/충남';
      case 6:
        return '대구/경북';
      case 7:
        return '부산/울산/경남';
      case 8:
        return '제주';
      case 9:
        return '기타';
      default:
        return '';
    }
  }

  String? PlaceName(int index) {
    switch (index) {
      case 0 :
        return '해안';
      case 1 :
        return '내륙';
    }
  }




}