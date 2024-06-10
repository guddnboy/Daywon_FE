import 'package:flutter/material.dart';

void main() {
  runApp(AdminCheckProblemPage());
}

class AdminCheckProblemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: MediaQuery.sizeOf(context).height * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(
                        width: 2,
                        color: Color(0xFF4399FF),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          '생성된 문제 확인',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProblemListPage(
                                    problemType: '검수가 완료된 문제'),
                              ),
                            );
                          },
                          child: const Text('검수가 완료된 문제'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProblemListPage(
                                    problemType: '검수가 필요한 문제'),
                              ),
                            );
                          },
                          child: const Text('검수가 필요한 문제'),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/img/backbtn.png',
                        width: 45,
                        height: 45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProblemListPage extends StatelessWidget {
  final String problemType;

  const ProblemListPage({Key? key, required this.problemType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final problems = ProblemData.fetchProblems(problemType);

    return Scaffold(
      appBar: AppBar(
        title: Text(problemType),
      ),
      body: ListView.builder(
        itemCount: problems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(problems[index].title),
            subtitle: Text(problems[index].description),
            onTap: () {
              // 선택된 문제에 대한 동작 추가
            },
          );
        },
      ),
    );
  }
}

class Problem {
  final String title;
  final String description;

  Problem({required this.title, required this.description});
}

class ProblemData {
  static List<Problem> fetchProblems(String problemType) {
    // 가상의 데이터로 대체합니다. 실제로는 데이터베이스에서 가져와야 합니다.
    List<Problem> problems = [];

    if (problemType == '검수가 완료된 문제') {
      problems = [
        Problem(title: '검수 완료된 문제 1', description: '문제 1의 설명'),
        Problem(title: '검수 완료된 문제 2', description: '문제 2의 설명'),
        // 나머지 문제들도 추가할 수 있습니다.
      ];
    } else if (problemType == '검수가 필요한 문제') {
      problems = [
        Problem(title: '검수 필요한 문제 1', description: '문제 1의 설명'),
        Problem(title: '검수 필요한 문제 2', description: '문제 2의 설명'),
        // 나머지 문제들도 추가할 수 있습니다.
      ];
    }

    return problems;
  }
}
