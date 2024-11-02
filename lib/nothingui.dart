import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Voice Mode Visualizer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const Scaffold(
        body: LoadersPage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return const AnimatedTechLogo();
  }
}

class LoadersPage extends StatelessWidget {
  const LoadersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Nothing-inspired Loaders'),
        backgroundColor: Colors.black,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Determine the number of columns based on screen width
          int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
          
          return GridView.count(
            crossAxisCount: crossAxisCount,
            padding: const EdgeInsets.all(16.0),
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            children: [
              const LoaderWidget(loader: RotatingGlyphsLoader(), label: 'Rotating Glyphs'),
              const LoaderWidget(loader: DotMatrixLoader(), label: 'Dot Matrix'),
              const LoaderWidget(loader: PulsatingCirclesLoader(), label: 'Pulsating Circles'),
              const LoaderWidget(loader: RedLineScanLoader(), label: 'Red Line Scan'),
              const LoaderWidget(loader: GlitchTextLoader(), label: 'Glitch Text'),
              const LoaderWidget(loader: RotatingCubeLoader(), label: 'Rotating Cube'),
              const LoaderWidget(loader: LiquidFillLoader(), label: 'Liquid Fill'),
              const LoaderWidget(loader: CircuitBoardLoader(), label: 'Circuit Board'),
              const LoaderWidget(loader: MinimalistRotatingRingsLoader(), label: 'Minimalist Rotating Rings'),
              LoaderWidget(loader: AIAssistantAnimation(), label: 'AI Assistant'),
              const LoaderWidget(loader: AuthenticationPulseLoader(), label: 'Authentication Pulse'),
              const LoaderWidget(loader: IlaBankLoadingIndicator(), label: 'ila Bank Loading'),
            ],
          );
        },
      ),
    );
  }
}

class LoaderWidget extends StatelessWidget {
  final Widget loader;
  final String label;

