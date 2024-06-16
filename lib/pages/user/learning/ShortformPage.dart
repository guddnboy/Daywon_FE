import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/config.dart';
import 'package:project/pages/user/learning/ProblemPage.dart';
import 'dart:convert';
import 'package:video_player/video_player.dart';

class ShortformPage extends StatefulWidget {
  final String selectedCategory;
  final int scriptsId;

  const ShortformPage({
    Key? key,
    required this.selectedCategory,
    required this.scriptsId,
  }) : super(key: key);

  @override
  _ShortformPageState createState() => _ShortformPageState();
}

class _ShortformPageState extends State<ShortformPage> {
  late String selectedCategory;
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  bool isLoading = true;
  String videoUrl = '';

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCategory;
    fetchVideoUrl(widget.scriptsId);
  }

  Future<void> fetchVideoUrl(int scriptsId) async {
    final url = '${Config.apiUrl}/get_stream_video/${17}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          videoUrl = data['video_url'];
          if (videoUrl != null) {
            _controller = VideoPlayerController.network(videoUrl);
            _initializeVideoPlayerFuture = _controller!.initialize();
            _controller!.setLooping(true);
          }
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load video URL');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double containerWidth = constraints.maxWidth * 0.8;
            double containerHeight = constraints.maxHeight * 0.65;

            return Stack(
              children: [
                Center(
                  child: Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Align(
                      alignment: const Alignment(0, 0.3),
                      child: Container(
                        width: containerWidth,
                        height: containerHeight,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 2,
                              color: Color(0xFF4399FF),
                            ),
                            borderRadius: BorderRadius.circular(17),
                          ),
                          shadows: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Center(
                                child: isLoading
                                    ? CircularProgressIndicator()
                                    : (_controller != null
                                        ? FutureBuilder(
                                            future: _initializeVideoPlayerFuture,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                return AspectRatio(
                                                  aspectRatio: _controller!.value.aspectRatio,
                                                  child: VideoPlayer(_controller!),
                                                );
                                              } else {
                                                return CircularProgressIndicator();
                                              }
                                            },
                                          )
                                        : Text("No video available")),
                              ),
                            ),
                            const SizedBox(height: 50),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProblemPage(
                                      selectedCategory: selectedCategory,
                                      scriptsId: widget.scriptsId,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 20),
                              ),
                              child: const Text(
                                '문제 풀러 가기',
                                style: TextStyle(
                                  color: Color(0xFF4399FF),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
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
                        '오늘의 학습',
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
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
