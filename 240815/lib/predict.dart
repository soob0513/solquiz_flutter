import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'appbar.dart';
import 'db/tb_prediction.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Predict extends StatefulWidget {
  @override
  State<Predict> createState() => _PredictState();
}

class _PredictState extends State<Predict> {
  final String _url = 'http://10.0.2.2:3000/predsql/predselect'; // 서버 URL
  List<TbPrediction> _tbPrediction = [];
  String _error = '';

  // 날짜 선택
  DateTime initialDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _sendQuery(); // 초기 데이터 로드
  }

  Future<void> _sendQuery() async {
    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({'initialDay': '${initialDay.year}-${initialDay.month}-${initialDay.day}'}),
      );

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        print("연결 성공");
        print(jsonResponse);

        if (jsonResponse is Map<String, dynamic>) {
          // 단일 객체인 경우
          print("단일 객체란다 ㅋㅋ");
          final predictions = TbPrediction.fromJson(jsonResponse);
          setState(() {
            _tbPrediction = [predictions];
            print("제발 들어가 이새끼야1 : ${_tbPrediction[0].created_at}");
          });
        } else if (jsonResponse is List) {
          // 배열인 경우
          print("배열이란다 ㅋㅋ");
          final predictions = jsonResponse.map((data) {
            if (data is Map<String, dynamic>) {
              return TbPrediction.fromJson(data);
            } else {
              return null; // 데이터가 올바른 형식이 아닌 경우
            }
          }).whereType<TbPrediction>().toList();

          setState(() {
            _tbPrediction = predictions;
            print("제발 들어가 이새끼야2 : ${_tbPrediction}");
          });
        } else {
          setState(() {
            _error = 'Unexpected JSON format';
            print("막장 인생 ");
          });
        }
      } else {
        setState(() {
          _error = 'Failed to execute query';
          print("개막장 인생 :");
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        print("ㅈㄴ 개막장 인생 : ${e}");
      });
    }
    _updateChartData();
  }

  void _updateChartData() {
    setState(() {
      chartData.clear(); // 기존 데이터 제거

      // Ensure _tbPrediction is not empty
      if (_tbPrediction.isNotEmpty) {
        // Ensure the lists within _tbPrediction[0] are not null and have data
        final predDates = _tbPrediction[0].created_at ?? [];
        final predPowers = _tbPrediction[0].pred_power ?? [];
        final actuals = _tbPrediction[0].actual ?? [];

        print("쓰레기 1 : ${predDates}");
        print("쓰레기 2 : ${predPowers}");
        print("쓰레기 3 : ${actuals}");
        if (predDates.length == predPowers.length && predPowers.length == actuals.length) {
          for (int i = 0; i < predDates.length; i++) {
            chartData.add(
              ChartData(
                predDates[i].substring(10,13) ?? 'Unknown', // Null 값을 방지
                predPowers[i] ?? 0.0,     // Null 값을 방지
                actuals[i] ?? 0.0,         // Null 값을 방지
                (predPowers[i] - actuals[i]).abs() / actuals[i] * 100,
              ),
            );
          }
        } else {
          print('Data lists are not of the same length or are null');
        }
      } else {
        print('No data available in _tbPrediction');
      }

      print(chartData);
    });
  }



  final List<ChartData> chartData = <ChartData>[];



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Appbar(),
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
                        Text('발전량 예측', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
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
                                style: TextStyle(fontSize: 17, color: Colors.black54),
                              ),
                              IconButton(
                                onPressed: () async {
                                  final DateTime? dateTime = await showDatePicker(
                                    context: context,
                                    initialDate: initialDay,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(3000),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: Color(0xffff9201), // header background color
                                            onSurface: Colors.black87,  // body text color
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Color(0xffffb15a),
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (dateTime != null) {
                                    setState(() {
                                      initialDay = dateTime;
                                      _sendQuery(); // 선택한 날짜로 데이터 다시 불러오기
                                    });
                                  }
                                },
                                icon: Icon(Icons.calendar_month, size: 18, color: Colors.black54),
                              ),
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
                              LineSeries<ChartData, String>(
                                name: '예측 발전량',
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x!,
                                yValueMapper: (ChartData data, _) => data.y ?? 0.0, // Null 값을 방지
                              ),
                              LineSeries<ChartData, String>(
                                name: '실제 발전량',
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x!,
                                yValueMapper: (ChartData data, _) => data.z ?? 0.0, // Null 값을 방지
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
                      onPressed: () {
                        // 데이터를 전달할 때 리스트로 감싸서 전달
                        Navigator.pushNamed(
                            context,
                            '/predictmore',
                            arguments: '${initialDay.year}-0${initialDay.month}-${initialDay.day}'
                        );
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
      ),
    );
  }
}

//${initialDay.year}-${initialDay.month}-${initialDay.day}
class ChartData {
  ChartData(this.x, this.y, this.z, this.err);
  final String? x; // X축 데이터
  final double? y; // 예측 발전량
  final double? z; // 실제 발전량
  final double? err; // 실제 발전량
}

