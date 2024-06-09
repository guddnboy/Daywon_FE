import 'package:flutter/material.dart';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: const Scaffold(
        body: AdminCreateProblemPage(),
      ),
    );
  }
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
                  width: MediaQuery.of(context).size.width * 0.8,
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
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          '카테고리',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'Inter',
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
                            const SizedBox(width: 20),
                            CategoryButton(
                              title: '투자',
                              isSelected: selectedCategory == '투자',
                              onSelect: selectCategory,
                            ),
                            const SizedBox(width: 20),
                            CategoryButton(
                              title: '저축',
                              isSelected: selectedCategory == '저축',
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
                            fontFamily: 'Inter',
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
                        GestureDetector(
                          onTap: () {
                            // Handle create problem
                          },
                          child: Container(
                            width: 199,
                            height: 43,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF1C84FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                '문제 생성하기',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
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
          color: isSelected ? Colors.blueAccent : const Color(0xFF53A2FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontFamily: 'Inter',
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
          color: isSelected ? Colors.blueAccent : const Color(0xFF59A5FF),
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
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
