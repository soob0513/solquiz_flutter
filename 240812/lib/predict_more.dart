import 'package:flutter/material.dart';
import 'package:solquiz_2/board.dart';
import 'package:solquiz_2/recruit.dart';
import 'package:solquiz_2/mainPage.dart';
import 'package:solquiz_2/predict.dart';
import 'package:solquiz_2/myPage.dart';

class PredictMore extends StatefulWidget {
  const PredictMore({super.key});


  @override
  State<PredictMore> createState() => _PredictMoreState();
}

class _PredictMoreState extends State<PredictMore> {

  int index = 0;
  List<Widget> pageList = [
    Board(sqlQuery: 'select * from TB_BOARD '),
    Predict(sqlQuery: 'SELECT * FROM TB_PREDICTION WHERE PRED_IDX = 67',),
    SolarEnv(),
    Recruit(),
    MyPage()];

  List<EnvData> _envdata = [
    EnvData("20240806", 6, 13.91, 12.07, 13.23),
    EnvData("20240806", 7, 24.55, 24.81, 1.06),
    EnvData("20240806", 8, 34.92, 34.49, 1.23),
    EnvData("20240806", 9, 42.15, 41.81, 0.81),
    EnvData("20240806", 10, 46.26, 45.92, 0.73),
    EnvData("20240806", 11, 46.41, 47.12, 1.53),
    EnvData("20240806", 12, 46.41, 47.12, 1.53),
    EnvData("20240806", 13, 46.26, 45.92, 0.73),
    EnvData("20240806", 14, 42.15, 41.81, 0.81),
    EnvData("20240806", 15, 34.92, 34.49, 1.23),
    EnvData("20240806", 16, 24.55, 24.81, 1.06),
    EnvData("20240806", 17, 13.91, 12.07, 13.23),
    EnvData("20240806", 18, 5.43, 3.82, 29.65),
  ];

  bool _sortAscending = true;
  int _sortColumnIndex = 0;

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
        // controller: _controller,
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
                      offset: Offset(0,3),  // 그림자 위치 변경
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
                          SizedBox(height: 20,),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: FittedBox(
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
                                horizontalMargin: 0,
                              
                                headingRowHeight: 40,
                                dataRowHeight: 35,
                                columnSpacing: 0,
                              
                                border: TableBorder(  // 중간 구분선
                                  borderRadius: BorderRadius.circular(15),
                                  verticalInside: BorderSide(color: Colors.black54, width: 0.7),
                                ),
                              
                                // sortAscending: _sortAscending,
                                // sortColumnIndex: _sortColumnIndex,
                                columns: [
                                  DataColumn(
                                    label: Center(child: Text('   시간', style: TextStyle(fontSize: 15), textAlign: TextAlign.center,)),
                                    // numeric: true,
                                    
                                    onSort: (columnIndex, ascending) => _sort<String>((data)=> data.hour.toString(), columnIndex, ascending),
                                  ),
                                  DataColumn(
                                    label: Expanded(child: Center(child: Text('   예측 발전량', style: TextStyle(fontSize: 15,), textAlign: TextAlign.right,))),
                                    // numeric: true,
                                    onSort: (columnIndex, ascending) => _sort<String>((data)=> data.predictEnv.toString(), columnIndex, ascending),
                                  ),
                                  DataColumn(
                                    label: Expanded(child: Center(child: Text('   실제 발전량', style: TextStyle(fontSize: 15,), textAlign: TextAlign.right,))),
                                    // numeric: true,
                                    onSort: (columnIndex, ascending) => _sort<String>((data)=> data.realEnv.toString(), columnIndex, ascending),
                                  ),
                                  DataColumn(
                                    label: Expanded(child: Center(child: Text('  오차율', style: TextStyle(fontSize: 15,), textAlign: TextAlign.right,))),
                                    // numeric: true,
                                    onSort: (columnIndex, ascending) => _sort<String>((data)=> data.error.toString(), columnIndex, ascending),
                                  ),
                                ],
                                rows: _envdata.map((data){
                                  return DataRow(
                                      cells: [
                                        DataCell(
                                            Align(
                                                alignment: Alignment.center,
                                                child : Text('${data.hour}   ',
                                                  style: TextStyle(fontSize: 16),
                                                ))),
                                        DataCell(
                                            Align(
                                              alignment: Alignment.center,
                                              child : Text(' ${data.predictEnv}',
                                                style: TextStyle(fontSize: 16),
                                              ),)),
                                        DataCell(
                                            Align(
                                              alignment: Alignment.center,
                                              child : Text(' ${data.realEnv}',
                                                style: TextStyle(fontSize: 16),
                                              ),)),
                                        DataCell(
                                            Align(
                                              alignment: Alignment.center,
                                              child : Text(' ${data.error}',
                                                style: TextStyle(fontSize: 16),
                                              ),)),
                                      ]);
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
        // 라벨 스타일
        showSelectedLabels: true,
        showUnselectedLabels: true,

        // bottom 영역 스타일 지정
        backgroundColor: const Color(0xffff9201),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,

        // 디자인
        selectedIconTheme: IconThemeData(
          size: 27,
        ),
        unselectedIconTheme: IconThemeData(
          size: 27,
        ),

        selectedLabelStyle: TextStyle(fontSize: 14,),

      ),
    ),
    );
  }
  void onItemTap(int i){
    setState(() {
      index = i;
    });
  }
}


// DateFormat("yyyy년 MM월 dd일").format(_startDate)
// 표
class EnvData {
  final String date;
  final int hour;
  final double? predictEnv;
  final double? realEnv;
  final double? error;


  EnvData(this.date, this.hour, this.predictEnv, this.realEnv, this.error);
}