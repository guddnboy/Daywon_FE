import 'package:flutter/material.dart';

void main() {
  runApp(AdminCreateProblemPage());
}

class AdminCreateProblemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
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
          child: Stack(
            children: [
              Column(),
              Positioned(
                top: 60,
                right: 50,
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
              Positioned(
                top: 68,
                left: 55,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/img/circle.png',
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      '문제 생성',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
