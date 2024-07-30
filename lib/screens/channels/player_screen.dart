import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayerScreen extends StatefulWidget {
  final String streammingUrl;
  const PlayerScreen({super.key, required this.streammingUrl});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.streammingUrl))
          ..initialize().then((_) {
            setState(() {
              isLoading = false;
            });
          }).catchError((error) {
            setState(() {
              isLoading = false;
            });
          });

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      aspectRatio: 16 / 9,
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('Player'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Chewie(
              controller: chewieController,
            ),
    );
  }
}

// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';

// import '../../constants/color_const.dart';
// import '../../controller/player_controller.dart';

// class PlayerScreen extends StatelessWidget {
//   const PlayerScreen({super.key, required this.url});
// final String url;
//   @override
//   Widget build(BuildContext context) {
//     final playerController = Get.put(PlayerController());
//     playerController.initializePlayer(url);
//     return Scaffold(
//         backgroundColor: primaryColor,
//         body: Column(
//           children: [
//             Expanded(
//               child: Center(
//                 child: Obx(() {
//                   if(playerController.chewieController!.videoPlayerController.value.isInitialized){
//                     return Chewie(
//                       controller: playerController.chewieController!,

//                     );
//                   }else{
//                     return const CircularProgressIndicator();
//                   }


//                 }
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }
// }
