import 'package:flutter/material.dart';

void main() {
  runApp(AdminCheckProblemPage());
}

class AdminCheckProblemPage extends StatelessWidget {
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
              Positioned(
                left: 37,
                top: 493,
                child: Container(
                  width: 32.12,
                  height: 42.90,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 14.22,
                        top: 14.22,
                        child: Container(
                          width: 17.91,
                          height: 13.99,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF4399FF),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3)),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 42.90,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..translate(0.0, 0.0)
                            ..rotateZ(-1.57),
                          child: Container(
                            width: 42.90,
                            height: 30.22,
                            decoration: const ShapeDecoration(
                              color: Color(0xFF4399FF),
                              shape: StarBorder.polygon(
                                sides: 3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 281.12,
                top: 537.90,
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(0.0, 0.0)
                    ..rotateZ(-3.14),
                  child: Container(
                    width: 32.12,
                    height: 42.90,
                    child: Stack(
                      children: [
                        Positioned(
                          left: -14.22,
                          top: -14.22,
                          child: Transform(
                            transform: Matrix4.identity()
                              ..translate(0.0, 0.0)
                              ..rotateZ(-3.14),
                            child: Container(
                              width: 17.91,
                              height: 13.99,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF4399FF),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: -42.90,
                          child: Transform(
                            transform: Matrix4.identity()
                              ..translate(0.0, 0.0)
                              ..rotateZ(1.57),
                            child: Container(
                              width: 42.90,
                              height: 30.22,
                              decoration: const ShapeDecoration(
                                color: Color(0xFF4399FF),
                                shape: StarBorder.polygon(
                                  sides: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 469,
                child: Container(
                  width: 263,
                  height: 392,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Color(0xFF4399FF),
                      ),
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 46,
                top: 136,
                child: Container(
                  width: 227,
                  height: 55,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF8BC0FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 143,
                top: 152,
                child: Text(
                  '적금',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 47,
                top: 207,
                child: Container(
                  width: 227,
                  height: 55,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF53A2FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 47,
                top: 278,
                child: Container(
                  width: 227,
                  height: 55,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF1C84FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 119,
                top: 223,
                child: Text(
                  '자유 입출금',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              const Positioned(
                left: 127,
                top: 294,
                child: Text(
                  '정기예금',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 65,
                top: 151,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 65,
                top: 222,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 65,
                top: 293,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: OvalBorder(),
                  ),
                ),
              ),
              const Positioned(
                left: 72,
                top: 150,
                child: Text(
                  '1',
                  style: TextStyle(
                    color: Color(0xFF0075FF),
                    fontSize: 22,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w800,
                    height: 0,
                  ),
                ),
              ),
              const Positioned(
                left: 71,
                top: 220,
                child: Text(
                  '2',
                  style: TextStyle(
                    color: Color(0xFF0075FF),
                    fontSize: 22,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w800,
                    height: 0,
                  ),
                ),
              ),
              const Positioned(
                left: 70,
                top: 292,
                child: Text(
                  '3',
                  style: TextStyle(
                    color: Color(0xFF0075FF),
                    fontSize: 22,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w800,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 47,
                top: 350,
                child: Container(
                  width: 227,
                  height: 55,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0056BD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 143,
                top: 366,
                child: Text(
                  '투자',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 65,
                top: 365,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: OvalBorder(),
                  ),
                ),
              ),
              const Positioned(
                left: 69,
                top: 363,
                child: Text(
                  '4',
                  style: TextStyle(
                    color: Color(0xFF0075FF),
                    fontSize: 22,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w800,
                    height: 0,
                  ),
                ),
              ),
              const Positioned(
                left: 52,
                top: 91,
                child: SizedBox(
                  width: 224,
                  child: Text(
                    '문제 예시가 무언가 있음 이 상황에서 선택해야하는 상품은?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 52,
                top: 418,
                child: SizedBox(
                  width: 224,
                  child: Text(
                    '해설과 정답 :                    한 문제에 대한 해설과 정답이 있습니다.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 47,
                top: 39,
                child: Text(
                  '문제 확인',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 39,
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
                left: 258,
                top: 29,
                child: Container(
                  width: 28,
                  height: 33.37,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 14.07,
                        top: 11.06,
                        child: Container(
                          width: 13.93,
                          height: 10.88,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF4399FF),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3)),
                          ),
                        ),
                      ),
                      Positioned(
                        left: -0,
                        top: 33.37,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..translate(0.0, 0.0)
                            ..rotateZ(-1.57),
                          child: Container(
                            width: 33.37,
                            height: 23.50,
                            decoration: const ShapeDecoration(
                              color: Color(0xFF4399FF),
                              shape: StarBorder.polygon(
                                sides: 3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 106,
                top: 491,
                child: Container(
                  width: 114,
                  height: 43,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF1C84FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 102,
                top: 491,
                child: Container(
                  width: 114,
                  height: 43,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF1C84FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 132,
                top: 505,
                child: Text(
                  '수정하기',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: -4,
                child: Container(
                  width: 320,
                  height: 34,
                  padding: const EdgeInsets.only(
                      top: 8, left: 21, right: 14, bottom: 3),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 23,
                        padding: const EdgeInsets.only(
                            top: 6, left: 0.33, right: 1.67),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 54,
                              child: Text(
                                '9:27',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                  letterSpacing: -0.33,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 16,
                        padding: const EdgeInsets.only(top: 1),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 18,
                              height: 12,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 17,
                                    height: 10.67,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://via.placeholder.com/17x11"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 2),
                            Container(
                              width: 21,
                              height: 15,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 15.33,
                                    height: 11,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://via.placeholder.com/15x11"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 2),
                            Container(
                              width: 25,
                              height: 12,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Opacity(
                                    opacity: 0.35,
                                    child: Container(
                                      width: 22,
                                      height: 11.33,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(width: 1),
                                          borderRadius:
                                              BorderRadius.circular(2.67),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 18,
                                    height: 7.33,
                                    decoration: ShapeDecoration(
                                      color: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(1.33),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
