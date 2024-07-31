import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const myPlayerView = 'MyPlayerView';

class MyPlayerView extends StatefulWidget {
  final String streammingUrl;
  const MyPlayerView({super.key, required this.streammingUrl});

  @override
  State<MyPlayerView> createState() => _MyPlayerViewState();
}

class _MyPlayerViewState extends State<MyPlayerView> {
  final Map<String, dynamic> creationParam = <String, dynamic>{};

  @override
  void initState() {
    creationParam['url'] = widget.streammingUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AndroidView(
            viewType: myPlayerView,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParam,
            creationParamsCodec: const StandardMessageCodec(),
          )
        : UiKitView(
            viewType: myPlayerView,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParam,
            creationParamsCodec: const StandardMessageCodec(),
          );
  }
}