  const LoaderWidget({super.key, required this.loader, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black87,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(child: loader),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// Add all the loader classes here (RotatingGlyphsLoader, DotMatrixLoader, etc.)
// ... (paste the code for each loader class from the previous response)

class RotatingGlyphsLoader extends StatefulWidget {
  const RotatingGlyphsLoader({super.key});

  @override
  _RotatingGlyphsLoaderState createState() => _RotatingGlyphsLoaderState();
}

class _RotatingGlyphsLoaderState extends State<RotatingGlyphsLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final int _numGlyphs = 6;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    double angle = (2 * pi) / _numGlyphs;

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: -_controller.value * 2 * pi,
          child: Stack(
            alignment: Alignment.center,
            children: List.generate(_numGlyphs, (index) {
              return Transform.rotate(
                angle: angle * index + _controller.value * 2 * pi,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Icon(
                    Icons.ac_unit,
                    color: index == (_controller.value * _numGlyphs).floor() % _numGlyphs
                        ? Colors.red
                        : Colors.white.withOpacity(0.5),
                    size: 24,
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class DotMatrixLoader extends StatefulWidget {
  const DotMatrixLoader({super.key});

  @override
  _DotMatrixLoaderState createState() => _DotMatrixLoaderState();
}

class _DotMatrixLoaderState extends State<DotMatrixLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final int _rows = 5;
  final int _columns = 10;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  Widget _buildDot(int row, int col) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        double progress = (_controller.value * _columns);
        bool isActive = col < progress;
        return Container(
          margin: const EdgeInsets.all(2),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? Colors.red : Colors.grey,
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_rows, (row) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_columns, (col) {
            return _buildDot(row, col);
          }),
        );
      }),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class PulsatingCirclesLoader extends StatefulWidget {
  const PulsatingCirclesLoader({super.key});

  @override
  _PulsatingCirclesLoaderState createState() => _PulsatingCirclesLoaderState();
}

class _PulsatingCirclesLoaderState extends State<PulsatingCirclesLoader> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final int _circleCount = 3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  Widget _buildCircle(int index) {
    double size = 50.0 * (index + 1);
    return ScaleTransition(
      scale: _animation,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red.withOpacity(0.2 / (index + 1)),
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: List.generate(_circleCount, (index) {
        return _buildCircle(index);
      }),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class RedLineScanLoader extends StatefulWidget {
  const RedLineScanLoader({super.key});

  @override
  _RedLineScanLoaderState createState() => _RedLineScanLoaderState();
}

class _RedLineScanLoaderState extends State<RedLineScanLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final double _height = 100.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: _height).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: 100,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: RedLinePainter(_animation.value),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class RedLinePainter extends CustomPainter {
  final double position;

  RedLinePainter(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(0, position),
      Offset(size.width, position),
      paint,
    );
  }

  @override
  bool shouldRepaint(RedLinePainter oldDelegate) => position != oldDelegate.position;
}

class GlitchTextLoader extends StatefulWidget {
  const GlitchTextLoader({super.key});

  @override
  _GlitchTextLoaderState createState() => _GlitchTextLoaderState();
}

class _GlitchTextLoaderState extends State<GlitchTextLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final String _text = 'Loading';
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            Text(_text, style: const TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'DotMatrix')),
            ClipRect(
              child: Align(
                alignment: Alignment.centerLeft,
                widthFactor: 0.5 + 0.1 * _random.nextDouble(),
                child: Text(_text, style: const TextStyle(color: Colors.red, fontSize: 24, fontFamily: 'DotMatrix')),
              ),
            ),
            if (_controller.value > 0.8)
              Transform.translate(
                offset: Offset(4 * _random.nextDouble() - 2, 4 * _random.nextDouble() - 2),
                child: Text(_text, style: TextStyle(color: Colors.cyan.withOpacity(0.8), fontSize: 24, fontFamily: 'DotMatrix')),
              ),
            if (_controller.value > 0.9)
              Transform.translate(
                offset: Offset(4 * _random.nextDouble() - 2, 4 * _random.nextDouble() - 2),
                child: Text(_text, style: TextStyle(color: Colors.yellow.withOpacity(0.5), fontSize: 24, fontFamily: 'DotMatrix')),
              ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class RotatingCubeLoader extends StatefulWidget {
  const RotatingCubeLoader({super.key});

  @override
  _RotatingCubeLoaderState createState() => _RotatingCubeLoaderState();
}

class _RotatingCubeLoaderState extends State<RotatingCubeLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 6))..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(_controller.value * 2 * pi)
            ..rotateY(_controller.value * 2 * pi),
          alignment: Alignment.center,
          child: CustomPaint(
            painter: CubePainter(),
            size: const Size(80, 80),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CubePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final redPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final double side = size.width / 2;

    // Front face
    canvas.drawRect(Rect.fromLTRB(-side, -side, side, side), paint);

    // Back face
    canvas.drawRect(Rect.fromLTRB(-side, -side, side, side), redPaint);

    // Connecting lines
    canvas.drawLine(Offset(-side, -side), Offset(-side, -side), paint);
    canvas.drawLine(Offset(side, -side), Offset(side, -side), paint);
    canvas.drawLine(Offset(-side, side), Offset(-side, side), paint);
    canvas.drawLine(Offset(side, side), Offset(side, side), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class LiquidFillLoader extends StatefulWidget {
  const LiquidFillLoader({super.key});

  @override
  _LiquidFillLoaderState createState() => _LiquidFillLoaderState();
}

class _LiquidFillLoaderState extends State<LiquidFillLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) {
        return CustomPaint(
          painter: LiquidPainter(_animation.value),
          size: const Size(80, 80),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class LiquidPainter extends CustomPainter {
  final double fillLevel;

  LiquidPainter(this.fillLevel);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * (1 - fillLevel))
      ..quadraticBezierTo(
        size.width / 2,
        size.height * (1 - fillLevel) - 10,
        size.width,
        size.height * (1 - fillLevel),
      )
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);

    // Draw container
    final containerPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), containerPaint);
  }

  @override
  bool shouldRepaint(LiquidPainter oldDelegate) => fillLevel != oldDelegate.fillLevel;
}

class CircuitBoardLoader extends StatefulWidget {
  const CircuitBoardLoader({super.key});

