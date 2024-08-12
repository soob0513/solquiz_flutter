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
    // EnvData("20240806", 6, 0.00),
    EnvData("20240806", 7, 10.67),
    EnvData("20240806", 8, 389.74),
    EnvData("20240806", 9, 798.84),
    EnvData("20240806", 10, 1148.27),
    EnvData("20240806", 11, 1382.52),
    EnvData("20240806", 12, 1502.62),
    EnvData("20240806", 13, 1475.49),
    EnvData("20240806", 14, 1381.31),
    EnvData("20240806", 15, 1183.08),
    EnvData("20240806", 16, 990.36),
    EnvData("20240806", 17, 728.40),
    EnvData("20240806", 18, 373.91),
    EnvData("20240806", 19, 56.85),
    // EnvData("20240806", 20, 0.00),
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

                            // title: AxisTitle(
                            //   text: '발전량',
                            //   textStyle: TextStyle(fontSize: 10,)
                            // ),
                          ),
                          // axes: <ChartAxis>[
                          //   NumericAxis(
                          //     name: 'rightAxis',
                          //     opposedPosition: true,
                          //     interval: 1,
                          //     minimum: 0,
                          //     // maximum: 7,
                          //     title: AxisTitle(
                          //       text: '오차율',
                          //       textStyle: TextStyle(fontSize: 10,),
                          //     ),
                          //   ),
                          // ],
                          palette: <Color>[
                            // Color(0xffff9201),
                            Colors.red,
                            Colors.blueAccent,

                            // Colors.red,
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
                            // LineSeries<ChartData, String>(
                            //   name: '오차율',
                            //     dataSource: chartData,
                            //     xValueMapper: (ChartData data, _) => data.x,
                            //     yValueMapper: (ChartData data, _) => data.a
                            // ),
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
            // Container(
            //   width: double.infinity,
            //   margin: EdgeInsets.all(10),
            //   padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(12),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.withOpacity(0.5),
            //         spreadRadius: 1.5,
            //         blurRadius: 5,
            //         offset: Offset(0, 3), // 그림자 위치 변경
            //       ),
            //     ],
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text('발전량 표', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),
            //           SizedBox(height: 10,),
            //           // 날짜 선택
            //           Container(
            //             width: 150,
            //             height: 35,
            //             margin: EdgeInsets.fromLTRB(15, 20, 10, 15),
            //
            //             decoration: BoxDecoration(
            //                 border: Border.all(color: Colors.black26, width: 1),
            //             ),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.end,
            //
            //               children: [
            //                 Text(
            //                   '${initialDay.year} - ${initialDay.month} - ${initialDay.day}',
            //                   style: TextStyle(fontSize: 17,color: Colors.black54),
            //                 ),
            //                 IconButton(
            //                   onPressed: () async{
            //                   final DateTime? dateTime = await showDatePicker(
            //                       context: context,
            //                       initialDate: initialDay,
            //                       firstDate: DateTime(2000),
            //                       lastDate: DateTime(3000),
            //
            //                       // custom
            //                     builder: (context, child){
            //                         return Theme(
            //                           data: Theme.of(context).copyWith(
            //                             colorScheme: ColorScheme.light(
            //                               primary: Color(0xffffb15a), // header background color
            //                               // onPrimary: Colors.purple,  // header text color
            //                               onSurface: Colors.black87,  // body text color
            //                             ),
            //                             textButtonTheme: TextButtonThemeData(
            //                               style: TextButton.styleFrom(
            //                                 foregroundColor: Color(0xffffb15a),
            //                               ),
            //                             ),
            //                           ), child: child!,
            //                         );
            //                     }
            //                   );
            //                   if (dateTime != null){
            //                     setState(() {
            //                       initialDay = dateTime;
            //                     });
            //                   }
            //                 }, icon: Icon(Icons.calendar_month, size: 18, color: Colors.black54,),),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //       SizedBox(height: 20,),
            //       SingleChildScrollView(
            //         scrollDirection: Axis.vertical,
            //         child: FittedBox(
            //           child: DataTable(
            //             headingRowColor: MaterialStateColor.resolveWith(
            //                 (states){
            //                   return const Color(0xffe5e5e5);
            //                 }
            //             ),
            //             headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
            //             decoration: BoxDecoration(  // 바깥선
            //               border: Border.all(color: Colors.black54, width: 1),
            //             ),
            //             horizontalMargin: 35,
            //
            //             headingRowHeight: 40,
            //             dataRowHeight: 35,
            //             columnSpacing: 51,
            //
            //             border: TableBorder(  // 중간 구분선
            //               borderRadius: BorderRadius.circular(15),
            //               verticalInside: BorderSide(color: Colors.black54, width: 0.7),
            //             ),
            //
            //             // sortAscending: _sortAscending,
            //             // sortColumnIndex: _sortColumnIndex,
            //             columns: [
            //               DataColumn(
            //                 label: Center(child: Text('  시간', style: TextStyle(fontSize: 17), textAlign: TextAlign.center,)),
            //                 // numeric: true,
            //                 onSort: (columnIndex, ascending) => _sort<String>((data)=> data.hour.toString(), columnIndex, ascending),
            //               ),
            //               DataColumn(
            //                 label: Expanded(child: Center(child: Text('     발전량', style: TextStyle(fontSize: 17,), textAlign: TextAlign.right,))),
            //                 // numeric: true,
            //                 onSort: (columnIndex, ascending) => _sort<String>((data)=> data.env.toString(), columnIndex, ascending),
            //               ),
            //             ],
            //             rows: _envdata.map((data){
            //               return DataRow(
            //                   cells: [
            //                     DataCell(
            //                       Align(
            //                         alignment: Alignment.center,
            //                           child : Text('${data.hour}   ',
            //                           style: TextStyle(fontSize: 16),
            //                           ))),
            //                     DataCell(
            //                       Align(
            //                         alignment: Alignment.center,
            //                           child : Text(' ${data.env}',
            //                           style: TextStyle(fontSize: 16),
            //                           ),)),
            //               ]);
            //           }).toList(),
            //                             ),
            //         ),
            //       )
            //     ]
            //   ),
            // ),
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


// DateFormat("yyyy년 MM월 dd일").format(_startDate)
// 표
class EnvData {
  final String date;
  final double? hour;
  final double? env;

  EnvData(this.date, this.hour, this.env);
}