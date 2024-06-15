import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/config.dart';
import 'package:project/pages/login/LoginPage.dart';

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

  set level(value) => LevelTestPage.level = value;

  void updateTestDone(bool testDone) {
    setState(() {
      isTestDone = testDone;
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
        return; // Stop further execution
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
          'level': LevelTestPage.level.toString(),
          'user_point': 0,
          'profile_image': 1,
          'hashed_password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        _showDialog(context, '회원가입 성공', '회원가입이 성공적으로 완료되었습니다.');

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
          context,
          '회원가입 실패',
          '회원가입에 실패했습니다. 에러 코드: ${response.statusCode}',
        );
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
                          title: Text('레벨 테스트'),
                          contentPadding: EdgeInsets.all(10.0),
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child:
                                LevelTestPage(updateTestDone: updateTestDone),
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
                      _showDialog(context, '레벨테스트 필요', '레벨테스트를 먼저 완료해주세요.');
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

class LevelTestPage extends StatefulWidget {
  final Function(bool) updateTestDone;

  static var level;

  const LevelTestPage({Key? key, required this.updateTestDone})
      : super(key: key);

  @override
  _LevelTestPageState createState() => _LevelTestPageState();
}

class _LevelTestPageState extends State<LevelTestPage> {
  List<Map<String, dynamic>> quizzes = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    setState(() {
      isLoading = true;
    });

    try {
      final serverUri =
          Config.apiUrl; // Replace with your FastAPI server endpoint
      final response = await http.get(
        Uri.parse('$serverUri/enroll_quizzes/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);

        setState(() {
          quizzes = responseData.map((questionData) {
            return {
              'question': questionData['question'] as String,
              'options': [
                questionData['option_1'] as String,
                questionData['option_2'] as String,
                questionData['option_3'] as String,
                questionData['option_4'] as String,
              ],
              'correctAnswerIndex': questionData['correct'] as int,
              'selectedAnswerIndex': -1, // Initialize with -1 for no selection
            };
          }).toList();
          isLoading = false;
        });
      } else {
        // Handle other status codes if needed
        if (kDebugMode) {
          print('퀴즈 불러오기 실패 : ${response.statusCode}');
        }
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      // Handle errors
      if (kDebugMode) {
        print('Quizzes Fetching Error : $e');
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('레벨 테스트'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : quizzes.isEmpty
              ? Center(child: Text('퀴즈를 가져오는 중에 문제가 발생했습니다.'))
              : ListView.builder(
                  itemCount: quizzes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              quizzes[index]['question'] as String,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Column(
                              children: _buildOptions(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showResultDialog();
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  List<Widget> _buildOptions(int index) {
    List<Widget> optionWidgets = [];
    List<String> options = [
      quizzes[index]['options'][0] as String,
      quizzes[index]['options'][1] as String,
      quizzes[index]['options'][2] as String,
      quizzes[index]['options'][3] as String,
    ];

    for (int i = 0; i < options.length; i++) {
      optionWidgets.add(
        ListTile(
          title: Text(options[i]),
          leading: Radio<int>(
            value: i,
            groupValue: quizzes[index]['selectedAnswerIndex'] as int,
            onChanged: (int? value) {
              setState(() {
                quizzes[index]['selectedAnswerIndex'] = value!;
              });
            },
          ),
        ),
      );
    }

    return optionWidgets;
  }

  void _showResultDialog() {
    int correctAnswers = 0;
    bool testDone = true;
    for (var question in quizzes) {
      if (question['selectedAnswerIndex'] == -1) {
        testDone = false;
        break;
      }
      if (question['selectedAnswerIndex'] == question['correctAnswerIndex']) {
        correctAnswers++;
      }
    }

    int level;
    if (correctAnswers <= 2) {
      level = 1;
    } else if (3 <= correctAnswers && correctAnswers < 5) {
      level = 2;
    } else if (5 <= correctAnswers && correctAnswers < 7) {
      level = 3;
    } else if (7 <= correctAnswers && correctAnswers < 9) {
      level = 4;
    } else {
      level = 5;
    }

    if (kDebugMode) {
      print("사용자 레벨은 $level");
    }

    if (!testDone) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('레벨 테스트 미완료'),
            content: const Text('모든 문제를 풀어주세요.'),
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
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('테스트 결과'),
            content:
                Text('문제 ${quizzes.length}개 중에서 맞은 개수는 $correctAnswers개입니다.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  widget.updateTestDone(true);
                },
                child: const Text('닫기'),
              ),
            ],
          );
        },
      );
    }
  }
}