  @override
  _CircuitBoardLoaderState createState() => _CircuitBoardLoaderState();
}

class _CircuitBoardLoaderState extends State<CircuitBoardLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return CustomPaint(
          painter: CircuitPainter(_controller.value),
          size: const Size(80, 80),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CircuitPainter extends CustomPainter {
  final double animationValue;

  CircuitPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final redPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw circuit paths
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height), paint);

    // Draw moving red dot
    const circleRadius = 4.0;
    final circleCenter = Offset(
      size.width / 2 + (size.width / 2 - circleRadius) * cos(animationValue * 2 * pi),
      size.height / 2 + (size.height / 2 - circleRadius) * sin(animationValue * 2 * pi),
    );
    canvas.drawCircle(circleCenter, circleRadius, redPaint);
  }

  @override
  bool shouldRepaint(CircuitPainter oldDelegate) => animationValue != oldDelegate.animationValue;
}

// ... (rest of the code remains unchanged)

class ParticleConstellationLoader extends StatefulWidget {
  const ParticleConstellationLoader({super.key});

  @override
  _ParticleConstellationLoaderState createState() =>
      _ParticleConstellationLoaderState();
}

class _ParticleConstellationLoaderState
    extends State<ParticleConstellationLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Particle> particles = [];
  final int numberOfParticles = 100;
  final double maxDistance = 100;
  Random random = Random();
  bool formingShape = false;

  @override
  void initState() {
    super.initState();
    // Initialize particles
    for (int i = 0; i < numberOfParticles; i++) {
      particles.add(Particle(random));
    }
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16000),
    )..repeat();
    _controller.addListener(_update);
    // Start the logo formation cycle
    _startLogoFormationCycle();
  }

  void _update() {
    setState(() {
      for (var p in particles) {
        p.updatePosition();
      }
    });
  }

  void _startLogoFormationCycle() async {
    while (true) {
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        formingShape = true;
        for (var p in particles) {
          p.setTargetPosition(_logoPositions[random.nextInt(_logoPositions.length)]);
        }
      });
      await Future.delayed(const Duration(seconds: 3));
      setState(() {
        formingShape = false;
        for (var p in particles) {
          p.clearTargetPosition();
        }
      });
    }
  }

  // Define positions that form the logo shape
  List<Offset> get _logoPositions {
    // Replace with actual coordinates forming the desired shape
    return [
      const Offset(100, 100),
      const Offset(150, 150),
      const Offset(200, 100),
      // Add more points as needed
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ConstellationPainter(
        particles: particles,
        maxDistance: maxDistance,
        formingShape: formingShape,
        random: random,
      ),
      child: Container(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Particle {
  Offset position;
  Offset velocity;
  Offset? targetPosition; // Change to nullable
  Random random;

  Particle(this.random) : 
    position = Offset(
      random.nextDouble() * 300,
      random.nextDouble() * 600,
    ),
    velocity = Offset(
      random.nextDouble() * 2 - 1,
      random.nextDouble() * 2 - 1,
    );

  void updatePosition() {
    if (targetPosition != null) {
      // Move towards the target position
      Offset direction = targetPosition! - position;
      double distance = direction.distance;
      if (distance > 1) {
        Offset move = Offset(
          direction.dx / distance,
          direction.dy / distance,
        );
        position += move;
      }
    } else {
      // Random movement
      position += velocity;
    }

    // Bounce off edges
    if (position.dx <= 0 || position.dx >= 300) {
      velocity = Offset(-velocity.dx, velocity.dy);
    }
    if (position.dy <= 0 || position.dy >= 600) {
      velocity = Offset(velocity.dx, -velocity.dy);
    }
  }

  void setTargetPosition(Offset target) {
    targetPosition = target;
  }

  void clearTargetPosition() {
    targetPosition = null; // This is now valid since targetPosition is nullable
  }
}

class ConstellationPainter extends CustomPainter {
  final List<Particle> particles;
  final double maxDistance;
  final bool formingShape;
  final Random random;

  ConstellationPainter({
    required this.particles,
    required this.maxDistance,
    required this.formingShape,
    required this.random,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final particlePaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..strokeWidth = 0.5;

    final redLinePaint = Paint()
      ..color = Colors.red.withOpacity(0.5)
      ..strokeWidth = 0.5;

    for (int i = 0; i < particles.length; i++) {
      Particle p1 = particles[i];
      // Draw particle
      canvas.drawCircle(p1.position, 2, particlePaint);

      // Draw connections
      for (int j = i + 1; j < particles.length; j++) {
        Particle p2 = particles[j];
        double distance = (p1.position - p2.position).distance;
        if (distance < maxDistance) {
          // Occasionally use red accent for connections
          if (random.nextDouble() < 0.005) {
            canvas.drawLine(p1.position, p2.position, redLinePaint);
          } else {
            canvas.drawLine(p1.position, p2.position, linePaint);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant ConstellationPainter oldDelegate) {
    return true;
  }
}

class MinimalistRotatingRingsLoader extends StatefulWidget {
  const MinimalistRotatingRingsLoader({super.key});

  @override
  _MinimalistRotatingRingsLoaderState createState() =>
      _MinimalistRotatingRingsLoaderState();
}

class _MinimalistRotatingRingsLoaderState
    extends State<MinimalistRotatingRingsLoader> with TickerProviderStateMixin {
  late AnimationController _controllerOuter;
  late AnimationController _controllerMiddle;
  late AnimationController _controllerInner;

  @override
  void initState() {
    super.initState();

    _controllerOuter = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _controllerMiddle = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _controllerInner = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controllerOuter.dispose();
    _controllerMiddle.dispose();
    _controllerInner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = 150.0;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer Ring (Green)
          AnimatedBuilder(
            animation: _controllerOuter,
            builder: (_, child) {
              return Transform.rotate(
                angle: _controllerOuter.value * 2 * pi,
                child: CustomPaint(
                  size: Size(size, size),
                  painter: SettingsRingPainter(
                    strokeWidth: 4.0,
                    color: const Color(0xFF007A3D), // Palestinian flag green
                    notchCount: 16,
                  ),
                ),
              );
            },
          ),
          // Middle Ring (White)
          AnimatedBuilder(
            animation: _controllerMiddle,
            builder: (_, child) {
              return Transform.rotate(
                angle: -_controllerMiddle.value * 2 * pi,
                child: CustomPaint(
                  size: Size(size * 0.75, size * 0.75),
                  painter: SettingsRingPainter(
                    strokeWidth: 3.0,
                    color: Colors.white, // Palestinian flag white
                    notchCount: 12,
                  ),
                ),
              );
            },
          ),
          // Inner Ring (Black)
          AnimatedBuilder(
            animation: _controllerInner,
            builder: (_, child) {
              return Transform.rotate(
                angle: _controllerInner.value * 2 * pi,
                child: CustomPaint(
                  size: Size(size * 0.5, size * 0.5),
                  painter: SettingsRingPainter(
                    strokeWidth: 2.0,
                    color: Colors.black, // Palestinian flag black
                    notchCount: 8,
                  ),
                ),
              );
            },
          ),
          // Red Circle (Static)
          CustomPaint(
            size: Size(size * 0.2, size * 0.2),
            painter: CirclePainter(
              color: const Color(0xFFCE1126), // Palestinian flag red
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsRingPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final int notchCount;

  SettingsRingPainter({
    required this.strokeWidth,
    required this.color,
    required this.notchCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;

    final path = Path();

    for (int i = 0; i < notchCount; i++) {
      final startAngle = 2 * pi * i / notchCount;
      final endAngle = startAngle + pi / notchCount;

      path.addArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        endAngle - startAngle,
      );

      if (i < notchCount - 1) {
        final gapStartAngle = endAngle;
        final gapEndAngle = 2 * pi * (i + 1) / notchCount;

        path.addArc(
          Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
          gapStartAngle,
          gapEndAngle - gapStartAngle,
        );
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant SettingsRingPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.notchCount != notchCount;
  }
}

// New CirclePainter to replace TrianglePainter
class CirclePainter extends CustomPainter {
  final Color color;

  CirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CirclePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class AIAssistantAnimation extends StatefulWidget {
  final double size;

  AIAssistantAnimation({this.size = 150});

  @override
  _AIAssistantAnimationState createState() => _AIAssistantAnimationState();
}

class _AIAssistantAnimationState extends State<AIAssistantAnimation>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _orbitController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _orbitAnimation;

  @override
  void initState() {
    super.initState();

    // Pulse Animation
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    // Orbit Animation
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
    _orbitAnimation = CurvedAnimation(
      parent: _orbitController,
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _orbitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = widget.size;

    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: Listenable.merge([_pulseAnimation, _orbitAnimation]),
        builder: (context, child) {
          return CustomPaint(
            painter: _AIAssistantPainter(
              pulseValue: _pulseAnimation.value,
              orbitValue: _orbitAnimation.value,
              size: size,
            ),
          );
        },
      ),
    );
  }
}

class _AIAssistantPainter extends CustomPainter {
  final double pulseValue;
  final double orbitValue;
  final double size;

  _AIAssistantPainter({required this.pulseValue, required this.orbitValue, required this.size});

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final center = Offset(size / 2, size / 2);

    // Draw Central Pulsing Orb
    final orbRadius = (size * 0.2) * pulseValue;
    final orbPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withOpacity(0.8),
          Colors.white.withOpacity(0.0),
        ],
        stops: [0.0, 1.0],
      ).createShader(
        Rect.fromCircle(center: center, radius: orbRadius),
      );

    canvas.drawCircle(center, orbRadius, orbPaint);

    // Draw Shadow for Depth
    canvas.drawCircle(
      center,
      orbRadius,
      Paint()
        ..color = Colors.black.withOpacity(0.1)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );

    // Orbiting Particles Parameters
    int particleCount = 6;
    double orbitRadius = size * 0.35;

    for (int i = 0; i < particleCount; i++) {
      double angle = (2 * pi * i / particleCount) + (2 * pi * orbitValue);
      Offset particleCenter = Offset(
        center.dx + orbitRadius * cos(angle),
        center.dy + orbitRadius * sin(angle),
      );

      // Particle Paint
      final particlePaint = Paint()
        ..color = (i % 2 == 0) ? Colors.white : Colors.red
        ..style = PaintingStyle.fill;

      // Draw Orbiting Particle
      canvas.drawCircle(particleCenter, size * 0.04, particlePaint);

      // Draw Shadow for Particle
      canvas.drawCircle(
        particleCenter,
        size * 0.04,
        Paint()
          ..color = Colors.black.withOpacity(0.1)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _AIAssistantPainter oldDelegate) {
    return oldDelegate.pulseValue != pulseValue ||
        oldDelegate.orbitValue != orbitValue;
  }
}

class AuthenticationPulseLoader extends StatefulWidget {
  const AuthenticationPulseLoader({super.key});

  @override
  _AuthenticationPulseLoaderState createState() => _AuthenticationPulseLoaderState();
}

class _AuthenticationPulseLoaderState extends State<AuthenticationPulseLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    _pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: AuthenticationPulsePainter(_pulseAnimation.value, _rotationAnimation.value),
          size: const Size(100, 100),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class AuthenticationPulsePainter extends CustomPainter {
  final double pulseValue;
  final double rotationValue;

  AuthenticationPulsePainter(this.pulseValue, this.rotationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw pulsing circle
    final circlePaint = Paint()
      ..color = Colors.white.withOpacity(0.1 + 0.1 * sin(pulseValue * pi))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, radius * (0.8 + 0.2 * sin(pulseValue * pi)), circlePaint);

    // Draw rotating lock icon
    final lockPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotationValue * 2 * pi);

    // Draw lock body
    final lockRect = Rect.fromCenter(center: Offset.zero, width: radius * 0.6, height: radius * 0.4);
    canvas.drawRRect(RRect.fromRectAndRadius(lockRect, Radius.circular(radius * 0.1)), lockPaint);

    // Draw lock shackle
    final shacklePath = Path()
      ..moveTo(-radius * 0.2, 0)
      ..arcTo(Rect.fromCircle(center: Offset.zero, radius: radius * 0.2), pi, -pi, false)
      ..lineTo(radius * 0.2, -radius * 0.2);

    canvas.drawPath(shacklePath, lockPaint);

    canvas.restore();

    // Draw scanning line
    final scanLinePaint = Paint()
      ..color = Colors.red.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final scanY = size.height * (0.5 + 0.4 * sin(pulseValue * 2 * pi));
    canvas.drawLine(Offset(0, scanY), Offset(size.width, scanY), scanLinePaint);

    // Draw cyberpunk-style dots
    final dotPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 8; i++) {
      final angle = i * pi / 4 + rotationValue * 2 * pi;
      final dotCenter = Offset(
        center.dx + radius * 0.9 * cos(angle),
        center.dy + radius * 0.9 * sin(angle),
      );
      canvas.drawCircle(dotCenter, 2, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant AuthenticationPulsePainter oldDelegate) {
    return pulseValue != oldDelegate.pulseValue || rotationValue != oldDelegate.rotationValue;
  }
}
class AnimatedTechLogo extends StatefulWidget {
  const AnimatedTechLogo({super.key});

  @override
  _AnimatedTechLogoState createState() => _AnimatedTechLogoState();
}

class _AnimatedTechLogoState extends State<AnimatedTechLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _blinkAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _glowAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _blinkAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
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
          painter: TechLogoPainter(
            glowValue: _glowAnimation.value,
            rotationValue: _rotationAnimation.value,
            blinkValue: _blinkAnimation.value,
          ),
          child: const SizedBox(
            width: 200,
            height: 200,
          ),
        );
      },
    );
  }
}

class TechLogoPainter extends CustomPainter {
  final double glowValue;
  final double rotationValue;
  final double blinkValue;

  TechLogoPainter({
    required this.glowValue,
    required this.rotationValue,
    required this.blinkValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    // Draw blinking background dots
    _drawBackgroundDots(canvas, size);

    // Draw the outer circular frame
    final framePaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, size.width * 0.48, framePaint);

    // Draw the rotating rings
    _drawRotatingRings(canvas, size);

    // Draw the central mysterious eye
    _drawMysteriousEye(canvas, size);

    // Draw the Nothing-inspired dots
    _drawNothingDots(canvas, size);
  }

  void _drawBackgroundDots(Canvas canvas, Size size) {
    final random = Random(0);  // Use a fixed seed for consistent dot positions
    final dotCount = 50;
    final dotPaint = Paint()
      ..color = Colors.white.withOpacity(0.3 * blinkValue)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < dotCount; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 1.5 + 0.5;  // Dot size between 0.5 and 2.0

      canvas.drawCircle(Offset(x, y), radius, dotPaint);
    }
  }

  void _drawRotatingRings(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final ringColors = [
      Colors.red.withOpacity(0.3),
      Colors.white.withOpacity(0.2),
      Colors.red.withOpacity(0.1),
    ];

    final ringCount = 3;
    for (int i = 0; i < ringCount; i++) {
      final radius = size.width * (0.2 + 0.1 * i);
      final ringPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            ringColors[i].withOpacity(0.0),
            ringColors[i],
          ],
        ).createShader(Rect.fromCircle(center: center, radius: radius))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;

      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(rotationValue * (i % 2 == 0 ? 1 : -1));
      canvas.drawCircle(Offset.zero, radius, ringPaint);
      canvas.restore();
    }
  }

  void _drawMysteriousEye(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    // Eye shape
    final eyePath = Path()
      ..moveTo(center.dx - size.width * 0.2, center.dy)
      ..quadraticBezierTo(
        center.dx,
        center.dy - size.height * 0.15,
        center.dx + size.width * 0.2,
        center.dy,
      )
      ..quadraticBezierTo(
        center.dx,
        center.dy + size.height * 0.15,
        center.dx - size.width * 0.2,
        center.dy,
      );

    // Eye paint with glow effect
    final eyePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.red.withOpacity(0.0),
          Colors.red.withOpacity(glowValue * 0.7),
        ],
        stops: const [0.7, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: size.width * 0.25))
      ..style = PaintingStyle.fill;

    canvas.drawPath(eyePath, eyePaint);

    // Pupil
    final pupilPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, size.width * 0.05, pupilPaint);
  }

  void _drawNothingDots(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final dotCount = 12;
    final radius = size.width * 0.45;

    for (int i = 0; i < dotCount; i++) {
      final angle = (i * 2 * pi / dotCount) + rotationValue;
      final dotCenter = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      canvas.drawCircle(dotCenter, 2, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant TechLogoPainter oldDelegate) {
    return oldDelegate.glowValue != glowValue ||
        oldDelegate.rotationValue != rotationValue ||
        oldDelegate.blinkValue != blinkValue;
  }
}
class IlaBankLoadingIndicator extends StatefulWidget {
  final double size;
  final bool isDarkTheme;

  const IlaBankLoadingIndicator({
    Key? key,
    this.size = 48.0,
    this.isDarkTheme = false,
  }) : super(key: key);

  @override
  _IlaBankLoadingIndicatorState createState() => _IlaBankLoadingIndicatorState();
}

class _IlaBankLoadingIndicatorState extends State<IlaBankLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
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
      builder: (_, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _IlaBankLoadingPainter(
            animation: _controller,
            isDarkTheme: widget.isDarkTheme,
          ),
        );
      },
    );
  }
}

