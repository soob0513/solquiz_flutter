import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:solquiz_2/weather/SampleWeather.dart';
import 'weather/weather_model.dart';

class SolarEnv extends StatefulWidget {
  const SolarEnv({super.key});

  @override
  State<SolarEnv> createState() => _SolarEnvState();
}

class _SolarEnvState extends State<SolarEnv> {
  dynamic max_smp = 0;
  dynamic min_smp = 0;
  dynamic avg_smp = 0;
  dynamic max_rec = 0;
  dynamic min_rec = 0;
  dynamic avg_rec = 0;

  @override
  void initState() {
    super.initState();
    _sendQuery(); // 위젯에서 받은 SQL 쿼리를 사용합니다.
  }

  Future<void> _sendQuery() async {
    final String _url = 'http://10.0.2.2:3000/smprecsql/smprecselect'; // 서버 URL
        // 'http://192.168.219.217:3000/smprecsql/smprecselect'; // 맥북 서버 URL
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
          _error = 'sql쪽에서 문제가 생겼어 ㅋㅋ';
        });
      }
    } catch (e) {
      print("여기까지 오면 인생 많이 피곤하다 : ${e}");
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
                                height: 57,
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
                                        '${snapshot.data?.name}',
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
                                    // Image.asset(
                                    //   'image/sun3_remove.png', width: 80,
                                    //   height: 80,),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        })),
              ),
              // -----------두번째 컨테이너---------------
              Positioned(
                top: 160,
                left: 13,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/money');
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
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
                              'SolQuiz 발전소',
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
                          '1,963,000원',
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
                                  '5.11 h',
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
                                  '8,463 kwh',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 140,),
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
                      '${avg_rec}',
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
                      '${max_rec}',
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
                      '${min_rec}',
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
