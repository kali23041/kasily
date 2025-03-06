import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;

class Navbar extends StatefulWidget {
  final Function(int) onItemSelected;
  final int selectedIndex;

  const Navbar({
    Key? key,
    required this.onItemSelected,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> with SingleTickerProviderStateMixin {
  late AnimationController _initialAnimationController;
  late Animation<double> _initialAnimation;
  int? _previousSelectedIndex;
  
  @override
  void initState() {
    super.initState();
    _previousSelectedIndex = widget.selectedIndex;
    
    // This animation controller is only for the initial entrance animation
    _initialAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    
    _initialAnimation = CurvedAnimation(
      parent: _initialAnimationController,
      curve: Curves.easeOutCubic,
    );
    
    // Start the initial animation
    _initialAnimationController.forward();
  }
  
  @override
  void didUpdateWidget(Navbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _previousSelectedIndex = oldWidget.selectedIndex;
    }
  }
  
  @override
  void dispose() {
    _initialAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _initialAnimation,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Glow effect for selected item
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                left: 20 + (widget.selectedIndex * 80),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _initialAnimation.value * 0.8,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF7F5AF0).withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Main navbar
              Transform.translate(
                offset: Offset(0, 20 * (1 - _initialAnimation.value)),
                child: Opacity(
                  opacity: _initialAnimation.value,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: CustomPaint(
                          painter: NavbarPainter(
                            selectedIndex: widget.selectedIndex,
                            previousSelectedIndex: _previousSelectedIndex ?? widget.selectedIndex,
                            animationValue: _initialAnimation.value,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              4,
                              (index) => _buildNavItem(index),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _getIconData(int index, bool isActive) {
    switch (index) {
      case 0:
        return isActive ? Icons.home : Icons.home_outlined;
      case 1:
        return isActive ? Icons.calendar_today : Icons.calendar_today_outlined;
      case 2:
        return isActive ? Icons.chat_bubble : Icons.chat_bubble_outline;
      case 3:
        return isActive ? Icons.person : Icons.person_outline;
      default:
        return Icons.circle;
    }
  }

  String _getLabel(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Calendar';
      case 2:
        return 'Chat';
      case 3:
        return 'Profile';
      default:
        return '';
    }
  }

  Widget _buildNavItem(int index) {
    final isSelected = widget.selectedIndex == index;
    
    return GestureDetector(
      onTap: () {
        if (widget.selectedIndex != index) {
          widget.onItemSelected(index);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7F5AF0).withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: isSelected ? 1.0 : 1.2, end: isSelected ? 1.2 : 1.0),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                  );
                },
                child: Icon(
                  isSelected ? _getIconData(index, true) : _getIconData(index, false),
                  key: ValueKey<bool>(isSelected),
                  color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
                fontSize: isSelected ? 12 : 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              child: Text(_getLabel(index)),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for additional visual effects
class NavbarPainter extends CustomPainter {
  final int selectedIndex;
  final int previousSelectedIndex;
  final double animationValue;
  
  NavbarPainter({
    required this.selectedIndex,
    required this.previousSelectedIndex,
    required this.animationValue,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    // Calculate the position of the selected item
    final itemWidth = size.width / 4;
    final centerX = itemWidth * (selectedIndex + 0.5);
    final previousCenterX = itemWidth * (previousSelectedIndex + 0.5);
    
    // Interpolate between previous and current position for smooth animation
    final animatedCenterX = previousCenterX + (centerX - previousCenterX) * animationValue;
    
    // Draw subtle wave effect
    final paint = Paint()
      ..color = const Color(0xFF7F5AF0).withOpacity(0.1 * animationValue)
      ..style = PaintingStyle.fill;
    
    final path = Path();
    path.moveTo(0, size.height);
    
    for (double i = 0; i < size.width; i += 1) {
      final distanceFromCenter = (i - animatedCenterX).abs();
      final waveHeight = math.max(0, 15 * animationValue * (1 - distanceFromCenter / (size.width / 2)));
      path.lineTo(i, size.height - waveHeight);
    }
    
    path.lineTo(size.width, size.height);
    path.close();
    
    canvas.drawPath(path, paint);
    
    // Draw particles
    if (animationValue > 0.5) {
      final particlePaint = Paint()
        ..color = Colors.white.withOpacity((animationValue - 0.5) * 2 * 0.3)
        ..style = PaintingStyle.fill;
      
      final random = math.Random(selectedIndex);
      for (int i = 0; i < 8; i++) {
        final x = animatedCenterX + random.nextDouble() * 40 - 20;
        final y = size.height - 10 - random.nextDouble() * 30;
        final radius = random.nextDouble() * 2 + 1;
        
        canvas.drawCircle(Offset(x, y), radius, particlePaint);
      }
    }
  }
  
  @override
  bool shouldRepaint(NavbarPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex || 
           oldDelegate.previousSelectedIndex != previousSelectedIndex ||
           oldDelegate.animationValue != animationValue;
  }
} 