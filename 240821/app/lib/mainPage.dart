import 'dart:convert';
import 'dart:core';
import 'dart:ui';
// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:solquiz_2/main.dart';
import 'package:solquiz_2/weather/SampleWeather.dart';
import 'package:intl/intl.dart';

import 'db/tb_member.dart';
import 'db/tb_solarplant.dart';


final storage = FlutterSecureStorage();

class SolarEnv extends StatefulWidget {
  const SolarEnv({super.key});

  @override
  State<SolarEnv> createState() => _SolarEnvState();
}

class _SolarEnvState extends State<SolarEnv> {

  final String _url = 'http://192.168.219.54:3000/smprecsql/smprecselect';
  // 'http://192.168.219.217:3000/smprecsql/smprecselect'; // 맥북 서버 URL

  final String _url2 = 'http://192.168.219.54:3000/smprecsql/mainmoney';

  // 3. 발전소 이름 띄우기
  final String _url3 = 'http://192.168.219.54:3000/solarplant/plantname';
  //----------------------------------------------------------------------------
  final storage = const FlutterSecureStorage();
  dynamic userInfo = ''; // storage에 있는 유저 정보를 저장

  dynamic max_smp = 0;
  dynamic min_smp = 0;
  dynamic avg_smp = 0;
  dynamic max_rec = 0;
  dynamic min_rec = 0;
  dynamic avg_rec = 0;

  String _error = '';
  String ans = '';
  String time = '';
  String mainmoney = '';
  String devel = '';
  int intmainmoney = 0;

  List<SolarPlant> _solarplant = []; // Boards 객체 리스트

  // 돈 천 단위로 콤마 표기
  var f = NumberFormat('###,###,###,###');

  @override
  void initState() {
    super.initState();
    _sendQuery(); // 위젯에서 받은 SQL 쿼리를 사용합니다.
    _date_format();
    _plant_name();
  }

