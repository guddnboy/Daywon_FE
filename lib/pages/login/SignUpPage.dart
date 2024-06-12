import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/config.dart';

void main() async {
  runApp(SignupPage());
}

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);

  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required bool obscureText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: double.infinity,
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(fontSize: 13),
            filled: true,
            fillColor: const Color(0xFFD9D9D9),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignupButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => _signUp(context),
          style: ElevatedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            backgroundColor: const Color(0xFF4399FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: const Text(
            '회원가입하기',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  void _signUp(BuildContext context) async {
    try {
      // 입력값 검증
      if (_isInputEmpty()) {
        _showDialog(context, '입력 필요', '모든 필드를 입력해주세요.');
        return;
      }

      final serverUri = Config.apiUrl; // Config 클래스를 사용하여 서버 URI 가져오기
      final response = await http.post(
        Uri.parse('$serverUri/users/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': idController.text,
          'nickname': nicknameController.text,
          'e_mail': emailController.text,
          'level': '1',
          'user_point': 0,
          'profile_image': 0,
          'hashed_password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        _showDialog(context, '회원가입 성공', '회원가입이 성공적으로 완료되었습니다.');
      } else {
        _showDialog(
            context, '회원가입 실패', '회원가입에 실패했습니다. 에러 코드: ${response.statusCode}');
      }
    } catch (e) {
      _showDialog(context, '오류', '회원가입 중 오류가 발생했습니다: $e');
    }
  }

  // 입력값이 비어있는지 확인하는 메서드
  bool _isInputEmpty() {
    return idController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        emailController.text.isEmpty ||
        nicknameController.text.isEmpty;
  }

  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/img/DayWon.png"),
                    ),
                  ),
                ),
                _buildTextField(
                  controller: idController,
                  labelText: '아이디',
                  obscureText: false,
                ),
                _buildTextField(
                  controller: passwordController,
                  labelText: '비밀번호',
                  obscureText: true,
                ),
                _buildTextField(
                  controller: confirmPasswordController,
                  labelText: '비밀번호 확인',
                  obscureText: true,
                ),
                _buildTextField(
                  controller: emailController,
                  labelText: '이메일',
                  obscureText: false,
                ),
                _buildTextField(
                  controller: nicknameController,
                  labelText: '닉네임',
                  obscureText: false,
                ),
                _buildSignupButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
