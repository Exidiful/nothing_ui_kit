import 'package:flutter/material.dart';

class AIThinkingAnimation extends StatefulWidget {
  final bool isThinking;

  const AIThinkingAnimation({Key? key, required this.isThinking}) : super(key: key);

  @override
  _AIThinkingAnimationState createState() => _AIThinkingAnimationState();
}

class _AIThinkingAnimationState extends State<AIThinkingAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    for (int i = 0; i < 9; i++) {
      final animation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(i * 0.1, (i + 1) * 0.1, curve: Curves.easeInOut),
        ),
      );
      _animations.add(animation);
    }

    if (widget.isThinking) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(AIThinkingAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isThinking != oldWidget.isThinking) {
      if (widget.isThinking) {
        _controller.repeat();
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
          painter: _AIThinkingPainter(_animations),
          size: Size(100, 100),
        );
      },
    );
  }
}

class _AIThinkingPainter extends CustomPainter {
  final List<Animation<double>> animations;

  _AIThinkingPainter(this.animations);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final dotSize = size.width / 5;
    final spacing = size.width / 3;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        final index = i * 3 + j;
        final x = j * spacing;
        final y = i * spacing;
        final scale = animations[index].value;

        canvas.drawCircle(
          Offset(x + spacing / 2, y + spacing / 2),
          dotSize / 2 * scale,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}