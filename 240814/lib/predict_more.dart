import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:solquiz_2/board.dart';
import 'package:solquiz_2/recruit.dart';
import 'package:solquiz_2/mainPage.dart';
import 'package:solquiz_2/predict.dart';
import 'package:solquiz_2/myPage.dart';
import 'db/tb_prediction.dart';
import 'dart:math';

class PredictMore extends StatefulWidget {
  const PredictMore({super.key});

  @override
  State<PredictMore> createState() => _PredictMoreState();
}

class _PredictMoreState extends State<PredictMore> {
  final String _url = 'http://10.0.2.2:3000/predsql/predselect'; // 서버 URL
  List<TbPrediction> _tbPrediction = [];
  String _error = '';

  int index = 0;
  List<Widget> pageList = [
    Board(),
    Predict(),
    SolarEnv(),
    Recruit(),
    MyPage(),
  ];

  List<ChartData> _envdata = [];

  bool _sortAscending = true;
  int _sortColumnIndex = 0;

  void _sort<T>(Comparable<T> Function(ChartData envdata) getField, int columnIndex, bool ascending) {
    _envdata.sort((a, b) {
      if (!ascending) {
        final ChartData c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });

    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
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
      _envdata.clear(); // 기존 데이터 제거

      if (_tbPrediction.isNotEmpty) {
        final predDates = _tbPrediction[0].created_at ?? [];
        final predPowers = _tbPrediction[0].pred_power ?? [];
        final actuals = _tbPrediction[0].actual ?? [];

        print("쓰레기 1 : ${predDates}");
        print("쓰레기 2 : ${predPowers}");
        print("쓰레기 3 : ${actuals}");
        if (predDates.length == predPowers.length && predPowers.length == actuals.length) {
          double roundToTwoDecimalPlaces(double value) {
            return (value * 100).round() / 100;
          }
          for (int i = 0; i < predDates.length; i++) {
            _envdata.add(
              ChartData(
                predDates[i].substring(10,13) ?? 'Unknown', // Null 값을 방지
                predPowers[i] ?? 0.0,     // Null 값을 방지
                actuals[i] ?? 0.0,         // Null 값을 방지
                roundToTwoDecimalPlaces((predPowers[i] - actuals[i]).abs() / actuals[i] * 100),
              ),
            );
          }
        } else {
          print('Data lists are not of the same length or are null');
        }
      } else {
        print('No data available in _tbPrediction');
      }
    });
  }

  DateTime initialDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final String initialDayPost = ModalRoute.of(context)!.settings.arguments as String;
      initialDay = DateTime.parse(initialDayPost);
      _sendQuery();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('image/solQuiz_logo3.png', width: 120,),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            color: Colors.black54,
            onPressed: () {
              print('icon alert');
            },
          ),
          IconButton(
            icon: Icon(Icons.logout_outlined),
            color: Colors.black54,
            onPressed: () {
              print('icon logout');
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Center(
              child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(
                        width: 350,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color : Colors.grey.withOpacity(0.5),
                              spreadRadius: 1.5,
                              blurRadius: 5,
                              offset: Offset(0,3),
                            ),
                          ],
                        ),
                        child : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('발전량 표', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),
                                        SizedBox(height: 10,),
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
                                                              primary: Color(0xffff9201),
                                                              onSurface: Colors.black87,
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
                                                  if (dateTime != null) {
                                                    setState(() {
                                                      initialDay = dateTime;
                                                      _sendQuery();
                                                    });
                                                  }
                                                },
                                                icon: Icon(Icons.calendar_month, size: 18, color: Colors.black54,),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: FittedBox(
                                        child: DataTable(
                                          headingRowColor: MaterialStateColor.resolveWith(
                                                (states) => const Color(0xffe5e5e5),
                                          ),
                                          headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black54, width: 1),
                                          ),
                                          horizontalMargin: 0,
                                          headingRowHeight: 40,
                                          dataRowHeight: 35,
                                          columnSpacing: 0,
                                          border: TableBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            verticalInside: BorderSide(color: Colors.black54, width: 0.7),
                                          ),
                                          columns: [
                                            DataColumn(
                                              label: Center(child: Text('   시간', style: TextStyle(fontSize: 15), textAlign: TextAlign.center,)),
                                              onSort: (columnIndex, ascending) => _sort<String>((data) => data.x.toString(), columnIndex, ascending),
                                            ),
                                            DataColumn(
                                              label: Expanded(child: Center(child: Text('   예측 발전량', style: TextStyle(fontSize: 15,), textAlign: TextAlign.right,))),
                                              onSort: (columnIndex, ascending) => _sort<String>((data) => data.y.toString(), columnIndex, ascending),
                                            ),
                                            DataColumn(
                                              label: Expanded(child: Center(child: Text('   실제 발전량', style: TextStyle(fontSize: 15,), textAlign: TextAlign.right,))),
                                              onSort: (columnIndex, ascending) => _sort<String>((data) => data.z.toString(), columnIndex, ascending),
                                            ),
                                            DataColumn(
                                              label: Expanded(child: Center(child: Text('  오차율', style: TextStyle(fontSize: 15,), textAlign: TextAlign.right,))),
                                              onSort: (columnIndex, ascending) => _sort<String>((data) => data.err.toString(), columnIndex, ascending),
                                            ),
                                          ],
                                          rows: _envdata.map((data) {
                                            return DataRow(
                                                cells: [
                                                  DataCell(
                                                      Align(
                                                        alignment: Alignment.center,
                                                        child: Text('${data.x}   ', style: TextStyle(fontSize: 16)),
                                                      )
                                                  ),
                                                  DataCell(
                                                      Align(
                                                        alignment: Alignment.center,
                                                        child: Text(' ${data.y}', style: TextStyle(fontSize: 16)),
                                                      )
                                                  ),
                                                  DataCell(
                                                      Align(
                                                        alignment: Alignment.center,
                                                        child: Text(' ${data.z}', style: TextStyle(fontSize: 16)),
                                                      )
                                                  ),
                                                  DataCell(
                                                      Align(
                                                        alignment: Alignment.center,
                                                        child: Text(' ${data.err}', style: TextStyle(fontSize: 16)),
                                                      )
                                                  ),
                                                ]
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    )
                                  ]
                              ),
                            ]
                        )
                    )
                  ]
              )
          )
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: onItemTap,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.campaign), label : '공지사항',),
            BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label : '발전량예측',),
            BottomNavigationBarItem(icon: Icon(Icons.wb_sunny_rounded), label : '태양광',),
            BottomNavigationBarItem(icon: Icon(Icons.assignment), label : '모집게시판',),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), label : '마이페이지',),
          ],
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor: const Color(0xffff9201),
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(size: 27),
          unselectedIconTheme: IconThemeData(size: 27),
          selectedLabelStyle: TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  void onItemTap(int i) {
    setState(() {
      index = i;
    });
  }
}

class ChartData {
  ChartData(this.x, this.y, this.z, this.err);
  final String? x; // X축 데이터
  final double? y; // 예측 발전량
  final double? z; // 실제 발전량
  final double? err; // 오차율
}
