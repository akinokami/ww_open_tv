import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
import 'package:ww_open_tv/constants/color_const.dart';
import 'package:ww_open_tv/constants/dimen_const.dart';
import 'package:ww_open_tv/custom_widgets/custom_related_channel.dart';
import 'package:ww_open_tv/data/channel_m3u8.dart';
import 'package:ww_open_tv/models/channel_model.dart';

import '../../custom_widgets/custom_label_and_listview.dart';
import '../../custom_widgets/custom_text.dart';

class PlayerScreen extends StatefulWidget {
  final List<ChannelModel>? channelList;
  final ChannelModel? channelModel;
  final String fromScreen;
  const PlayerScreen(
      {super.key,
      this.channelModel,
      this.channelList,
      required this.fromScreen});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool fullscreen = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fullscreen == false
          ? AppBar(
              backgroundColor: primaryColor,
              title: CustomText(
                text: widget.channelModel?.name ?? "",
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          : null,
      body: Padding(
        padding:
            fullscreen ? EdgeInsets.zero : const EdgeInsets.only(top: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoYoPlayer(
              aspectRatio: 16 / 9,
              url:
                  // 'https://dsqqu7oxq6o1v.cloudfront.net/preview-9650dW8x3YLoZ8.webm',
                  // "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
                  widget.channelModel?.url ?? "",
              //"https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8",
              allowCacheFile: true,
              onCacheFileCompleted: (files) {
                print('Cached file length ::: ${files?.length}');

                if (files != null && files.isNotEmpty) {
                  for (var file in files) {
                    print('File path ::: ${file.path}');
                  }
                }
              },
              onCacheFileFailed: (error) {
                print('Cache file error ::: $error');
              },
              videoStyle: const VideoStyle(
                qualityStyle: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                forwardAndBackwardBtSize: 30.0,
                playButtonIconSize: 40.0,
                fullScreenIconColor: Colors.black,
                playIcon: Icon(
                  Icons.play_circle_outline,
                  size: 40.0,
                  color: Colors.white,
                ),
                pauseIcon: Icon(
                  Icons.pause_circle_outline,
                  size: 40.0,
                  color: Colors.white,
                ),
                videoQualityPadding: EdgeInsets.all(5.0),
                showLiveDirectButton: true,
                // enableSystemOrientationsOverride: false,
              ),
              videoLoadingStyle: const VideoLoadingStyle(
                loading: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/launcher.webp'),
                        fit: BoxFit.fitHeight,
                        height: 50,
                      ),
                      SizedBox(height: 16.0),
                      Text("Loading video..."),
                    ],
                  ),
                ),
              ),
              onFullScreen: (value) {
                setState(() {
                  if (fullscreen != value) {
                    fullscreen = value;
                  }
                });
              },
            ),
            kSizedBoxH20,
            Padding(
              padding: EdgeInsets.all(8.w),
              child: CustomText(
                text: "Related Videos",
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomRelatedChannel(
              relatedChannelList: widget.channelList ?? [],
            )
          ],
        ),
      ),
    );
  }
}