class _IlaBankLoadingPainter extends CustomPainter {
  final Animation<double> animation;
  final bool isDarkTheme;

  _IlaBankLoadingPainter({
    required this.animation,
    required this.isDarkTheme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = isDarkTheme ? const Color(0xFF00FF00) : const Color(0xFF00143F)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final double progress = animation.value;
    final double startAngle = -pi / 2;
    final double sweepAngle = 2 * pi * progress;

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2 - paint.strokeWidth / 2,
      ),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
class IlaCalendarWidget extends StatefulWidget {
  final bool isDarkTheme;

  const IlaCalendarWidget({Key? key, this.isDarkTheme = false}) : super(key: key);

  @override
  _IlaCalendarWidgetState createState() => _IlaCalendarWidgetState();
}

class _IlaCalendarWidgetState extends State<IlaCalendarWidget> with SingleTickerProviderStateMixin {
  late DateTime _selectedDate;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onMonthChanged(bool next) {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + (next ? 1 : -1), 1);
    });
    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.isDarkTheme ? _darkTheme : _lightTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(theme),
          const SizedBox(height: 16),
          _buildCalendarGrid(theme),
        ],
      ),
    );
  }

  Widget _buildHeader(IlaTheme theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.chevron_left, color: theme.textColor),
          onPressed: () => _onMonthChanged(false),
        ),
        FadeTransition(
          opacity: _fadeAnimation,
          child: Text(
            DateFormat('MMMM yyyy').format(_selectedDate),
            style: TextStyle(
              color: theme.textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.chevron_right, color: theme.textColor),
          onPressed: () => _onMonthChanged(true),
        ),
      ],
    );
  }

  Widget _buildCalendarGrid(IlaTheme theme) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1,
        ),
        itemCount: 7 + _daysInMonth(_selectedDate),
        itemBuilder: (context, index) {
          if (index < 7) {
            return _buildDayName(DateFormat('E').format(DateTime(2021, 1, index + 1)), theme);
          }
          return _buildDayNumber(index - 6, theme);
        },
      ),
    );
  }

  Widget _buildDayName(String dayName, IlaTheme theme) {
    return Center(
      child: Text(
        dayName.substring(0, 1),
        style: TextStyle(
          color: theme.textColor,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildDayNumber(int day, IlaTheme theme) {
    final currentDate = DateTime.now();
    final isCurrentDay = day == currentDate.day &&
        _selectedDate.month == currentDate.month &&
        _selectedDate.year == currentDate.year;

    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isCurrentDay ? theme.highlightColor : Colors.transparent,
        ),
        child: Center(
          child: Text(
            day.toString(),
            style: TextStyle(
              color: isCurrentDay ? theme.backgroundColor : theme.textColor,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  int _daysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }
}

class IlaTheme {
  final Color backgroundColor;
  final Color textColor;
  final Color highlightColor;

  IlaTheme({
    required this.backgroundColor,
    required this.textColor,
    required this.highlightColor,
  });
}

final _darkTheme = IlaTheme(
  backgroundColor: const Color(0xFF00143f),
  textColor: Colors.white,
  highlightColor: const Color(0xFF00ff00),
);

final _lightTheme = IlaTheme(
  backgroundColor: Colors.white,
  textColor: const Color(0xFF00143f),
  highlightColor: const Color(0xFF00ff00),
);