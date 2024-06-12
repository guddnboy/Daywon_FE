import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/config.dart'; // Config 클래스를 import 합니다.

void main() async {
  runApp(const SignupPage());
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();

  bool isNicknameChecked = false;
  bool isEmailChecked = false;

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required bool obscureText,
    Widget? suffix,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                obscureText: obscureText,
                decoration: InputDecoration(
                  labelText: labelText,
                  labelStyle: const TextStyle(fontSize: 13),
                  filled: true,
                  fillColor: const Color(0xFFD9D9D9),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            if (suffix != null)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: suffix,
              ),
          ],
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

      if (!isNicknameChecked) {
        _showDialog(context, '중복 확인 필요', '닉네임 중복 확인을 해주세요.');
        return;
      }

      if (!isEmailChecked) {
        _showDialog(context, '중복 확인 필요', '이메일 중복 확인을 해주세요.');
        return;
      }

      if (passwordController.text != confirmPasswordController.text) {
        _showDialog(context, '비밀번호 오류', '비밀번호가 일치하지 않습니다.');
        return;
      }

      final serverUri = Config.apiUrl; // Config 클래스를 사용하여 서버 URI 가져오기

      final response = await http.post(
        Uri.parse('$serverUri/users/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': nameController.text,
          'nickname': nicknameController.text,
          'e_mail': emailController.text,
          'level': '1',
          'user_point': 0,
          'profile_image': 1,
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

  void _checkNickname(BuildContext context) async {
    final serverUri = Config.apiUrl;
    final nickname = nicknameController.text;
    final response = await http.get(
      Uri.parse('$serverUri/users/check_nickname/$nickname'),
    );

    if (response.statusCode == 200) {
      final isNicknameExists = jsonDecode(response.body)['exists'];
      if (isNicknameExists) {
        _showDialog(context, '중복 오류', '이미 사용 중인 닉네임입니다.');
        isNicknameChecked = false;
      } else {
        _showDialog(context, '확인 완료', '사용 가능한 닉네임입니다.');
        setState(() {
          isNicknameChecked = true;
        });
      }
      // 중복 검사 결과를 출력합니다.
      print('닉네임 중복 검사 결과: $isNicknameExists');
    } else {
      _showDialog(context, '오류', '닉네임 확인 중 오류가 발생했습니다.');
    }
  }

  void _checkEmail(BuildContext context) async {
    final serverUri = Config.apiUrl;
    final email = emailController.text;
    final response = await http.get(
      Uri.parse('$serverUri/users/check_email/$email'),
    );

    if (response.statusCode == 200) {
      final isEmailExists = jsonDecode(response.body)['exists'];
      if (isEmailExists) {
        _showDialog(context, '중복 오류', '이미 사용 중인 이메일입니다.');
        isEmailChecked = false;
      } else {
        _showDialog(context, '확인 완료', '사용 가능한 이메일입니다.');
        setState(() {
          isEmailChecked = true;
        });
      }
      // 중복 검사 결과를 출력합니다.
      print('이메일 중복 검사 결과: $isEmailExists');
    } else {
      _showDialog(context, '오류', '이메일 확인 중 오류가 발생했습니다.');
    }
  }

  void _checkPassword(BuildContext context) {
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (password == confirmPassword) {
      _showDialog(context, '확인 완료', '비밀번호가 일치합니다.');
    } else {
      _showDialog(context, '일치하지 않음', '비밀번호와 비밀번호 확인이 일치하지 않습니다.');
      // 입력 데이터 초기화
      passwordController.clear();
      confirmPasswordController.clear();
    }
  }

  // 입력값이 비어있는지 확인하는 메서드
  bool _isInputEmpty() {
    return nameController.text.isEmpty ||
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
                  controller: nameController,
                  labelText: '이름',
                  obscureText: false,
                ),
                _buildTextField(
                  controller: nicknameController,
                  labelText: '닉네임',
                  obscureText: false,
                  suffix: TextButton(
                    onPressed: () => _checkNickname(context),
                    child: const Text('중복검사'),
                  ),
                ),
                _buildTextField(
                  controller: emailController,
                  labelText: '이메일',
                  obscureText: false,
                  suffix: TextButton(
                    onPressed: () => _checkEmail(context),
                    child: const Text('중복검사'),
                  ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _checkPassword(context),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20.0),
                        backgroundColor: const Color(0xFF4399FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        '비밀번호 확인',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
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
