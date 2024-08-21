import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'navigationBar.dart';

// import 'weather/navigationBar.dart';

const kakaoUserIdKey = "kakao_user_id";

class KakaoLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => KakaoLoginWebView(),
        ));
      },
      child: Text('Login with Kakao'),
    );
  }
}

class KakaoLoginWebView extends StatefulWidget {
  @override
  _KakaoLoginWebViewState createState() => _KakaoLoginWebViewState();
}

class _KakaoLoginWebViewState extends State<KakaoLoginWebView> {
  late WebViewController _controller;
  dynamic userInfo = '';
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kakao Login WebView')),
      body: WebView(
        initialUrl: 'http://192.168.219.54:3000/kakaosql/auth/kakao',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        navigationDelegate: (NavigationRequest request) async {
          print("여긴 실행되냐?");
          if (request.url.startsWith('james://')) {
            print(request.url);
            print("ㅋㅋ이게 뭐냐");
            final uri = Uri.parse(request.url);

            final userState = uri.host.split('+')[1];
            final userinfo = request.url.split('+')[0];
            final userid = (userinfo.split('~')[0]).split("//")[1];
            final useremail = userinfo.split('~')[1];
            await storage.write(
                key: 'login',
                value: userid
            );
            print("아 왜 안돼 : ${request.url}");
            if (userState == "200") {
              print("내가 가져온 정보 : ${userinfo}");
              print("이메일? : ${useremail}");
              _asyncMethod();


              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Navigationbar()),
              );
            }

            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }

  _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    // 데이터가 없을때는 null을 반환
    userInfo = await storage.read(key:'login');

    // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어가게 합니다.
    if (userInfo != null) {
      print('로그인 _asyncMethod userInfo : ' + userInfo);


      Navigator.push(context, MaterialPageRoute(builder: (_) => Navigationbar()));
    } else {
      print('로그인이 필요합니다');
    }
  }
}

