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
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isNavigating = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToPage(int page) {
    if (_isNavigating || _currentPage == page) return;

    setState(() {
      _isNavigating = true;
      _currentPage = page;
    });

    _pageController
        .animateToPage(
          page,
          duration: AppAnimations.slow,
          curve: AppAnimations.defaultCurve,
        )
        .then((_) {
          if (mounted) {
            setState(() => _isNavigating = false);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      body: Stack(
        children: [
          // Terminal-style background
          Container(
            decoration: const BoxDecoration(color: AppColors.darkBackground),
          ),

          // Subtle scanline effect
          Positioned.fill(child: CustomPaint(painter: _TerminalGridPainter())),

          // Animated green glow
          AnimatedContainer(
            duration: AppAnimations.slow,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: _currentPage == 0
                    ? Alignment.topRight
                    : _currentPage == 1
                    ? Alignment.center
                    : Alignment.bottomLeft,
                radius: 1.5,
                colors: [
                  AppColors.primary.withOpacity(0.08),
                  AppColors.secondary.withOpacity(0.04),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Main content
          Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  // Disable PageView scrolling on mobile to avoid conflict with content scrolling
                  physics: isMobile
                      ? const AlwaysScrollableScrollPhysics()
                      : const AlwaysScrollableScrollPhysics(),
                  onPageChanged: (page) {
                    if (mounted) {
                      setState(() => _currentPage = page);
                    }
                  },
                  children: const [
                    ProjectsSection(),
                    AboutSection(),
                    ContactSection(),
                  ],
                ),
              ),
              // Mobile bottom navigation bar
              if (isMobile) _buildMobileBottomNav(),
            ],
          ),

          // Page indicators (Desktop only)
          if (Responsive.isDesktop(context)) _buildPageIndicators(),
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
          // Terminal prompt style logo
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
              isActive: _currentPage == 0,
              onPressed: () => _navigateToPage(0),
            ),
            _NavButton(
              label: 'ABOUT',
              isActive: _currentPage == 1,
              onPressed: () => _navigateToPage(1),
            ),
            _NavButton(
              label: 'CONTACT',
              isActive: _currentPage == 2,
              onPressed: () => _navigateToPage(2),
            ),
          ],

          // Mobile: just show current page name
          if (isMobile)
            Text(
              _currentPage == 0
                  ? '[PROJECTS.EXE]'
                  : _currentPage == 1
                  ? '[ABOUT.EXE]'
                  : '[CONTACT.EXE]',
              style: GoogleFonts.courierPrime(
                fontSize: 12,
                color: AppColors.primary,
                letterSpacing: 0,
                fontWeight: FontWeight.bold,
              ),
            ),
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
            activeIcon: Icons.folder,
            label: 'PROJECTS',
            isActive: _currentPage == 0,
            onTap: () => _navigateToPage(0),
          ),
          _MobileNavItem(
            icon: Icons.info_outline,
            activeIcon: Icons.info,
            label: 'ABOUT',
            isActive: _currentPage == 1,
            onTap: () => _navigateToPage(1),
          ),
          _MobileNavItem(
            icon: Icons.email_outlined,
            activeIcon: Icons.email,
            label: 'CONTACT',
            isActive: _currentPage == 2,
            onTap: () => _navigateToPage(2),
          ),
        ],
      ),
    );
  }

  // PopupMenuItem<int> _buildMenuItem(String label, int value) {
  //   return PopupMenuItem<int>(
  //     value: value,
  //     child: Text(
  //       label,
  //       style: GoogleFonts.inter(
  //         color: _currentPage == value ? AppColors.primaryCyan : Colors.white,
  //         fontWeight: _currentPage == value ? FontWeight.w600 : FontWeight.w400,
  //         letterSpacing: 1.5,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildPageIndicators() {
    return Positioned(
      right: 40,
      top: 0,
      bottom: 0,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            final isActive = _currentPage == index;
            return GestureDetector(
              onTap: () => _navigateToPage(index),
              child: AnimatedContainer(
                duration: AppAnimations.normal,
                curve: AppAnimations.defaultCurve,
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: isActive ? 12 : 8,
                height: isActive ? 12 : 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive
                      ? AppColors.primary
                      : Colors.white.withOpacity(0.3),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.6),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _MobileNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: AppAnimations.fast,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: AppAnimations.fast,
              child: Icon(
                isActive ? activeIcon : icon,
                key: ValueKey(isActive),
                color: isActive
                    ? AppColors.primary
                    : Colors.white.withOpacity(0.5),
                size: 26,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.courierPrime(
                fontSize: 10,
                color: isActive
                    ? AppColors.primary
                    : AppColors.primary.withOpacity(0.5),
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
