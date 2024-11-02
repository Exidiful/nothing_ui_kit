import 'package:flutter/material.dart';
import 'dart:math' as math;

class AIVisualizer extends StatefulWidget {
  final bool isListening;

  const AIVisualizer({Key? key, required this.isListening}) : super(key: key);

  @override
  _AIVisualizerState createState() => _AIVisualizerState();
}

class _AIVisualizerState extends State<AIVisualizer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    for (int i = 0; i < 5; i++) {
      final animation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(i * 0.2, (i + 1) * 0.2, curve: Curves.easeInOut),
        ),
      );
      _animations.add(animation);
    }

    if (widget.isListening) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(AIVisualizer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isListening != oldWidget.isListening) {
      if (widget.isListening) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _AIVisualizerPainter(_animations),
          size: Size(100, 50),
        );
      },
    );
  }
}

class _AIVisualizerPainter extends CustomPainter {
  final List<Animation<double>> animations;

  _AIVisualizerPainter(this.animations);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final width = size.width / (animations.length * 2 - 1);
    final maxHeight = size.height * 0.8;

    for (int i = 0; i < animations.length; i++) {
      final x = i * width * 2;
      final height = maxHeight * animations[i].value;
      canvas.drawLine(
        Offset(x, size.height / 2 - height / 2),
        Offset(x, size.height / 2 + height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}