import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/config.dart';

class LevelTestPage extends StatefulWidget {
  final void Function(String) updateLevel;
  final void Function(bool) updateTestDone;

  LevelTestPage({Key? key, required this.updateLevel, required this.updateTestDone}) : super(key: key);

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
      final serverUri = Config.apiUrl;
      final response = await http.get(
        Uri.parse('$serverUri/enroll_quizzes/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));

        setState(() {
          quizzes = responseData.map((questionData) {
            return {
              'enrollment_quiz_id': questionData['enrollment_quiz_id'] as int,
              'question': questionData['question'] as String,
              'options': [
                questionData['option_1'] as String,
                questionData['option_2'] as String,
                questionData['option_3'] as String,
                questionData['option_4'] as String,
              ],
              'correctAnswerIndex': questionData['correct'] as int,
              'selectedAnswerIndex': -1,
            };
          }).toList();
        });
      } else {
        _showErrorDialog('퀴즈 불러오기 실패: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorDialog('퀴즈 불러오기 에러: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('오류 발생'),
          content: Text(message),
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
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
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
        onPressed: _submitAnswersAndShowResult,
        child: const Icon(Icons.check),
      ),
    );
  }

  List<Widget> _buildOptions(int index) {
    List<Widget> optionWidgets = [];
    List<String> options = quizzes[index]['options'].cast<String>();

    for (int i = 0; i < options.length; i++) {
      optionWidgets.add(
        ListTile(
          title: Text(options[i]),
          leading: Radio<int>(
            value: i + 1,
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

  Future<void> _submitAnswersAndShowResult() async {
    List<Map<String, dynamic>> userAnswers = [];

    for (var question in quizzes) {
      if (question['selectedAnswerIndex'] == -1) {
        _showIncompleteDialog();
        return;
      }

      userAnswers.add({
        'enrollment_quiz_id': question['enrollment_quiz_id'],
        'answer': question['selectedAnswerIndex'],
      });
    }

    try {
      final serverUri = Config.apiUrl;
      final response = await http.post(
        Uri.parse('$serverUri/submit-answers/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'answers': userAnswers}),
      );

      if (response.statusCode == 200) {
        String level = response.body.replaceAll('"', '');
        if (kDebugMode) {
          print('레벨테스트 페이지에서의 레벨: $level');
        }
        widget.updateLevel(level);  // 콜백으로 level 전달
        widget.updateTestDone(true); // 콜백으로 테스트 완료 상태 전달
        Navigator.of(context).pop();  // 다이얼로그 닫기
      } else {
        _showErrorDialog('답변 제출 실패: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorDialog('답변 제출 에러: $e');
    }
  }

  void _showIncompleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('테스트 미완료'),
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
  }
}
