import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class VideoPlayerPage extends StatefulWidget {
  final String title;
  final String url;

  const VideoPlayerPage({
    super.key,
    required this.title,
    required this.url,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  VideoPlayerController? _controller;
  bool _isDragging = false;
  double _dragValue = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _setupController(widget.url);
  }

  void _setupController(String url) async {
    await _controller?.pause();
    _controller?.removeListener(_updateSlider);
    await _controller?.dispose();

    _controller = url.startsWith('assets/')
        ? VideoPlayerController.asset(url)
        : VideoPlayerController.network(url);

    await _controller!.initialize();
    _controller!.addListener(_updateSlider);
    _controller!.play();

    // เริ่ม timer เพื่อ update slider แบบเรียลไทม์
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      if (!_isDragging && mounted) {
        setState(() {
          _dragValue = _controller!.value.position.inMilliseconds.toDouble();
        });
      }
    });

    setState(() {
      _isDragging = false;
      _dragValue = 0.0;
    });
  }

  @override
  void didUpdateWidget(covariant VideoPlayerPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _setupController(widget.url);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.removeListener(_updateSlider);
    _controller?.dispose();
    super.dispose();
  }

  void _updateSlider() {
    if (!_isDragging && mounted) {
      setState(() {
        _dragValue = _controller!.value.position.inMilliseconds.toDouble();
      });
    }
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _seekToMilliseconds(int milliseconds) {
    if (_controller == null) return;
    final dur = _controller!.value.duration;
    final newMs = milliseconds.clamp(0, dur.inMilliseconds);
    _controller!.seekTo(Duration(milliseconds: newMs));
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    if (controller == null || !controller.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final max = controller.value.duration.inMilliseconds.toDouble();
    final sliderValue = _isDragging
        ? _dragValue.clamp(0, max)
        : controller.value.position.inMilliseconds.toDouble();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          ),
          Slider(
            min: 0.0,
            max: max > 0 ? max : 1.0,
            value: sliderValue.toDouble(),
            onChangeStart: (v) {
              setState(() {
                _isDragging = true;
                _dragValue = v;
              });
            },
            onChanged: (v) {
              setState(() {
                _dragValue = v;
              });
            },
            onChangeEnd: (v) {
              _seekToMilliseconds(v.toInt());
              setState(() {
                _isDragging = false;
              });
            },
            activeColor: Colors.deepOrange,
            inactiveColor: Colors.grey.shade300,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatDuration(Duration(milliseconds: sliderValue.toInt()))),
                Text(_formatDuration(controller.value.duration)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.replay_10, size: 36, color: Colors.deepOrange),
                onPressed: () {
                  final cur = controller.value.position.inMilliseconds;
                  final target = (cur - 10000).clamp(0, controller.value.duration.inMilliseconds);
                  _seekToMilliseconds(target.toInt());
                },
              ),
              IconButton(
                icon: Icon(
                  controller.value.isPlaying ? Icons.pause_circle : Icons.play_circle,
                  size: 56,
                  color: Colors.deepOrange,
                ),
                onPressed: () {
                  setState(() {
                    controller.value.isPlaying ? controller.pause() : controller.play();
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.forward_10, size: 36, color: Colors.deepOrange),
                onPressed: () {
                  final cur = controller.value.position.inMilliseconds;
                  final target = (cur + 10000).clamp(0, controller.value.duration.inMilliseconds);
                  _seekToMilliseconds(target.toInt());
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
