import 'package:flutter/material.dart';
import 'package:project/pages/MainPage.dart';
import 'package:project/pages/user/Mypage/CorrectProblem.dart';
import 'package:project/pages/user/Mypage/MyPage.dart';

void main() {
  runApp(const AdminAccountManagement());
}

class AdminAccountManagement extends StatelessWidget {
  const AdminAccountManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AdminAccountManagementPage(),
      ),
    );
  }
}

class AdminAccountManagementPage extends StatefulWidget {
  @override
  _AdminAccountManagementPageState createState() =>
      _AdminAccountManagementPageState();
}

class _AdminAccountManagementPageState
    extends State<AdminAccountManagementPage> {
  List<Account> accounts = List.generate(
      20, (index) => Account(id: '아이디$index', status: '활성화 상태', level: null));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                    icon: Image.asset(
                      'assets/img/backbtn.png',
                      width: 40,
                      height: 40,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text('아이디',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('활성화 상태',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('레벨', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('비밀번호 확인',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(color: Colors.black),
                    Container(
                      height: 400,
                      child: ListView.builder(
                        itemCount: accounts.length,
                        itemBuilder: (context, index) {
                          return AccountRow(account: accounts[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      int? selectedLevel;
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: const Text('계정 등록'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: '아이디',
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: '비밀번호',
                              ),
                            ),
                            const SizedBox(height: 10),
                            DropdownButtonFormField<int>(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: '레벨 선택',
                              ),
                              items: [
                                DropdownMenuItem<int>(
                                  value: 1,
                                  child: Text('1'),
                                ),
                                DropdownMenuItem<int>(
                                  value: 2,
                                  child: Text('2'),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedLevel = value;
                                });
                              },
                              hint: Text("레벨"),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            child: const Text('등록'),
                            onPressed: () {
                              // 등록 버튼 클릭 시 처리 로직 추가
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('계정 등록'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white, // 텍스트 색상을 흰색으로 설정
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: Size(200, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Account {
  String id;
  String status;
  int? level;

  Account({required this.id, required this.status, required this.level});
}

class AccountRow extends StatefulWidget {
  final Account account;

  const AccountRow({Key? key, required this.account}) : super(key: key);

  @override
  _AccountRowState createState() => _AccountRowState();
}

class _AccountRowState extends State<AccountRow> {
  bool isActive = true; // 상태를 저장하기 위한 변수
  int? selectedLevel;

  @override
  void initState() {
    super.initState();
    selectedLevel = widget.account.level;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(widget.account.id),
        GestureDetector(
          onTap: () {
            setState(() {
              isActive = !isActive; // 상태를 토글
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.lightBlue, // 상태에 따른 색상 변경
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue),
            ),
            child: Text(
              isActive ? '활성화 상태' : '비활성화 상태', // 상태에 따른 텍스트 변경
              style: TextStyle(color: isActive ? Colors.black : Colors.white),
            ),
          ),
        ),
        DropdownButton<int>(
          value: selectedLevel,
          hint: Text("레벨"),
          items: [
            DropdownMenuItem<int>(
              value: 1,
              child: Text('1'),
            ),
            DropdownMenuItem<int>(
              value: 2,
              child: Text('2'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              selectedLevel = value;
            });
          },
        ),
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('비밀번호 확인'),
                  content: TextField(
                    obscureText: true,
                    decoration: const InputDecoration(hintText: '비밀번호 입력'),
                  ),
                  actions: [
                    TextButton(
                      child: const Text('확인'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('비밀번호 확인'),
        ),
      ],
    );
  }
}
