import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../constants/color_const.dart';
import '../../controller/player_controller.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key, required this.url});
final String url;
  @override
  Widget build(BuildContext context) {
    final playerController = Get.put(PlayerController());
    playerController.initializePlayer(url);
    return Scaffold(
        backgroundColor: primaryColor,
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Obx(() {
                  if(playerController.chewieController!.videoPlayerController.value.isInitialized){
                    return Chewie(
                      controller: playerController.chewieController!,

                    );
                  }else{
                    return const CircularProgressIndicator();
                  }


                }
                ),
              ),
            ),
          ],
        ));
  }
}
