import 'package:flutter/material.dart';

void main() {
  runApp(CategoryPage());
}

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 320,
          height: 568,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              const BoxShadow(
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
                left: 28,
                top: 489,
                child: Container(
                  width: 263,
                  height: 417,
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
              const Positioned(
                left: 44,
                top: 102,
                child: SizedBox(
                  width: 224,
                  child: Text(
                    '카테고리 선택',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 82,
                top: 160,
                child: Text(
                  '카테고리',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 163,
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
                left: 65,
                top: 202,
                child: SizedBox(
                  width: 190,
                  height: 50,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 190,
                          height: 50,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFABD2FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 52.95,
                        top: 17.21,
                        child: SizedBox(
                          width: 87.21,
                          height: 14.75,
                          child: Text(
                            '세금',
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
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 66,
                top: 268,
                child: SizedBox(
                  width: 190,
                  height: 50,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 190,
                          height: 50,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF55A3FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 52.95,
                        top: 17.21,
                        child: SizedBox(
                          width: 87.21,
                          height: 14.75,
                          child: Text(
                            '투자',
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
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 66,
                top: 334,
                child: SizedBox(
                  width: 190,
                  height: 50,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 190,
                          height: 50,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF0075FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 52.95,
                        top: 17.21,
                        child: SizedBox(
                          width: 87.21,
                          height: 14.75,
                          child: Text(
                            '저축',
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
                      ),
                    ],
                  ),
                ),
              ),
              const Positioned(
                left: 47,
                top: 39,
                child: Text(
                  '오늘의 학습',
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
                child: SizedBox(
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
                            decoration: ShapeDecoration(
                              color: const Color(0xFF4399FF),
                              shape: StarBorder.polygon(
                                sides: 3,
                                // borderRadius: BorderRadius.circular(3),
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
                left: 61,
                top: 416,
                child: Container(
                  width: 199,
                  height: 43,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0056BD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 117,
                top: 428,
                child: Text(
                  '학습하러가기',
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
                            SizedBox(
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
                                        image:
                                            NetworkImage("assets/circle.png"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 2),
                            SizedBox(
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
                                        image:
                                            NetworkImage("assets/backbtn.png"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 2),
                            SizedBox(
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
