import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class findID extends StatelessWidget {
  final String apiUrl;

  findID({Key? key, required this.apiUrl}) : super(key: key);

  Future<void> _findID(BuildContext context, String nickname, String name) async {
    final url = Uri.parse('$apiUrl/user_find-email?nickname=$nickname&name=$name');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // API 응답이 성공적인 경우를 가정합니다. 응답에 'email' 키가 있다고 가정합니다.
      final responseData = json.decode(response.body);
      final email = responseData['email'];

      // 이메일을 포함한 팝업 표시
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('아이디 찾기 성공'),
            content: Text('해당 이메일로 등록된 아이디를 찾았습니다: $email'),
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
      // 실패 시에 대한 팝업 표시
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('아이디 찾기 실패'),
            content: Text('이름과 닉네임을 다시 확인해주세요.'),
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
  @override
  Widget build(BuildContext context) {
    final nicknameController = TextEditingController();
    final nameController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40.0),
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
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
                    child: Text('이메일'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: '이름',
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
                              controller: nicknameController,
                              decoration: InputDecoration(
                                labelText: '닉네임',
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
                        ElevatedButton(
                          onPressed: () {
                             _findID(context, nicknameController.text, nameController.text);
                          },
                          child: const Text('아이디 찾기'),
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
