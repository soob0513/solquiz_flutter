import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool IdSearch = true;
  bool PwSearch = false;

  TextEditingController nameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();

  void _IdSearch() {
    setState(() {
      IdSearch = true;
      PwSearch = false;
    });
  }

  void _PwSearch() {
    setState(() {
      IdSearch = false;
      PwSearch = true;
    });

  }

  Widget _buildContent() {
    if (IdSearch) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              controller: nameCon,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFA3A3A3))),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xfffd9a06))),
                labelText: '이름을 입력해주세요',
                labelStyle: TextStyle(color: Color(0xFFA3A3A3), fontSize: 18),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              controller: emailCon,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFA3A3A3))),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xfffd9a06))),
                labelText: '이메일을 입력해주세요',
                labelStyle: TextStyle(color: Color(0xFFA3A3A3), fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  minimumSize: Size(350, 42),
                  backgroundColor: Color(0xFFFF9201),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
              onPressed: () {
                Navigator.pushNamed(context, '/search2');
              },
              child: Text('아이디 찾기',
                  style: TextStyle(fontSize:19, color: Colors.white)))
        ],
      );
    } else if (PwSearch) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              controller: nameCon,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFA3A3A3))),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xfffd9a06))),
                labelText: '아이디를 입력해주세요',
                labelStyle: TextStyle(color: Color(0xFFA3A3A3), fontSize: 18),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              controller: emailCon,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFA3A3A3))),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xfffd9a06))),
                labelText: '이메일을 입력해주세요',
                labelStyle: TextStyle(color: Color(0xFFA3A3A3), fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  minimumSize: Size(350, 42),
                  backgroundColor: Color(0xFFFF9201),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
              onPressed: () {
                Navigator.pushNamed(context, '/search2');
              },
              child: Text('비밀번호 찾기',
                  style: TextStyle(fontSize: 19, color: Colors.white)))
        ],
      );
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        // title: Text(
        //   '  아이디 / 비밀번호 찾기',
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontSize: 25,
        //     fontFamily: 'Abhaya Libre',
        //     fontWeight: FontWeight.w400,
        //     height: 0.07,
        //     letterSpacing: 0.40,
        //   ),
        // ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('아이디 / 비밀번호 찾기', style: TextStyle(fontSize: 25,),),
                SizedBox(height: 20,),
                Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            child: ElevatedButton(
                              onPressed: _IdSearch,
                              child: Text(
                                '아이디 찾기',
                                style: TextStyle(
                                  color: IdSearch
                                      ? Color(0xfffd9a06)
                                      : Color(0xFFA3A3A3),
                                  fontSize: 20,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shadowColor: Colors.transparent,
                                elevation: 0,
                              ),
                            ),
                          ),
                          Container(
                            width: 193,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: IdSearch
                                      ? Color(0xfffd9a06)
                                      : Color(0xFFA3A3A3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          Container(
                            child: ElevatedButton(
                              onPressed: _PwSearch,
                              child: Text(
                                '비밀번호 찾기',
                                style: TextStyle(
                                  color: PwSearch
                                      ? Color(0xfffd9a06)
                                      : Color(0xFFA3A3A3),
                                  fontSize: 20,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shadowColor: Colors.transparent,
                                elevation: 0,
                              ),
                            ),
                          ),
                          Container(
                            width: 193,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: PwSearch
                                      ? Color(0xfffd9a06)
                                      : Color(0xFFA3A3A3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                _buildContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
