import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatelessWidget {
  final String apiUrl;

  ChangePassword({Key? key, required this.apiUrl}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> _changePassword(BuildContext context, String email, String name,
      String newPassword) async {
    final url = Uri.parse('$apiUrl/change-password/');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'e_mail': email,
        'name': name,
        'new_password': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('비밀번호 변경 성공'),
            content: Text('비밀번호가 성공적으로 변경되었습니다.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text('확인'),
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
            title: Text('비밀번호 변경 실패'),
            content: Text('아이디와 이름을 다시 확인해주세요.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('확인'),
              ),
            ],
          );
        },
      );
    }
  }

  void _validateAndSubmit(BuildContext context) {
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('비밀번호 불일치'),
            content: Text('입력한 비밀번호가 일치하지 않습니다.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('확인'),
              ),
            ],
          );
        },
      );
    } else {
      _changePassword(
          context, emailController.text, nameController.text, newPassword);
    }
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('비밀번호 변경'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      children: [
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: '아이디',
                            labelStyle: const TextStyle(
                              fontSize: 13,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFD9D9D9),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 20.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: '이름',
                                labelStyle: const TextStyle(
                                  fontSize: 13,
                                ),
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
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextField(
                              controller: newPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: '새 비밀번호',
                                labelStyle: const TextStyle(
                                  fontSize: 13,
                                ),
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
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: confirmPasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: '비밀번호 확인',
                                      labelStyle: const TextStyle(
                                        fontSize: 13,
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFFD9D9D9),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.check),
                                  onPressed: () {
                                    final newPassword =
                                        newPasswordController.text;
                                    final confirmPassword =
                                        confirmPasswordController.text;

                                    if (newPassword != confirmPassword) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('비밀번호 불일치'),
                                            content:
                                                Text('입력한 비밀번호가 일치하지 않습니다.'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('확인'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text('비밀번호가 일치합니다.')),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _validateAndSubmit(context);
                          },
                          child: const Text('비밀번호 변경'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