  Future<void> _sendQuery() async {
    String _error = '';

    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        print("연결 성공!!!개 행복하다 진짜 미치겠다 너무 행복하다 너만 나와주면 나 집간다");
        print(jsonResponse);
        setState(() {
          max_smp = jsonResponse[0][2];
          min_smp = jsonResponse[0][3];
          avg_smp = jsonResponse[0][4];
          max_rec = jsonResponse[0][5];
          min_rec = jsonResponse[0][6];
          avg_rec = jsonResponse[0][7];
        });
      } else {
        setState(() {
          _error = 'sql쪽 문제';
        });
      }
    } catch (e) {
      print("try문 에러 : ${e}");
    }
    String? userInfo = await storage.read(key: 'login');
    if (userInfo != null) {
      print('저장된 사용자 정보: $userInfo');
    } else {
      print('저장된 정보가 없습니다.');
    }
  }



  // 날짜를 "YYYY-MM-DD" 형식으로 포맷합니다.
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  // final String _url2 = 'http://192.168.219.210:3000/smprecsql/mainmoney';
  Future<void> _date_format() async {
    try {
      final response = await http.post(
        Uri.parse(_url2),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({'date' : formattedDate}),
      );

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        print("연결 성공");
        print(jsonResponse);
        setState(() {
          ans = jsonResponse;
          time = ans.split("-")[0];
          mainmoney = ans.split('-')[1];
          intmainmoney = int.parse(mainmoney);
          devel = ans.split('-')[2];

        });
      } else {
        setState(() {
          _error = 'Failed to execute query';
          print("if문 에러 :");
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        print("try문 에러 : ${e}");
      });
    }
  }

  // 3. 발전소 이름 띄우기
  Future<void> _plant_name() async {
    userInfo = await storage.read(key: 'login');
    print('checkUserState 함수 : '+ userInfo);
    userInfo = json.decode(userInfo);
    try {
      final response = await http.post(
          Uri.parse(_url3),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({'userInfo': userInfo})
      );
      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        print("마이페이지 연결 성공");
        print(jsonResponse);

        if (jsonResponse is Map<String, dynamic>) {
          // 단일 객체인 경우
          final solarplant = SolarPlant.fromJson(jsonResponse);
          setState(() {
            _solarplant = [solarplant];
            print("잠만보" + _solarplant.toString());
          });
        } else if (jsonResponse is List) {
          // 배열인 경우
          print('어디냐 5');
          final solarplant = jsonResponse.map((data) {
            if (data is Map<String, dynamic>) {
              return SolarPlant.fromJson(data);
            } else {
              return null; // 데이터가 올바른 형식이 아닌 경우
            }
          }).whereType<SolarPlant>().toList();

          setState(() {
            _solarplant = solarplant;
            print(_solarplant);
            print(_solarplant[0]);
          });
        } else {
          setState(() {
            _error = 'Unexpected JSON format';
          });
        }
      } else {
        setState(() {
          _error = 'Failed to execute query';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            fit: StackFit.loose,
            children: [
              Positioned(
                child: Container(
                    width: double.infinity,
                    height: 270,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                          begin: const Alignment(0.0, -1.0),
                          end: const Alignment(0.0, 1.0),
                          colors: [
                            Color(0xff008fff),
                            Color(0xff40abff),
                            Color(0xff40abff),
                            Colors.white,
                          ]),
                      shape: BoxShape.rectangle,
                    ),
                    padding: EdgeInsets.all(5),
                    child: FutureBuilder(
                      // future: getLocation(context),
                        future: getWeather(context),
                        // future: getWeather(객체.필드, 객체.필드 context),
                        builder:
                            (context, AsyncSnapshot<SampleWeather> snapshot) {
                          //데이터가 만약 들어오지 않았을때는 뱅글뱅글 로딩이 뜬다
                          if (snapshot.hasData == false) {
                            return SizedBox(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                              width: 10,
                              height: 10,
                            );
                          }
                          return Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${snapshot.data?.main.temp}℃',
                                        style: TextStyle(
                                            fontSize: 33, color: Colors.white),
                                      ),
                                      Text(
                                        // '${snapshot.data?.name}',
                                        'Gwangju',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 45,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '최저 : ${((snapshot.data?.main.tempMin)! - 3.72).toStringAsFixed(2)}℃',
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white),
                                      ),
                                      Text(
                                        '최고 : ${((snapshot.data?.main.tempMax)! + 3.83).toStringAsFixed(2)}℃',
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        child: Image.network(
                                          'https://openweathermap.org/img/wn/${snapshot.data?.weather[0].icon}.png',
                                          fit: BoxFit.contain,
                                        ),
                                        height: 73,
                                        width: 73,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        })),
              ),
              // -----------두번째 컨테이너---------------
              _solarplant.isEmpty
              ? Center(child: CircularProgressIndicator(
              color: Colors.white,
              ))
              :_solarplant[0].PLANT_NAME.isEmpty
              ? Positioned(
                    top: 150,
                    left: 13,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/solarplantname');
                      },
                      child: Container(
                        padding: EdgeInsets.all(17),
                        width: 368,
                        height: 230,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('발전소 등록이 필요합니다.', style: TextStyle(fontSize: 28),),
                          ],
                        ),
                    )))
               : Positioned(
                top: 150,
                left: 13,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/money');
                  },
                  child: Container(
                    padding: EdgeInsets.all(17),
                    width: 368,
                    height: 230,
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
                            Text(
                              '${_solarplant[0].PLANT_NAME[0]} 발전소',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '가동중',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          '금일 예상 수익',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${f.format(intmainmoney)}',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  '평균 발전시간',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${time} h',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 100,
                            ),
                            Column(
                              children: [
                                Text(
                                  '금일 발전량',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${devel} kwh',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 15,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 138,),
          Row(
            children: [
              SizedBox(width: 20,),
              Text(
                '시장 동향',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 176,
                // height: 176,
                margin: EdgeInsets.fromLTRB(15, 15, 5, 15),
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
                      children: [
                        Text(
                          'SMP',
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '원/kWh',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '오늘 평균가',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      '${avg_smp}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      '오늘 상한가',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 2,),
                    Text(
                      '${max_smp}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff006bb9)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '오늘 하한가',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      '${min_smp}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Container(
                width: 176,
                // height: 176,
                margin: EdgeInsets.fromLTRB(5, 15, 15, 15),
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
                      children: [
                        Text(
                          'REC',
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '원/REC',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '오늘 평균가',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      '${f.format(avg_rec)}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '오늘 상한가',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      '${f.format(max_rec)}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff006bb9)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '오늘 하한가',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      '${f.format(min_rec)}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<SampleWeather> getWeather(context) async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    double lat = position.latitude;
    double lon = position.longitude;

    print("lat: $lat, lon: $lon");

    String url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=311b37be82274842eb40377115dbd958&units=metric";
    Response res = await get(Uri.parse(url));
    SampleWeather w = sampleWeatherFromJson(res.body);

    print('getWeather 함수 실행됨!!!!!');

    return w;
  }
}