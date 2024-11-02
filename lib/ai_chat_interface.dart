import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'ai_visualizer.dart';
import 'ai_thinking_animation.dart';

class AIChatInterface extends StatefulWidget {
  const AIChatInterface({Key? key}) : super(key: key);

  @override
  _AIChatInterfaceState createState() => _AIChatInterfaceState();
}

class _AIChatInterfaceState extends State<AIChatInterface> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  late AnimationController _typingAnimationController;
  late AnimationController _backgroundAnimationController;
  late Animation<double> _backgroundAnimation;
  bool _isListening = false;
  bool _isThinking = false;

  @override
  void initState() {
    super.initState();
    _typingAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _backgroundAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _backgroundAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(_backgroundAnimationController);
  }

  @override
  void dispose() {
    _typingAnimationController.dispose();
    _backgroundAnimationController.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    if (text.isEmpty) return;
    _textController.clear();
    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: true));
      _isListening = false;
      _isThinking = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isThinking = false;
        _messages.insert(0, ChatMessage(text: "This is an AI response to: $text", isUser: false));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Nothing AI', style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Stack(
        children: [
          _buildAnimatedBackground(),
          Column(
            children: [
              _buildAIVisualizer(),
              if (_isThinking) _buildThinkingAnimation(),
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) => _messages[index],
                ),
              ),
              _buildMessageComposer(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _backgroundAnimation,
      builder: (context, child) {
        return CustomPaint(
          painter: BackgroundPainter(_backgroundAnimation.value),
          child: Container(),
        );
      },
    );
  }

  Widget _buildAIVisualizer() {
    return Container(
      height: 60,
      alignment: Alignment.center,
      child: AIVisualizer(isListening: _isListening),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      color: Colors.grey[900]!.withOpacity(0.8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration(
                hintText: 'Ask anything...',
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[800],
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 8),
          GlowingActionButton(
            icon: Icons.send,
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  Widget _buildThinkingAnimation() {
    return Container(
      height: 100,
      alignment: Alignment.center,
      child: AIThinkingAnimation(isThinking: _isThinking),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;
  final bool isTyping;

  const ChatMessage({
    Key? key,
    required this.text,
    required this.isUser,
    this.isTyping = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) _buildAIAvatar(),
          Expanded(
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  isUser ? 'You' : 'AI',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isUser ? Colors.red : Colors.white,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.red.withOpacity(0.1) : Colors.grey[900],
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey[800]!, width: 1),
                  ),
                  child: isTyping ? _buildTypingIndicator() : Text(
                    text,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          if (isUser) SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildAIAvatar() {
    return Container(
      margin: const EdgeInsets.only(right: 16.0),
      child: CircleAvatar(
        backgroundColor: Colors.grey[800],
        child: Text(
          'AI',
          style: TextStyle(color: Colors.white, fontFamily: 'DotMatrix'),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Container(
          width: 8,
          height: 8,
          margin: EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: PulsingDot(delay: index * 0.3),
        );
      }),
    );
  }
}

class GlowingActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const GlowingActionButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 8,
            ),
          ],
        ),
        child: CircleAvatar(
          backgroundColor: Colors.red,
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}

class PulsingDot extends StatefulWidget {
  final double delay;

  const PulsingDot({Key? key, required this.delay}) : super(key: key);

  @override
  _PulsingDotState createState() => _PulsingDotState();
}

class _PulsingDotState extends State<PulsingDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    )..repeat(reverse: true);
    Future.delayed(Duration(milliseconds: (widget.delay * 1000).round()), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final double animationValue;

  BackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    for (var i = 0; i < 5; i++) {
      final radius = 50.0 + i * 30.0;
      final offset = 10 * math.sin(animationValue + i * 0.5);
      canvas.drawCircle(Offset(centerX + offset, centerY), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}