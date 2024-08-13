import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'member.dart';


class DataFetcher extends StatefulWidget {
  final String sqlQuery; // SQL 쿼리를 매개변수로 받아옵니다.

  DataFetcher({required this.sqlQuery});

  @override
  _DataFetcherState createState() => _DataFetcherState();
}

class _DataFetcherState extends State<DataFetcher> {
  final String _url = 'http://10.0.2.2:3000/query'; // 서버 URL
  List<User> _users = []; // User 객체 리스트
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
            _users = jsonResponse
                .map((data) => User.fromJson(data as Map<String, dynamic>))
                .toList();
          });
        } else if (jsonResponse is Map) {
          setState(() {
            _users = [User.fromJson(jsonResponse as Map<String, dynamic>)];
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
      body: Center(
        child: _error.isNotEmpty
            ? Text(_error) // 에러 메시지 표시
            : _users.isEmpty
            ? Text('No data available') // 데이터가 없는 경우 메시지 표시
            : ListView(
          children: _users.map((user) {
            return Container(
              child: Column(
                children: [
                  Text('Name: ${user.name}'),
                  Text('Email: ${user.email}'),
                  Text('ID: ${user.id}'),
                ],
              ),
            );
          }).toList(),
        ), // User 객체 리스트 표시
      ),
    );
  }
}
