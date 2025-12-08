// home_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'about_section.dart';
import 'projects_section.dart';
import 'contact_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: AppAnimations.slow,
        curve: AppAnimations.defaultCurve,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(color: AppColors.darkBackground),
          ),

          // Subtle effects
          Positioned.fill(child: CustomPaint(painter: _TerminalGridPainter())),

          // Animated glow
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.5,
                  colors: [
                    AppColors.primary.withOpacity(0.08),
                    AppColors.secondary.withOpacity(0.04),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Main content
          Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      Container(
                        key: _projectsKey,
                        child: const ProjectsSection(),
                      ),
                      Container(key: _aboutKey, child: const AboutSection()),
                      Container(
                        key: _contactKey,
                        child: const ContactSection(),
                      ),
                    ],
                  ),
                ),
              ),
              // Mobile bottom navigation bar
              if (Responsive.isMobile(context)) _buildMobileBottomNav(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      height: isMobile ? 70 : 80,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
      decoration: BoxDecoration(
        color: AppColors.darkerBackground.withOpacity(0.95),
        border: Border(
          bottom: BorderSide(
            color: AppColors.primary.withOpacity(0.3),
            width: 2,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo
          Text(
            isMobile ? 'C:\\MESS_T>' : 'C:\\PORTFOLIO\\MESS_T>',
            style: GoogleFonts.courierPrime(
              fontSize: isMobile ? 16 : 20,
              color: AppColors.primary,
              letterSpacing: 0,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Blinking cursor
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 800),
            builder: (context, double value, child) {
              return Opacity(
                opacity: value > 0.5 ? 1.0 : 0.0,
                child: Text(
                  '_',
                  style: GoogleFonts.courierPrime(
                    fontSize: isMobile ? 16 : 20,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
            onEnd: () {
              // Restart animation
              if (mounted) setState(() {});
            },
          ),
          const Spacer(),

          // Navigation buttons (Desktop/Tablet only)
          if (!isMobile) ...[
            _NavButton(
              label: 'PROJECTS',
              isActive: false,
              onPressed: () => _scrollToSection(_projectsKey),
            ),
            _NavButton(
              label: 'ABOUT',
              isActive: false,
              onPressed: () => _scrollToSection(_aboutKey),
            ),
            _NavButton(
              label: 'CONTACT',
              isActive: false,
              onPressed: () => _scrollToSection(_contactKey),
            ),
          ],

          // Mobile: removed page name
          if (isMobile) const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildMobileBottomNav() {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: AppColors.darkerBackground.withOpacity(0.95),
        border: Border(
          top: BorderSide(color: AppColors.primary.withOpacity(0.3), width: 2),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _MobileNavItem(
            icon: Icons.folder_open,
            label: 'PROJECTS',
            onTap: () => _scrollToSection(_projectsKey),
          ),
          _MobileNavItem(
            icon: Icons.person_outline,
            label: 'ABOUT',
            onTap: () => _scrollToSection(_aboutKey),
          ),
          _MobileNavItem(
            icon: Icons.email_outlined,
            label: 'CONTACT',
            onTap: () => _scrollToSection(_contactKey),
          ),
        ],
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MobileNavItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 26),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.courierPrime(
                fontSize: 10,
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Navigation button widget
class _NavButton extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onPressed;

  const _NavButton({
    required this.label,
    required this.isActive,
    required this.onPressed,
  });

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: TextButton(
          onPressed: widget.onPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.isActive)
                Text(
                  '> ',
                  style: GoogleFonts.courierPrime(
                    fontSize: 16,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              Text(
                widget.label,
                style: GoogleFonts.courierPrime(
                  fontSize: 14,
                  color: widget.isActive || _isHovered
                      ? AppColors.primary
                      : AppColors.primary.withOpacity(0.5),
                  letterSpacing: 1,
                  fontWeight: widget.isActive
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              if (widget.isActive)
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 800),
                    builder: (context, double value, child) {
                      return Opacity(
                        opacity: value > 0.5 ? 1.0 : 0.0,
                        child: Container(
                          width: 10,
                          height: 16,
                          color: AppColors.primary,
                        ),
                      );
                    },
                    onEnd: () {
                      if (mounted) setState(() {});
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Terminal grid painter for retro CRT background with scanlines
class _TerminalGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.05)
      ..strokeWidth = 1;

    const gap = 50.0;

    // Draw vertical lines
    for (double x = 0; x < size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw CRT scanlines
    final scanlinePaint = Paint()
      ..color = AppColors.scanlineColor.withOpacity(0.3)
      ..strokeWidth = 1;

    for (double y = 0; y < size.height; y += 4) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), scanlinePaint);
    }

    // Draw horizontal grid lines
    for (double y = 0; y < size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
