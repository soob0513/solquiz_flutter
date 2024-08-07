import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class SolarEnv extends StatefulWidget {
  const SolarEnv({super.key});

  // 위치 정보에 대한 기능을 수행하는 메소드 생성
  void getLocation() async{
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
  }

  @override
  State<SolarEnv> createState() => _SolarEnvState();
}

class _SolarEnvState extends State<SolarEnv> {
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
                  height: 250,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                        begin: const Alignment(0.0, -1.0),
                        end: const Alignment(0.0, 1.0),
                        colors: [Color(0xff008fff), Color(0xff40abff), Colors.white,]
                    ),
                    shape: BoxShape.rectangle,
                  ),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      Row(
                        children: [
                          SizedBox(width: 30,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('30℃', style: TextStyle(fontSize: 38, color: Colors.white),),
                              Text('광주광역시',style: TextStyle(fontSize: 20, color: Colors.white),),
                            ],
                          ),
                          SizedBox(width: 85,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('최저 : 25℃',style: TextStyle(fontSize: 20, color: Colors.white),),
                              Text('최고 : 30℃',style: TextStyle(fontSize: 20, color: Colors.white),),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(height: 5,),
                              Image.asset('image/sun3_remove.png', width: 80,height: 80,),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // -----------두번째 컨테이너---------------
              Positioned(
                top: 160,
                left: 13,
                child: Container(
                  padding: EdgeInsets.all(15),
                  width: 368,
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
                          Text('SolQuiz 발전소', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,),),
                          Text('가동중', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,),),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text('금일 예상 수익', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,),),
                      Text('1,963,000원', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,),),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text('평균 발전시간', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,),),
                              Text('5.11 h', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
                            ],
                          ),
                          SizedBox(width: 100,),
                          Column(
                            children: [
                              Text('금일 발전량', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,),),
                              Text('8,463 kwh', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 150,),
          Row(
            children: [
              SizedBox(width: 20,),
              Text('시장 동향', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
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
                        Text('SMP', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        SizedBox(width: 10,),
                        Text('원/kWh', style: TextStyle(fontSize: 10, color: Colors.grey,),),
                      ],
                    ),
                    SizedBox(height: 7,),
                    Text('오늘 시장 가격', style: TextStyle(fontSize: 15, color: Colors.black54,),),
                    SizedBox(height: 4,),
                    Text('276.67', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),),
                    SizedBox(height: 7,),
                    Text('이번 달 상한 가격', style: TextStyle(fontSize: 15, color: Colors.black54,),),
                    SizedBox(height: 4,),
                    Text('276.67', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff006bb9)),),
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
                        Text('REC', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        SizedBox(width: 10,),
                        Text('원/REC', style: TextStyle(fontSize: 10, color: Colors.grey,),),
                      ],
                    ),
                    Text('65,600', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff006bb9)),),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

    );
  }

}

Widget _container(double width, double height, Widget child) {
  return Container(
    width: width,
    height: height,
    child: child,
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
  );
}
