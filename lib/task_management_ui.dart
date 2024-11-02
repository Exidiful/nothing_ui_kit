import 'package:flutter/material.dart';

class TaskManagementUI extends StatefulWidget {
  const TaskManagementUI({Key? key}) : super(key: key);

  @override
  _TaskManagementUIState createState() => _TaskManagementUIState();
}

class _TaskManagementUIState extends State<TaskManagementUI> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildDotMatrixCalendar(),
            _buildTaskList(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manage',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DotMatrix',
                ),
              ),
              Text(
                'your tasks',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DotMatrix',
                ),
              ),
            ],
          ),
          CircleAvatar(
            backgroundColor: Colors.grey[800],
            child: Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildDotMatrixCalendar() {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          final day = DateTime.now().add(Duration(days: index));
          final isToday = index == 0;
          return Container(
            width: 70,
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: isToday ? Colors.red.withOpacity(0.2) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ['S', 'M', 'T', 'W', 'T', 'F', 'S'][day.weekday % 7],
                  style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'DotMatrix'),
                ),
                SizedBox(height: 4),
                DotMatrixNumber(
                  number: day.day,
                  color: isToday ? Colors.red : Colors.white,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTaskList() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.all(20),
        children: [
          _buildTaskItem(
            'High',
            'March Dribbble Shots Design. Plan for the month',
            '16 Feb',
            Colors.red.withOpacity(0.2),
          ),
          _buildTaskItem(
            'Medium',
            'Create the "Blog" and "Product" pages for the FortRoom website',
            '16 Feb - 11:00 PM',
            Colors.grey[900]!,
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(String priority, String title, String date, Color color) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 1, end: 0),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(value * 200, 0),
          child: child,
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    priority,
                    style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'DotMatrix'),
                  ),
                ),
                Icon(Icons.more_horiz, color: Colors.white),
              ],
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'DotMatrix'),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.white, size: 16),
                SizedBox(width: 4),
                Text(date, style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'DotMatrix')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, true),
          _buildNavItem(Icons.folder, false),
          _buildAddButton(),
          _buildNavItem(Icons.chat_bubble, false),
          _buildNavItem(Icons.person, false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.red.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ]
            : [],
      ),
      child: Icon(
        icon,
        color: isSelected ? Colors.red : Colors.white,
        size: 28,
      ),
    );
  }

  Widget _buildAddButton() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Icon(Icons.add, color: Colors.white, size: 32),
          ),
        );
      },
    );
  }
}

class DotMatrixNumber extends StatelessWidget {
  final int number;
  final Color color;

  const DotMatrixNumber({Key? key, required this.number, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 40,
      child: CustomPaint(
        painter: DotMatrixPainter(number: number, color: color),
      ),
    );
  }
}

class DotMatrixPainter extends CustomPainter {
  final int number;
  final Color color;

  DotMatrixPainter({required this.number, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final dotSize = size.width / 5;
    final spacing = size.width / 4;

    final digits = number.toString().split('');
    for (int digitIndex = 0; digitIndex < digits.length; digitIndex++) {
      final digit = int.parse(digits[digitIndex]);
      final digitPattern = _getDigitPattern(digit);

      for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 3; j++) {
          if (digitPattern[i][j] == 1) {
            final x = j * spacing + (digitIndex * size.width * 0.6);
            final y = i * spacing;
            canvas.drawCircle(Offset(x, y), dotSize / 2, paint);
          }
        }
      }
    }
  }

  List<List<int>> _getDigitPattern(int digit) {
    // Define dot matrix patterns for digits 0-9
    final patterns = [
      [
        [1, 1, 1],
        [1, 0, 1],
        [1, 0, 1],
        [1, 0, 1],
        [1, 1, 1]
      ], // 0
      [
        [0, 1, 0],
        [1, 1, 0],
        [0, 1, 0],
        [0, 1, 0],
        [1, 1, 1]
      ], // 1
      // ... (add patterns for digits 2-9)
    ];
    return patterns[digit];
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}