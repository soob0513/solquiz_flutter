import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'db/tb_prediction.dart';
import 'provider.dart';


import 'package:syncfusion_flutter_charts/charts.dart';

class Predict extends StatefulWidget {

  // DB 통신
  final String sqlQuery; // SQL 쿼리를 매개변수로 받아옵니다.

  Predict({required this.sqlQuery});

  @override
  State<Predict> createState() => _PredictState();
}

class _PredictState extends State<Predict> {


  final String _url = 'http://10.0.2.2:3000/query'; // 서버 URL
  List<TbPrediction> _tbPrediction = [];
  String _error = '';

  @override
  void initState() {
    super.initState();
    _sendQuery(widget.sqlQuery); // 위젯에서 받은 SQL 쿼리를 사용합니다.
  }

  Future<void> _sendQuery(String query) async {
    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({'sql': query}),
      );

      if (response.statusCode == 200) {
        // 응답 본문을 JSON으로 디코딩
        final dynamic jsonResponse = json.decode(response.body);

        // JSON 데이터가 객체인지 배열인지 확인
        if (jsonResponse is List) {
          setState(() {
            _tbPrediction = jsonResponse
                .map((data) => TbPrediction.fromJson(data as Map<String, dynamic>))
                .toList();
          });
        } else if (jsonResponse is Map) {
          setState(() {
            _tbPrediction = [TbPrediction.fromJson(jsonResponse as Map<String, dynamic>)];
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

  // =================DB 통신 끝=====================

  final List<ChartData> chartData = <ChartData>[
    // ChartData('6', 24, 0, 14),
    // ChartData('7', 25, 0, 15),
    ChartData('8', 13.91, 12.07, 13.23),
    ChartData('9', 24.55, 24.81, 1.06),
    ChartData('10', 34.92, 34.49, 1.23),
    ChartData('11', 42.15, 41.81, 0.81),
    ChartData('12', 46.26, 45.92, 0.73),
    ChartData('13', 46.41, 47.12, 1.53),
    ChartData('14', 46.41, 47.12, 1.53),
    ChartData('15', 46.26, 45.92, 0.73),
    ChartData('16', 42.15, 41.81, 0.81),
    ChartData('17', 34.92, 34.49, 1.23),
    ChartData('18', 24.55, 24.81, 1.06),
    ChartData('19', 13.91, 12.07, 13.23),
    ChartData('20', 5.43, 3.82, 29.65),
    // ChartData('21', 28.5, 0, 16),
    // ChartData('22', 27.5, 0, 14),
  ];

  // 날짜 선택
  DateTime initialDay = DateTime.now();
  var predict_date;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset('image/solQuiz_logo3.png',width: 110,),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            style: ButtonStyle(
              iconColor: MaterialStateProperty.all<Color>(Colors.black54),
            ),
            onPressed: (){
              print('icon alert');
            },
          ),
          IconButton(
            icon: Icon(Icons.logout_outlined),
            style: ButtonStyle(
              iconColor: MaterialStateProperty.all<Color>(Colors.black54),
            ),
            onPressed: (){
              print('icon logout');
            },
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(10),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('발전량 예측', style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,),),
                      Container(
                        width: 150,
                        height: 35,
                        margin: EdgeInsets.fromLTRB(15, 20, 10, 15),

                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26, width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,

                          children: [
                            Text(
                              '${initialDay.year} - ${initialDay.month} - ${initialDay.day}',
                              style: TextStyle(fontSize: 17,color: Colors.black54),
                            ),
                            IconButton(
                              onPressed: () async{
                                final DateTime? dateTime = await showDatePicker(
                                    context: context,
                                    initialDate: initialDay,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(3000),

                                    // custom
                                    builder: (context, child){
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: Color(0xffff9201), // header background color
                                            // onPrimary: Colors.purple,  // header text color
                                            onSurface: Colors.black87,  // body text color
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Color(0xffffb15a),
                                            ),
                                          ),
                                        ), child: child!,
                                      );
                                    }
                                );
                                if (dateTime != null){
                                  setState(() {
                                    initialDay = dateTime;
                                  });
                                }
                              }, icon: Icon(Icons.calendar_month, size: 18, color: Colors.black54,),),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 450,
                    margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child: SfCartesianChart(
                        legend: Legend(
                          isVisible: true,
                          position: LegendPosition.bottom,
                        ),
                          primaryXAxis: CategoryAxis(),
                          primaryYAxis: CategoryAxis(
                            minimum: 0,
                            // maximum: 35,
                            interval: 0.05,
                            majorGridLines: const MajorGridLines(width: 0),
                          ),
                          palette: <Color>[
                            Colors.red,
                            Colors.blueAccent,
                          ],
                          series: <CartesianSeries>[
                            // Render column series
                            LineSeries<ChartData, String>(
                                name: '예측 발전량',
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                            ),
                            // Render line series
                            LineSeries<ChartData, String>(
                                name: '실제 발전량',
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.z,
                            ),
                          ]
                      )
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        minimumSize: Size(30,10),
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, '/predictmore');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('자세히 보기', style: TextStyle(fontSize: 13, color: Colors.black54,),),
                          SizedBox(width: 5,),
                          Icon(Icons.arrow_forward, size: 20,color: Colors.black54,),
                        ],
                      ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.z, this.a);
  final String x;
  final double? y;  // 예측 발전량
  final double? z;  // 실제 발전량
  final double? a;  // 오차율
}

// class PredictDate {
//   DateTime initialDay = DateTime.now();
// }