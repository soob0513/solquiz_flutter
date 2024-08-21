import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:solquiz_2/changePw.dart';
import 'package:solquiz_2/db/tb_member.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'db/tb_solarplant.dart';

class PlantInfo extends StatefulWidget {
  const PlantInfo({super.key});

  @override
  State<PlantInfo> createState() => _PlantInfoState();
}

class _PlantInfoState extends State<PlantInfo> {

  // 1. 발전소 정보 가져오기
  final String _url = 'http://192.168.219.54:3000/solarplant/plantname';

  final storage = FlutterSecureStorage();
  dynamic userInfo = '';

  List<SolarPlant> _solarplant = []; // Boards 객체 리스트
  String _error = '';

  @override
  void initState() {
    super.initState();
    _plant_name();
  }


  // 발전소 정보 가져오기
  Future<void> _plant_name() async {
    userInfo = await storage.read(key: 'login');
    print('checkUserState 함수 : '+ userInfo);
    userInfo = json.decode(userInfo);

    try {
      final response = await http.post(
          Uri.parse(_url),
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


  logout() async {
    await storage.delete(key: 'login');
    Navigator.pushNamed(context, '/login');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '내 발전소 정보',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 23,
            fontFamily: 'Abhaya Libre',
            fontWeight: FontWeight.w400,
            height: 0.07,
            letterSpacing: 0.40,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.white,
      ),
      body: _error.isNotEmpty
          ? Center(child: Text(_error),)
          : _solarplant.isEmpty
          ? Container(
        color: Colors.white,
        child: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            )),
      )
          : Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.fromLTRB(33, 0, 33,0),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: Column(
              children:[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text('발전소 이름', style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontFamily: 'Abhaya Libre',
                        fontWeight: FontWeight.w400,)
                      ),
                    ),
                    Container(
                      child: Text('${_solarplant[0].PLANT_NAME[0]}',style: TextStyle(
                        color: Color(0xFFA3A3A3),
                        fontSize: 20,
                        fontFamily: 'Abhaya Libre',
                        fontWeight: FontWeight.w400,
                      ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text('지역 구분', style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontFamily: 'Abhaya Libre',
                        fontWeight: FontWeight.w400,)
                      ),
                    ),
                    Container(
                      child: Text('${_solarplant[0].SB_TYPE[0] == 'Inland'? '내륙' : '해안'}',style: TextStyle(
                        color: Color(0xFFA3A3A3),
                        fontSize: 20,
                        //fontFamily: 'Abhaya Libre',
                        fontWeight: FontWeight.w400,
                      ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text('지역 상세', style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontFamily: 'Abhaya Libre',
                        fontWeight: FontWeight.w400,)
                      ),
                    ),
                    Container(
                      child: Text('${_solarplant[0].PLACE[0]}',style: TextStyle(
                        color: Color(0xFFA3A3A3),
                        fontSize: 20,
                        //fontFamily: 'Abhaya Libre',
                        fontWeight: FontWeight.w400,
                      ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text('발전량', style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontFamily: 'Abhaya Libre',
                        fontWeight: FontWeight.w400,)
                      ),
                    ),
                    Container(
                      child: Text('${_solarplant[0].PLANT_POWER[0]} MWh',style: TextStyle(
                        color: Color(0xFFA3A3A3),
                        fontSize: 20,
                        //fontFamily: 'Abhaya Libre',
                        fontWeight: FontWeight.w400,
                      ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text('발전소 주소', style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontFamily: 'Abhaya Libre',
                        fontWeight: FontWeight.w400,)
                      ),
                    ),
                    Container(
                      child: Text('${_solarplant[0].PLANT_ADDR[0]}',style: TextStyle(
                        color: Color(0xFFA3A3A3),
                        fontSize: 18,
                        //fontFamily: 'Abhaya Libre',
                        fontWeight: FontWeight.w400,
                      ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 420,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(310, 42),
                      backgroundColor: Color(0xFFFF9201),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                  onPressed: () {Navigator.pushNamed(context, '/solarplantname');},
                  child: Text('변경',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
                child: Text('네', style: TextStyle(color: Colors.white),),
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
            TextButton(
              child: Text('아니요'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                  foregroundColor: Color(0xFFA3A3A3)
              ),
            ),
          ],
        );
      },
    );
  }
}
