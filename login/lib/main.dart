import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() {
  KakaoSdk.init(nativeAppKey: '여기에_네이티브_앱_키를_입력');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: KakaoLoginExample(),
    );
  }
}

class KakaoLoginExample extends StatefulWidget {
  const KakaoLoginExample({super.key});

  @override
  _KakaoLoginExampleState createState() => _KakaoLoginExampleState();
}

class _KakaoLoginExampleState extends State<KakaoLoginExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카카오 로그인 예제'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('카카오톡으로 로그인'),
              onPressed: () async {
                try {
                  final token = await UserApi.instance.loginWithKakaoTalk();
                  _showMessage('카카오톡 로그인 성공, 토큰: ${token.accessToken}');
                } catch (error) {
                  _showMessage('카카오톡 로그인 실패, 에러: $error');
                  try {
                    final token =
                        await UserApi.instance.loginWithKakaoAccount();
                    _showMessage('카카오계정 로그인 성공, 토큰: ${token.accessToken}');
                  } catch (error) {
                    _showMessage('카카오계정 로그인 실패, 에러: $error');
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
