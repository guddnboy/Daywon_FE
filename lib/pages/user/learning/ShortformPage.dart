import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/pages/MainPage.dart';
import 'package:project/pages/user/learning/ProblemPage.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:project/pages/user/Mypage/MyPage.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class ShortformPage extends StatefulWidget {
  final String selectedCategory;
  final int userId;
  final String apiUrl;
  final String profileImagePath;
  final int scriptsId;

  const ShortformPage({
    Key? key,
    required this.selectedCategory,
    required this.userId,
    required this.apiUrl,
    required this.profileImagePath,
    required this.scriptsId,
  }) : super(key: key);

  @override
  _ShortformPageState createState() => _ShortformPageState();
}

class _ShortformPageState extends State<ShortformPage> {
  late String selectedCategory;
  late VideoPlayerController _videoPlayerController;
  bool isLoading = true;
  String videoUrl = '';
  late int scriptsId = widget.scriptsId;
  Future<void>? _initializeVideoPlayerFuture;

  void _initializeVideoPlayer(scriptsId) async {
    final videoUrl =
        '${widget.apiUrl}/get_stream_video/$scriptsId'; // API 엔드포인트를 이곳에 입력하세요
    final request = http.Request('GET', Uri.parse(videoUrl));

    final response = await request.send();
    if (response.statusCode == 200) {
      print('response : 200 OK');
      final contentLength = response.contentLength;
      print('contentLength : $contentLength');
      List<int> bytes = await response.stream.toBytes();
      print('bytes : OK');

      Uint8List memoryBytes = Uint8List.fromList(bytes);
      print('memoryBytes: OK');

      //   _videoPlayerController = VideoPlayerController.memory(memoryBytes);
      //   VideoPlayerController.
      //   // 임시 디렉토리에 파일로 저장

      //   try {
      //     final tempDir = await getTemporaryDirectory();
      //     print('tempDir : $tempDir');
      //     // Do something with tempDir
      //   } catch (e) {
      //     print("Error getting temporary directory: $e");
      //   }
      //   print('tempDir : $tempDir');

      //   final tempFile = File('${tempDir.path}/temp_video.mp4');
      //   print('tempFile : $tempFile');
      //   await tempFile.writeAsBytes(bytes);
      //   print('tempFile.writeAsBytes(bytes): Ok');
      //   _videoPlayerController = VideoPlayerController.file(tempFile);
      //   print('_videoPlayerController : OK');
      //   _initializeVideoPlayerFuture = _videoPlayerController!.initialize();
      //   print('_initializeVideoPlayerFuture :  OK');
      //   await _initializeVideoPlayerFuture;
      //   print('await _initializeVideoPlayerFuture; : OK');
      //   _chewieController = ChewieController(
      //     videoPlayerController: _videoPlayerController!,
      //     aspectRatio: _videoPlayerController!.value.aspectRatio,
      //     autoPlay: true,
      //     looping: true,
      //   );
      //   print('ChewieController :OK');
      //   setState(() {
      //     print('setState : OK');
      //     isLoading = false;
      //   });
      // } else {
      //   // 에러 처리
      //   print('Failed to load video');
      //   setState(() {
      //     isLoading = false;
      //   });
      // }
      // print('isLoading');
      // print(isLoading);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    selectedCategory = widget.selectedCategory;
    //fetchVideoUrl(scriptsId);
    //_initializeVideoPlayer(scriptsId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //_initializeVideoPlayer(scriptsId);
    fetchVideoUrl(scriptsId);
  }

  Future<void> fetchVideoUrl(int scriptsId) async {
    final url = '${widget.apiUrl}/get_stream_video/$scriptsId';
    print('Fetching video URL from $url'); // 비디오 URL을 가져오는 중임을 로그로 표시

    try {
      Uri preVideoUrl = Uri.parse(url);
      final response = await http.get(preVideoUrl);

      if (response.statusCode == 200) {
        print("fetch: 비디오 있음");
        // 비디오 URL이 가져와졌으니, 이 URL을 통해 VideoPlayerController를 초기화합니다.

        _videoPlayerController = VideoPlayerController.networkUrl(preVideoUrl);
        _videoPlayerController.initialize();
        // 비디오 플레이어 초기화

        // ChewieController를 초기화하여 비디오를 재생할 수 있도록 합니다.
        setState(() {
          _videoPlayerController.initialize();
          _videoPlayerController.play();
          isLoading = false; // 로딩 상태를 false로 설정하여 비디오를 표시합니다.
          print('isLoading : $isLoading');
          print('비디오 함수 완');
        });
      } else {
        throw Exception('Failed to load video'); // 비디오 로드 실패 시 예외 처리
      }
    } catch (e) {
      print('Error fetching video URL: $e'); // 비디오 URL 가져오기 실패 시 오류 로그 출력
      setState(() {
        isLoading = false; // 로딩 상태를 false로 설정하여 오류 상태를 표시합니다.
      });
    }

    print('isLoading: $isLoading');
  }

  void playVideo(int scriptsId) {
    fetchVideoUrl(scriptsId).then((_) {
      // 비디오 플레이어 컨트롤러가 초기화된 후에 실행될 코드
      // 여기서 비디오를 재생하는 로직을 추가할 수 있습니다.
      _videoPlayerController.play();
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
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
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Center(
                                  child: isLoading
                                      ? CircularProgressIndicator()
                                      : (_videoPlayerController != null
                                          ? Container(
                                              width: constraints
                                                  .maxWidth, // 원하는 너비를 설정
                                              height: constraints.maxWidth *
                                                  0.8, // 원하는 높이를 설정
                                              child: VideoPlayer(
                                                  _videoPlayerController),
                                            )
                                          : const Text("No video available")),
                                ),
                              ),
                              const SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProblemPage(
                                        selectedCategory: selectedCategory,
                                        scriptsId: scriptsId,
                                        userId: widget.userId,
                                        apiUrl: widget.apiUrl,
                                        profileImagePath:
                                            widget.profileImagePath,
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
}
