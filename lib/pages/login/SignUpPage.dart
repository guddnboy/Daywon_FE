import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/config.dart';
import 'package:project/pages/login/LoginPage.dart';
import 'package:project/pages/login/LevelTestPage.dart';

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
  bool isPasswordMatched = false;
  bool isTestDone = false;
  String userLevel = ''; // level 값을 숫자로 받기 위해 int 타입으로 변경

  void updateTestDone(bool testDone) {
    setState(() {
      isTestDone = testDone;
    });
  }

  void updateLevel(String level) {
    // level 값을 String 타입으로 받음
    setState(() {
      userLevel = level;
      if (kDebugMode) {
        print('회원가입페이지 에서의 레벨 : $level');
      }
    });
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required bool obscureText,
    double width = double.infinity,
    Widget? suffix,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: width,
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

  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
    Color? buttonColor,
    bool isVisible = true,
  }) {
    return Visibility(
      visible: isVisible,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signUp(BuildContext context) async {
    try {
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

      if (!isPasswordMatched) {
        _showDialog(context, '비밀번호 확인 필요', '비밀번호가 일치하지 않습니다.');
        return;
      }

      if (!isTestDone) {
        _showDialog(context, '레벨 테스트 미실시', '레벨 테스트를 진행해주세요.');
        return;
      }

      final serverUri = Config.apiUrl;
      final response = await http.post(
        Uri.parse('$serverUri/users/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': nameController.text,
          'nickname': nicknameController.text,
          'e_mail': emailController.text,
          'level': userLevel, // level 값을 숫자로 전송
          'user_point': 0,
          'profile_image': 3,
          'hashed_password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('회원가입 성공: $userLevel');
        } // 회원가입 성공 시 서버에서 반환하는 메시지 출력
        _showDialog(context, '회원가입 성공',
            '회원가입이 성공적으로 완료되었습니다. 당신의 레벨은 $userLevel 입니다. 로그인 페이지로 이동합니다.');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(
              apiUrl: Config.apiUrl,
            ),
          ),
        );
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

    if (nickname.isEmpty) {
      _showDialog(context, '오류', '닉네임을 입력하세요');
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('$serverUri/users/check_nickname/?nickname=$nickname'),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final isNicknameAvailable = responseData['is_available'] ?? false;

        if (isNicknameAvailable) {
          _showDialog(context, '확인 완료', '사용 가능한 닉네임입니다.');
        } else {
          _showDialog(context, '중복 오류', '이미 사용 중인 닉네임입니다.');
        }

        setState(() {
          isNicknameChecked = isNicknameAvailable;
        });
      } else {
        _showDialog(context, '오류', '닉네임 확인 중 오류가 발생했습니다.');
      }
    } catch (e) {
      _showDialog(context, '오류', '닉네임 확인 중 오류가 발생했습니다: $e');
    }
  }

  void _checkEmail(BuildContext context) async {
    final serverUri = Config.apiUrl;
    final email = emailController.text;

    if (email.isEmpty) {
      _showDialog(context, '오류', '이메일을 입력하세요');
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('$serverUri/users/check_email/?email=$email'),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final isEmailAvailable = responseData['is_available'] ?? false;

        if (isEmailAvailable) {
          _showDialog(context, '확인 완료', '사용 가능한 이메일입니다.');
        } else {
          _showDialog(context, '중복 오류', '이미 사용 중인 이메일입니다.');
        }

        setState(() {
          isEmailChecked = isEmailAvailable;
        });
      } else {
        _showDialog(context, '오류', '이메일 확인 중 오류가 발생했습니다.');
      }
    } catch (e) {
      _showDialog(context, '오류', '이메일 확인 중 오류가 발생했습니다: $e');
    }
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

  void _checkPassword(BuildContext context) {
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (password == confirmPassword && password.isNotEmpty) {
      setState(() {
        isPasswordMatched = true;
      });
      _showDialog(context, '확인 완료', '비밀번호가 일치합니다.');
    } else if (password.isEmpty) {
      setState(() {
        isPasswordMatched = false;
      });
      _showDialog(context, '오류', '비밀번호를 입력하세요.');
    } else {
      setState(() {
        isPasswordMatched = false;
      });
      _showDialog(context, '일치하지 않음', '비밀번호와 비밀번호 확인이 일치하지 않습니다.');
    }
  }

  bool _isInputEmpty() {
    return nameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        emailController.text.isEmpty ||
        nicknameController.text.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(height: 100),
                _buildTextField(
                  controller: nameController,
                  labelText: '이름',
                  obscureText: false,
                ),
                _buildTextField(
                  controller: emailController,
                  labelText: '이메일',
                  obscureText: false,
                  suffix: TextButton(
                    onPressed: () => _checkEmail(context),
                    child: const Text('중복 확인'),
                  ),
                ),
                _buildTextField(
                  controller: nicknameController,
                  labelText: '닉네임',
                  obscureText: false,
                  suffix: TextButton(
                    onPressed: () => _checkNickname(context),
                    child: const Text('중복 확인'),
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
                  suffix: TextButton(
                    onPressed: () => _checkPassword(context),
                    child: const Text('확인'),
                  ),
                ),
                _buildButton(
                  text: '레벨 테스트하기',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('레벨 테스트'),
                          contentPadding: const EdgeInsets.all(10.0),
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: LevelTestPage(
                              updateLevel: updateLevel,
                              updateTestDone: updateTestDone,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  buttonColor: const Color(0xFF4399FF),
                  isVisible: !isTestDone,
                ),
                const SizedBox(height: 10),
                _buildButton(
                  text: '회원가입하기',
                  onPressed: () {
                    if (isTestDone) {
                      _signUp(context);
                    } else {
                      _showDialog(context, '레벨 테스트 필요', '레벨 테스트를 먼저 완료해주세요.');
                    }
                  },
                  buttonColor: const Color(0xFF4399FF),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
