import 'package:flutter/material.dart';

void main() {
  runApp(const AdminPage());
}

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String nickname = '';
  int numberOfProblems = 0;

  @override
  void initState() {
    super.initState();
    // 세션 데이터를 가져와서 nickname과 numberOfProblems를 업데이트합니다.
    fetchSessionData();
  }

  Future<void> fetchSessionData() async {
    // 세션 데이터를 가져오는 것을 가정합니다.
    await Future.delayed(const Duration(seconds: 2)); // 딜레이를 시뮬레이션합니다.
    // 세션에서 닉네임과 문제 수를 가져왔다고 가정합니다.
    setState(() {
      nickname = 'John Doe'; // 예시 닉네임
      numberOfProblems = 10; // 예시 문제 수
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/DayWon.png"),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "$nickname 님, 안녕하세요!",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10.0,
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 132,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF4399FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("데이원 관리자 계정"),
                                  Text("생성된 문제 수"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "$numberOfProblems 개",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
