import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project/pages/MainPage.dart';
import 'package:project/pages/user/Mypage/MyPage.dart';

class ChatBotPage extends StatefulWidget {
  final String apiUrl;
  final int userId;
  final String profileImagePath;

  const ChatBotPage({Key? key, required this.apiUrl, required this.userId, required this.profileImagePath}) : super(key: key);

  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void _initializeChat() {
    setState(() {
      _messages.clear();
    });
  }

  Future<void> _sendMessage(String message) async {
    setState(() {
      _messages.add({"role": "user", "content": message});
    });

    final response = await http.post(
      Uri.parse('${widget.apiUrl}/api/chatbot'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'message': message,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        _messages.add({"role": "assistant", "content": jsonResponse['response']});
      });
    } else {
      setState(() {
        _messages.add({"role": "assistant", "content": "Error: Failed to get response"});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatBot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = _messages[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  alignment: message['role'] == 'user'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: message['role'] == 'user' ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message['content']!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Page',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(userId: widget.userId, apiUrl: widget.apiUrl, profileImagePath: widget.profileImagePath),
                ),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyPage(userId: widget.userId, apiUrl: widget.apiUrl, profileImagePath: widget.profileImagePath),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
