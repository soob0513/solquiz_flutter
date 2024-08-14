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


  @override
  Widget build(BuildContext context) {
    // final w = getLocation(context);


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
                        colors: [Color(0xff008fff), Color(0xff40abff),Color(0xff40abff), Colors.white,]
                    ),
                    shape: BoxShape.rectangle,
                  ),
                  padding: EdgeInsets.all(5),
                  child: FutureBuilder(
                    // future: getLocation(context),
                    future: getWeather(context),
                    // future: getWeather(객체.필드, 객체.필드 context),
                    builder: (context, AsyncSnapshot<SampleWeather> snapshot) {
                      //데이터가 만약 들어오지 않았을때는 뱅글뱅글 로딩이 뜬다
                      if (snapshot.hasData == false) {
                        return SizedBox(
                          child: CircularProgressIndicator(
                            color : Colors.white,
                          ),
                          width: 10,
                          height: 10,
                        );
                      }
                      return Column(
                        children: [
                          SizedBox(height: 57,),
                          Row(
                            children: [
                              SizedBox(width: 40,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('${snapshot.data?.main.temp}℃', style: TextStyle(
                                      fontSize: 33, color: Colors.white),),
                                  Text('${snapshot.data?.name}', style: TextStyle(
                                      fontSize: 20, color: Colors.white),),
                                ],
                              ),
                              SizedBox(width: 45,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('최저 : ${((snapshot.data?.main.tempMin)!-3.72).toStringAsFixed(2)}℃', style: TextStyle(
                                      fontSize: 17, color: Colors.white),),
                                  Text('최고 : ${((snapshot.data?.main.tempMax)! +3.83).toStringAsFixed(2)}℃', style: TextStyle(
                                      fontSize: 17, color: Colors.white),),
                                ],
                              ),
                              SizedBox(width: 5,),
                              Column(
                                children: [
                                  SizedBox(height: 5,),
                                  Container(
                                      child: Image.network('https://openweathermap.org/img/wn/${snapshot.data?.weather[0].icon}.png',fit: BoxFit.contain,
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
                    }
                    )
                ),
              ),
              // -----------두번째 컨테이너---------------
              Positioned(
                top: 180,
                left: 13,
                child: GestureDetector(
                  onTap: (){Navigator.pushNamed(context, '/money');},
                  child: Container(
                    padding: EdgeInsets.all(15),
                    width: 368,
                    height: 230,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color : Colors.grey.withOpacity(0.5),
                          spreadRadius: 1.5,
                          blurRadius: 5,
                          offset: Offset(0,3),  // 그림자 위치 변경
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('SolQuiz 발전소', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold,),),
                            Text('가동중', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,),),
                          ],
                        ),
                        SizedBox(height: 25,),
                        Text('금일 예상 수익', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),),
                        Text('1,963,000원', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,),),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text('평균 발전시간', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),),
                                Text('5.11 h', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),),
                              ],
                            ),
                            SizedBox(width: 100,),
                            Column(
                              children: [
                                Text('금일 발전량', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),),
                                Text('8,463 kwh', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),),
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
          SizedBox(height: 170,),
          Row(
            children: [
              SizedBox(width: 20,),
              Text('시장 동향', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold,),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 176,
                height: 176,
                margin: EdgeInsets.fromLTRB(15, 15, 5, 15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color : Colors.grey.withOpacity(0.5),
                      spreadRadius: 1.5,
                      blurRadius: 5,
                      offset: Offset(0,3),  // 그림자 위치 변경
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('SMP', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
                        SizedBox(width: 10,),
                        Text('원/kWh', style: TextStyle(fontSize: 12, color: Colors.grey,),),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Text('오늘 시장 가격', style: TextStyle(fontSize: 15, color: Colors.black54,),),
                    SizedBox(height: 2,),
                    Text('276.67', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),),
                    SizedBox(height: 5,),
                    Text('이번 달 상한 가격', style: TextStyle(fontSize: 15, color: Colors.black54,),),
                    SizedBox(height: 2,),
                    Text('276.67', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff006bb9)),),
                  ],
                ),
              ),
              Container(
                width: 176,
                height: 176,
                margin: EdgeInsets.fromLTRB(5, 15, 15, 15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color : Colors.grey.withOpacity(0.5),
                      spreadRadius: 1.5,
                      blurRadius: 5,
                      offset: Offset(0,3),  // 그림자 위치 변경
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('REC', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
                        SizedBox(width: 10,),
                        Text('원/REC', style: TextStyle(fontSize: 12, color: Colors.grey,),),
                      ],
                    ),
                    SizedBox(height: 7,),
                    Text('65,600', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff006bb9)),),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

    );
  }



  // Future<SampleWeather> getWeather(double lat, double lon, context) async{
  Future<SampleWeather> getWeather(context) async{
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    double lat = position.latitude;
    double lon = position.longitude;

    print("lat: $lat, lon: $lon");

    String url = "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=311b37be82274842eb40377115dbd958&units=metric";
    // print(url);
    Response res = await get(Uri.parse(url));
    // print(res.body);

    SampleWeather w = sampleWeatherFromJson(res.body);

    print('getWeather 함수 실행됨!!!!!');

    return w;
  }
}
