import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';


class Predict extends StatefulWidget {
  const Predict({super.key});

  @override
  State<Predict> createState() => _PredictState();
}

class _PredictState extends State<Predict> {
  final List<ChartData> chartData = <ChartData>[
    ChartData('6', 0, 0, 0),
    ChartData('7', 0, 0, 0),
    ChartData('8', 26.5, 0.94, 17),
    ChartData('9', 27.1, 1.22, 14),
    ChartData('10', 29.7, 2.34, 14),
    ChartData('11', 30.4, 2.87, 14),
    ChartData('12', 31.9, 3.29, 16),
    ChartData('13', 33.4, 3.31, 14),
    ChartData('14', 33.5, 3.34, 17),
    ChartData('15', 34, 2.34, 15),
    ChartData('16', 32.1, 1.07, 17),
    ChartData('17', 32.9, 1.31, 16),
    ChartData('18', 32.1, 0.86, 19),
    ChartData('19', 29.1, 0.35, 19),
    ChartData('20', 29.5, 0.04, 17),
    ChartData('21', 28.5, 0, 0),
    ChartData('22', 0, 0, 0),
  ];

  // 표
  /*
  List<User> _users = [
    User('John Doe', 25, 'Developer'),
    User('Jane Smith', 30, 'Designer'),
    User('Alex Johnson', 28, 'Manager'),
  ];
  */

  bool _sortAscending = true;
  int _sortColumnIndex = 0;

  /*
  void _sort<T>(Comparable<T> Function(User user) getField, int columnIndex, bool ascending){
    _users.sort((a,b){
      if (!ascending) {
        final User c = a;
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
  */


  List<EnvData> _envdata = [
    EnvData("20240806", 6, 50),
    EnvData("20240806", 7, 50),
    EnvData("20240806", 8, 50),
    EnvData("20240806", 9, 50),
    EnvData("20240806", 10, 50),
    EnvData("20240806", 11, 50),
    EnvData("20240806", 12, 50),
    EnvData("20240806", 13, 50),
    EnvData("20240806", 14, 50),
  ];

  void _sort<T>(Comparable<T> Function(EnvData envdata) getField, int columnIndex, bool ascending){
    _envdata.sort((a,b){
      if (!ascending) {
        final EnvData c = a;
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



  // 날짜 선택
  DateTime initialDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset('image/solQuiz_logo3.png',width: 120,),
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
      body: SingleChildScrollView(
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
                                            primary: Color(0xffffb15a), // header background color
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
                    margin: EdgeInsets.all(15),
                      child: SfCartesianChart(
                        legend: Legend(
                          isVisible: true,
                          position: LegendPosition.bottom,
                        ),
                          primaryXAxis: CategoryAxis(),
                          primaryYAxis: CategoryAxis(
                            minimum: 10,
                            maximum: 35,
                          ),
                          axes: <ChartAxis>[
                            NumericAxis(
                              name: 'rightAxis',
                              opposedPosition: true,
                              interval: 1,
                              minimum: 0,
                              maximum: 7,
                              // title: AxisTitle(
                              //   text: '일사량'
                              // ),
                            ),
                          ],
                          palette: <Color>[
                            Color(0xffff9201),
                            Colors.deepPurple,
                            Colors.green,
                            // Colors.green,
                          ],
                          series: <CartesianSeries>[
                            // Render column series
                            ColumnSeries<ChartData, String>(
                                name: '기온',
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                            ),
                            // Render line series
                            LineSeries<ChartData, String>(
                                name: '일사량',
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.z,
                                yAxisName: 'rightAxis',
                            ),
                            LineSeries<ChartData, String>(
                              name: '미세먼지',
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.a
                            ),

                          ]
                      )
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        minimumSize: Size(30,10),
                      ),
                      onPressed: (){},
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
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('발전량 표', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),
                      SizedBox(height: 10,),
                      // 날짜 선택
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
                                          primary: Color(0xffffb15a), // header background color
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
                  SizedBox(height: 20,),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states){
                            return const Color(0xffe5e5e5);
                          }
                      ),
                      headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
                      decoration: BoxDecoration(  // 바깥선
                        border: Border.all(color: Colors.black54, width: 1),
                      ),
                      horizontalMargin: 50,
                      columnSpacing: 45,




                      border: TableBorder(  // 중간 구분선
                        borderRadius: BorderRadius.circular(15),
                        verticalInside: BorderSide(color: Colors.black54, width: 0.7),
                      ),

                      sortAscending: _sortAscending,
                      sortColumnIndex: _sortColumnIndex,
                      columns: [
                        DataColumn(
                          label: Expanded(child: Text('시간', style: TextStyle(fontSize: 18))),
                          numeric: true,
                          onSort: (columnIndex, ascending) => _sort<String>((data)=> data.hour.toString(), columnIndex, ascending),
                        ),
                        DataColumn(
                          label: Text('발전량', style: TextStyle(fontSize: 20,),),
                          numeric: true,
                          onSort: (columnIndex, ascending) => _sort<String>((data)=> data.env.toString(), columnIndex, ascending),
                        ),
                      ],
                      rows: _envdata.map((data){
                        return DataRow(
                            cells: [
                              DataCell(Text('${data.hour}', style: TextStyle(fontSize: 16),textAlign: TextAlign.center,),),
                              DataCell(Text('${data.env}', style: TextStyle(fontSize: 16),textAlign: TextAlign.center,)),
                        ]);
                    }).toList(),
                  ),
                  )
                ]
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
  final double? y;
  final double? z;
  final double? a;
}


// DateFormat("yyyy년 MM월 dd일").format(_startDate)
// 표
class EnvData {
  final String date;
  final int hour;
  final int env;

  EnvData(this.date, this.hour, this.env);
}