import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFastCacheNetworkImage extends StatelessWidget {
  const CustomFastCacheNetworkImage(
      {super.key,
      required this.url,
      this.placeHolderUrl,
      this.assetsImagesName,
      required this.width,
      required this.height});
  final String? url;
  final String? placeHolderUrl;
  final String? assetsImagesName;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return FastCachedImage(
      width: width.w,
      height: height.h,
      fit: BoxFit.contain,
      url: url ??
          (placeHolderUrl ??
              'https://img.freepik.com/premium-vector/tv-channel-button-logo-design-vector-template_567288-1201.jpg'),
      fadeInDuration: const Duration(seconds: 1),
      errorBuilder: (context, exception, stacktrace) {
        return Image.asset("assets/images/launcher.webp",
            fit: BoxFit.contain, width: width.w, height: height.h);
      },
      loadingBuilder: (context, progress) {
        // debugPrint(
        //     'Progress: ${progress.isDownloading} ${progress.downloadedBytes} / ${progress.totalBytes}');
        return SizedBox(
          width: width.w,
          height: height.h,
          //color: secondaryColor,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (progress.isDownloading && progress.totalBytes != null)
                Text(
                    '${progress.downloadedBytes ~/ 1024} / ${progress.totalBytes! ~/ 1024} kb',
                    style: const TextStyle(color: Colors.red)),
              Center(
                child: SizedBox(
                    width: 10,
                    height: 10,
                    child: CircularProgressIndicator(
                        color: Colors.white,
                        value: progress.progressPercentage.value)),
              ),
            ],
          ),
        );
        // return Center(
        //   child: CircularProgressIndicator(),
        // );
      },
    );
  }
}
