import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:project/pages/admin/AdminPage.dart';

void main() {
  runApp(ModifyCaseScript());
}

class ModifyCaseScript extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> messages = [];
  final TextEditingController _controller = TextEditingController();

  void addMessage(String message) {
    setState(() {
      messages.add(message);
    });
  }

  Future<String> sendMessage(String message) async {
    const endpoint =
        'YOUR_GPT_API_ENDPOINT'; // Replace with your GPT API endpoint
    const apiKey = 'YOUR_API_KEY'; // Replace with your GPT API key

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({'text': message}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String generatedText = data['generated_text'];
      return generatedText;
    } else {
      throw Exception('Failed to send message');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('숏폼/예시 스크립트 수정'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children:
                  messages.map((msg) => ChatBubble(message: msg)).toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: '메시지를 입력하세요...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    final message = _controller.text;
                    if (message.isNotEmpty) {
                      addMessage(message);
                      _controller.clear();
                      try {
                        final response = await sendMessage(message);
                        addMessage(response);
                      } catch (e) {
                        print('Error: $e');
                      }
                    }
                  },
                  child: const Text('전송'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminPage()),
                    );
                  },
                  child: const Text('수정 완료'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;

  const ChatBubble({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
