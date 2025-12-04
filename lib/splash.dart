import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  static const _duration = Duration(seconds: 5);
  static const _bg = Color(0xFF000000); // Pure black CRT
  static const _accent = Color(0xFF00FF00); // Pure terminal green
  static const _secondAccent = Color(0xFF00CC00); // Darker green
  static const _text = Color(0xFF00FF00); // Bright terminal green

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _controller = AnimationController(vsync: this, duration: _duration)
      ..repeat(reverse: false);

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 800),
            pageBuilder: (_, __, ___) => const HomePage(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeIn,
                ),
                child: child,
              );
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final t = _controller.value;

          // Smooth breathing zoom
          final zoom = 1.0 + 0.05 * math.sin(t * math.pi * 2);
          // Electric glow intensity
          final glow = 0.3 + 0.7 * (math.sin(t * math.pi * 2) * 0.5 + 0.5);

          return Stack(
            fit: StackFit.expand,
            children: [
              // 1️⃣ Background grid pulse
              CustomPaint(painter: _GridPainter(t)),

              // 2️⃣ Neon orbit particles
              CustomPaint(painter: _OrbitPainter(t)),

              // 3️⃣ Center content
              Center(
                child: Transform.scale(
                  scale: zoom,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            colors: [_accent, _secondAccent, _accent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: Text(
                          "HTHANT",
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 70,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 12,
                            color: _text,
                            shadows: [
                              Shadow(
                                color: _accent.withOpacity(0.9),
                                blurRadius: 30 + glow * 35,
                              ),
                              Shadow(color: _accent, blurRadius: 10),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FadeTransition(
                        opacity: Tween(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                            parent: _controller,
                            curve: const Interval(0.6, 1.0),
                          ),
                        ),
                        child: Text(
                          ">>> INITIALIZING PORTFOLIO SYSTEM...",
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 16,
                            color: _text.withOpacity(0.85),
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// 🕸 Dynamic grid lines that pulse subtly
class _GridPainter extends CustomPainter {
  final double t;
  final Paint _paint = Paint()
    ..color = const Color(0xFF00FF00).withOpacity(0.08)
    ..strokeWidth = 1;

  _GridPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final offset = math.sin(t * math.pi * 2) * 10;
    const gap = 40.0;

    for (double x = 0; x < size.width; x += gap) {
      canvas.drawLine(
        Offset(x + offset, 0),
        Offset(x + offset, size.height),
        _paint,
      );
    }
    for (double y = 0; y < size.height; y += gap) {
      canvas.drawLine(
        Offset(0, y - offset),
        Offset(size.width, y - offset),
        _paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) => true;
}

/// 🌌 Orbiting neon dots with shimmer
class _OrbitPainter extends CustomPainter {
  final double t;
  final int count = 24;

  _OrbitPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < count; i++) {
      final angle = (t * 2 * math.pi) + (i * (2 * math.pi / count));
      final radius = 100 + 40 * math.sin(t * 3 + i);
      final x = center.dx + math.cos(angle) * radius;
      final y = center.dy + math.sin(angle) * radius;

      final alpha = (math.sin(t * 6 + i) * 0.5 + 0.5) * 0.8;
      paint.color = const Color(0xFF00FF00).withOpacity(alpha * 0.5);
      canvas.drawCircle(Offset(x, y), 2.5 + math.sin(i + t * 4) * 1.2, paint);

      // Neon trailing effect with green accent colors
      final particleColor = i.isEven
          ? const Color(0xFF00FF00)
          : const Color(0xFF00CC00);
      paint.color = particleColor.withOpacity(alpha * 0.7);
      canvas.drawCircle(Offset(x, y), 1.2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _OrbitPainter oldDelegate) => true;
}
