// ignore_for_file: unnecessary_const

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'CategoryPage.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Container(
              width: constraints.maxWidth < 600 ? constraints.maxWidth : 320,
              height: constraints.maxHeight < 600 ? constraints.maxHeight : 568,
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
                  Positioned(
                    left: 19,
                    top: 126,
                    child: Container(
                      width: 282,
                      height: 132,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF4399FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 21,
                    top: 93,
                    child: Text(
                      '마리모',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 65,
                    top: 93,
                    child: Text(
                      '님, 오늘의 학습을 시작하세요! ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 80,
                    top: 140,
                    child: Text(
                      '자유 입출금 통장',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 82,
                    top: 158,
                    child: Text(
                      '데이원은행',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 133,
                    top: 158,
                    child: Text(
                      '302112354868684',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 81,
                    top: 182,
                    child: Text(
                      '750,000 ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 214,
                    top: 182,
                    child: Text(
                      '원',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 132,
                    top: 396,
                    width: 121,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryPage(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF4399FF)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                            side: BorderSide(
                              color: Color(0xFF0075FF),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      child: const Text(
                        '학습 시작하기',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 125,
                    top: 358,
                    child: Text(
                      '10',
                      style: TextStyle(
                        color: Color(0xFF1D1D1D),
                        fontSize: 22,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 152,
                    top: 358,
                    child: Text(
                      '일 연속 출석',
                      style: TextStyle(
                        color: Color(0xFF1D1D1D),
                        fontSize: 22,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 48,
                    top: 323,
                    child: Text(
                      '오늘의 학습',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 26,
                    top: 323,
                    child: Container(
                      width: 15,
                      height: 15,
                      decoration: const ShapeDecoration(
                        color: Color(0xFF0075FF),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 517,
                    child: Container(
                      width: constraints.maxWidth < 600
                          ? constraints.maxWidth
                          : 320,
                      height: 51,
                      decoration: const BoxDecoration(color: Color(0xFF8A8A8A)),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 510,
                    child: Container(
                      width: constraints.maxWidth < 600
                          ? constraints.maxWidth
                          : 320,
                      height: 58,
                      decoration: const ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Color(0xFF4399FF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 15,
                    child: Container(
                      width: 150,
                      height: 75.41,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/DayWon.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 33,
                    top: 140,
                    child: SizedBox(
                      width: 35,
                      height: 35,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 1.59,
                            top: 10.18,
                            child: Container(
                              width: 31.82,
                              height: 16,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/DayWon.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: -13,
                    top: 296,
                    child: Container(
                      width: constraints.maxWidth < 600
                          ? constraints.maxWidth
                          : 350,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFFEBEBEB),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 31,
                    top: 356,
                    child: Container(
                      width: 75,
                      height: 74,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: const BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
