import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class LiveFeed extends StatefulWidget {
  final List<CameraDescription> cameras;
  LiveFeed({Key? key, required this.cameras}) : super(key: key);

  @override
  State<LiveFeed> createState() => _LiveFeedState();
}

class _LiveFeedState extends State<LiveFeed> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}