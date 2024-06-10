import 'package:flutter/material.dart';

void main() {
  runApp(const AdminCreateProblemPage());
}

class AdminCreateProblemPage extends StatefulWidget {
  const AdminCreateProblemPage({super.key});

  @override
  _AdminCreateProblemPageState createState() => _AdminCreateProblemPageState();
}

class _AdminCreateProblemPageState extends State<AdminCreateProblemPage> {
  String? selectedCategory;
  String? selectedLevel;

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void selectLevel(String level) {
    setState(() {
      selectedLevel = level;
    });
  }

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
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.7,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 2,
                        color: Color(0xFF4399FF),
                      ),
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        const Text(
                          '문제 생성',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          '카테고리',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CategoryButton(
                              title: '세금',
                              isSelected: selectedCategory == '세금',
                              onSelect: selectCategory,
                            ),
                            const SizedBox(width: 10),
                            CategoryButton(
                              title: '자산관리',
                              isSelected: selectedCategory == '자산관리',
                              onSelect: selectCategory,
                            ),
                            const SizedBox(width: 10),
                            CategoryButton(
                              title: '금융기초상식',
                              isSelected: selectedCategory == '금융기초상식',
                              onSelect: selectCategory,
                            ),
                            const SizedBox(width: 10),
                            CategoryButton(
                              title: '기본 상식',
                              isSelected: selectedCategory == '기본 상식',
                              onSelect: selectCategory,
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          '레벨',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LevelButton(
                              level: '1',
                              isSelected: selectedLevel == '1',
                              onSelect: selectLevel,
                            ),
                            const SizedBox(width: 20),
                            LevelButton(
                              level: '2',
                              isSelected: selectedLevel == '2',
                              onSelect: selectLevel,
                            ),
                            const SizedBox(width: 20),
                            LevelButton(
                              level: '3',
                              isSelected: selectedLevel == '3',
                              onSelect: selectLevel,
                            ),
                            const SizedBox(width: 20),
                            LevelButton(
                              level: '4',
                              isSelected: selectedLevel == '4',
                              onSelect: selectLevel,
                            ),
                            const SizedBox(width: 20),
                            LevelButton(
                              level: '5',
                              isSelected: selectedLevel == '5',
                              onSelect: selectLevel,
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () {
                            // Handle create problem
                            // Assume the problem creation is successful
                            _showSuccessDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1C84FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            minimumSize: const Size(199, 43),
                          ),
                          child: const Text(
                            '문제 생성하기',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
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
    );
  }
}

void _showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('문제 생성 성공'),
        content: const Text('문제가 성공적으로 생성되었습니다.'),
        actions: [
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

class CategoryButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function(String) onSelect;

  const CategoryButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(title),
      child: Container(
        width: 61,
        height: 61,
        decoration: ShapeDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 58, 98, 167)
              : const Color(0xFF53A2FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class LevelButton extends StatelessWidget {
  final String level;
  final bool isSelected;
  final Function(String) onSelect;

  const LevelButton({
    super.key,
    required this.level,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(level),
      child: Container(
        width: 30,
        height: 30,
        decoration: ShapeDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 58, 98, 167)
              : const Color(0xFF59A5FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            level,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
