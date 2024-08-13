import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/db/tb_board.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {

  final String _url = 'http://10.0.2.2:3000/boardsql/bselect'; // 서버 URL
  List<Boards> _boards = []; // Boards 객체 리스트
  String _error = '';
  var index = 0;

  @override
  void initState() {
    super.initState();
    _sendQuery(); // 위젯에서 받은 SQL 쿼리를 사용합니다.
  }

  Future<void> _sendQuery() async {
    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        // print("연결 성공");
        // print(jsonResponse);

        if (jsonResponse is Map<String, dynamic>) {
          // 단일 객체인 경우
          final boards = Boards.fromJson(jsonResponse);
          setState(() {
            _boards = [boards];
            // print(_boards);
          });
        } else if (jsonResponse is List) {
          // 배열인 경우
          final boards = jsonResponse.map((data) {
            if (data is Map<String, dynamic>) {
              return Boards.fromJson(data);
            } else {
              return null; // 데이터가 올바른 형식이 아닌 경우
            }
          }).whereType<Boards>().toList();

          setState(() {
            _boards = boards;
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Image.asset('image/solQuiz_logo3.png', width: 110,),
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                icon: Icon(Icons.notifications),
                style: ButtonStyle(
                  iconColor: MaterialStateProperty.all<Color>(Colors.black54),
                ),
                onPressed: () {
                  print('icon alert');
                },
              ),
              IconButton(
                icon: Icon(Icons.logout_outlined),
                style: ButtonStyle(
                  iconColor: MaterialStateProperty.all<Color>(Colors.black54),
                ),
                onPressed: () {
                  print('icon logout');
                },
              ),
            ]
        ),
        body: _error.isNotEmpty
                ? Center(child: Text(_error),)
                : _boards.isEmpty
                ? Center(child: CircularProgressIndicator(
                    color: Colors.white,
                ))
                : ListView.builder(
                shrinkWrap: true,
                itemCount: _boards[0].B_IDX.length,
                itemBuilder: (context, index) {
                  return Center(
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
                                Container(
                                  child: Image.asset(
                                    'image/solQuiz_logo3.png', width: 150,),
                                  padding: EdgeInsets.fromLTRB(80, 30, 20, 30),
                                ),
                                SizedBox(height: 8,),
                                Text(
                                  '${_boards[0].B_TITLE[index]}',
                                  style: TextStyle(fontSize: 18, color: Color(
                                      0xff1e1e1e)),),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                        ]
                    ),
                  );
                })
        );
  }
}
