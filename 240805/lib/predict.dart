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
    ChartData('6', 129 ,90),
    ChartData('7', 90, 50),
    ChartData('8', 107, 40),
    ChartData('9', 68, 70),
    ChartData('10', 129,42),
    ChartData('11', 90, 20),
    ChartData('12', 107, 80),
    ChartData('13', 68, 70),
    ChartData('14', 129, 30),
    ChartData('15', 90, 50),
    ChartData('16', 107, 80),
    ChartData('17', 68, 70),
    ChartData('18', 129, 62),
    ChartData('19', 90, 20),
    ChartData('20', 107, 40),
    ChartData('21', 68, 80),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset('image/solQuiz_logo1.png',width: 130,),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            style: ButtonStyle(
              iconColor: MaterialStateProperty.all<Color>(Colors.grey),
            ),
            onPressed: (){
              print('icon alert');
            },
          ),
          IconButton(
            icon: Icon(Icons.logout_outlined),
            style: ButtonStyle(
              iconColor: MaterialStateProperty.all<Color>(Colors.grey),
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
            // Container(
            //   width: double.infinity,
            //   height: 50,
            //   padding: EdgeInsets.fromLTRB(12, 0, 0, 5),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('발전량 페이지', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),
            //     ],
            //   ),
            // ),
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
                  Text('발전량 예측', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),
                  SizedBox(height: 10,),
                  Text('2024년 8월 2일', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                  Container(
                    margin: EdgeInsets.all(15),
                      child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          palette: <Color>[
                            Color(0xfffd9a06),
                            Colors.deepPurple,
                          ],
                          series: <CartesianSeries>[
                            // Render column series
                            ColumnSeries<ChartData, String>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y
                            ),
                            // Render line series
                            LineSeries<ChartData, String>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y
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
                  Text('발전량 표', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),
                  SizedBox(height: 10,),
                  Image.asset('image/nim.jpg'),
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
  ChartData(this.x, this.y, this.z);
  final String x;
  final double? y;
  final double? z;
}
