import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class PlayerController extends GetxController{
   ChewieController? chewieController;
   VideoPlayerController? videoPlayerController;
  @override
  void onInit() async{
    // TODO: implement onInit

   initializePlayer("");
    super.onInit();
  }
  void initializePlayer(String? url)async{
     videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url??"https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"));

    await videoPlayerController?.initialize();
     chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      looping: true,
    );
  }
  @override
  void onClose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.onClose();
  }


}