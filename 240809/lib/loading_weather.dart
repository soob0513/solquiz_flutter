// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart';
//
// import 'SampleWeather.dart';
// import 'mainPage.dart';
// // 위치 정보 파악
// // 해당 위치에 맞는 날씨 가지고오기
//
//
// class LoadingPage extends StatelessWidget {
//   const LoadingPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     getLocation(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.lightBlue[100],
//         elevation: 0.0,  // appBar가 살짝 떠있는 듯한 연출
//       ),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         color: Colors.lightBlue[100],
//         child: Center(
//           child: Container(
//             child: CircularProgressIndicator(
//               // 원형으로 돌아가는 Progress 바
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// void getLocation(context) async{
//   await Geolocator.requestPermission(); // 권한 설정 여부 알림창 -> await 필요!
//   Position position = await Geolocator.getCurrentPosition(); // 현재 위치 설정
//
//   double lat = position.latitude;
//   double lon = position.longitude;
//
//   print("lat: $lat, lon: $lon");
//   getWeather(lat, lon, context);
// }
//
// void getWeather(double lat, double lon, context) async{
//   String url = "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=311b37be82274842eb40377115dbd958&units=metric";
//   print(url);
//   Response res = await get(Uri.parse(url));
//   print(res.body);
//
//   SampleWeather w1 = sampleWeatherFromJson(res.body);
//
//
//   // 페이지 이동
//   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
//     return SolarEnv(
//       w:w1, // 앞 w : weather_main의 매개변수, 뒤 w1 : sampleweather
//     );
//   }), (route)=>false);
// }