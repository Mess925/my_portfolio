// project_detail_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class ProjectDetails {
  final String overview;
  final List<String> keyFeatures;
  final String technologies;
  final String? ctaButtonText;
  final VoidCallback? onCtaPressed;

  const ProjectDetails({
    required this.overview,
    required this.keyFeatures,
    required this.technologies,
    this.ctaButtonText,
    this.onCtaPressed,
  });
}

class ProjectDetailPage extends StatefulWidget {
  final String title;
  final String subtitle;
  final ProjectDetails details;

  const ProjectDetailPage({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.details,
  }) : super(key: key);

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.darkerBackground.withOpacity(0.95),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          r'C:\PORTFOLIO\PROJECT>',
          style: GoogleFonts.courierPrime(
            fontSize: Responsive.fontSize(
              context,
              mobile: 16,
              tablet: 18,
              desktop: 20,
            ),
            color: AppColors.primary,
            letterSpacing: 0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: isMobile ? 16 : 40),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary, width: 2),
                color: Colors.black,
              ),
              child: IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: () => Navigator.pop(context),
                color: AppColors.primary,
                tooltip: 'ESC',
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.horizontalPadding(context),
                vertical: isMobile ? 40 : 60,
              ),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // DOS-style header with nice box
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primary,
                                width: 3,
                              ),
                              color: Colors.black,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.3),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.primary,
                                    width: 2,
                                  ),
                                  color: AppColors.primary.withOpacity(0.1),
                                ),
                                child: Text(
                                  '╔═══ ${widget.title.toUpperCase()} ═══╗',
                                  style: GoogleFonts.courierPrime(
                                    fontSize: isMobile ? 16 : 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                    letterSpacing: 1,
                                    shadows: [
                                      Shadow(
                                        color: AppColors.primary.withOpacity(
                                          0.8,
                                        ),
                                        blurRadius: 15,
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: isMobile ? 12 : 16),

                          // Subtitle
                          Text(
                            'TYPE: ${widget.subtitle.toUpperCase()}',
                            style: GoogleFonts.courierPrime(
                              fontSize: Responsive.fontSize(
                                context,
                                mobile: 12,
                                tablet: 14,
                                desktop: 16,
                              ),
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0,
                            ),
                          ),

                          SizedBox(height: isMobile ? 40 : 60),

                          // Divider
                          Container(
                            height: 3,
                            decoration: BoxDecoration(color: AppColors.primary),
                          ),

                          SizedBox(height: isMobile ? 40 : 60),

                          // Overview
                          _buildSection(
                            'Overview',
                            widget.details.overview,
                            context,
                          ),

                          SizedBox(height: isMobile ? 30 : 40),

                          // Features
                          _buildFeaturesSection(
                            'Key Features',
                            widget.details.keyFeatures,
                            context,
                          ),

                          SizedBox(height: isMobile ? 30 : 40),

                          // Technologies
                          _buildSection(
                            'Technologies',
                            widget.details.technologies,
                            context,
                          ),

                          SizedBox(height: isMobile ? 40 : 60),

                          // CTA Button
                          if (widget.details.ctaButtonText != null)
                            Center(child: _buildCtaButton(context)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primary,
            border: Border.all(color: AppColors.primary, width: 2),
          ),
          child: Text(
            '>>> ${title.toUpperCase()}',
            style: GoogleFonts.courierPrime(
              fontSize: Responsive.fontSize(
                context,
                mobile: 14,
                tablet: 16,
                desktop: 18,
              ),
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.primary.withOpacity(0.5),
              width: 2,
            ),
            color: AppColors.cardBackground.withOpacity(0.3),
          ),
          child: Text(
            content,
            style: GoogleFonts.courierPrime(
              fontSize: Responsive.fontSize(
                context,
                mobile: 13,
                tablet: 14,
                desktop: 15,
              ),
              color: AppColors.textSecondary,
              height: 1.6,
              letterSpacing: 0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection(
    String title,
    List<String> features,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primary,
            border: Border.all(color: AppColors.primary, width: 2),
          ),
          child: Text(
            '>>> ${title.toUpperCase()}',
            style: GoogleFonts.courierPrime(
              fontSize: Responsive.fontSize(
                context,
                mobile: 14,
                tablet: 16,
                desktop: 18,
              ),
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.primary.withOpacity(0.5),
              width: 2,
            ),
            color: AppColors.cardBackground.withOpacity(0.3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features.asMap().entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '[${entry.key + 1}] ',
                      style: GoogleFonts.courierPrime(
                        fontSize: Responsive.fontSize(
                          context,
                          mobile: 13,
                          tablet: 14,
                          desktop: 15,
                        ),
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: GoogleFonts.courierPrime(
                          fontSize: Responsive.fontSize(
                            context,
                            mobile: 13,
                            tablet: 14,
                            desktop: 15,
                          ),
                          color: AppColors.textSecondary,
                          height: 1.6,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCtaButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: AppColors.primary, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed:
              widget.details.onCtaPressed ??
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'C:\\> FEATURE COMING SOON!',
                      style: GoogleFonts.courierPrime(color: AppColors.primary),
                    ),
                    backgroundColor: Colors.black,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(color: AppColors.primary, width: 2),
                    ),
                  ),
                );
              },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.fontSize(
                context,
                mobile: 32,
                tablet: 40,
                desktop: 48,
              ),
              vertical: Responsive.fontSize(
                context,
                mobile: 16,
                tablet: 18,
                desktop: 20,
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          child: Text(
            '>>> ${widget.details.ctaButtonText!.toUpperCase()}',
            style: GoogleFonts.courierPrime(
              fontSize: Responsive.fontSize(
                context,
                mobile: 14,
                tablet: 15,
                desktop: 16,
              ),
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

// Project Details Data
ProjectDetails getProjectDetails(String title) {
  switch (title) {
    case 'ProtectivePath':
      return const ProjectDetails(
        overview:
            'ProtectivePath is an innovative navigation application designed specifically '
            'for visually impaired users. Using advanced haptic feedback and audio cues, '
            'it provides safe and intuitive navigation through urban environments.',
        keyFeatures: [
          'Real-time obstacle detection using device sensors',
          'Voice-guided turn-by-turn navigation',
          'Haptic feedback for directional guidance',
          'Accessible UI designed for screen readers',
          'Offline maps for uninterrupted navigation',
        ],
        technologies:
            'Swift • Google Maps API • TensorFlow Lite • Text-to-Speech',
        ctaButtonText: 'View Project',
      );

    case 'Little Lemon':
      return const ProjectDetails(
        overview:
            'Little Lemon is a sophisticated restaurant reservation system '
            'that streamlines the dining experience. Customers can browse menus, '
            'make reservations, and receive real-time updates on table availability.',
        keyFeatures: [
          'Interactive menu browsing with dietary filters',
          'Real-time table availability tracking',
          'Push notifications for reservation confirmations',
          'Integrated payment system for deposits',
          'Review and rating system',
        ],
        technologies: 'Swift • Firebase • Cloud Functions • Stripe API',
        ctaButtonText: 'View Demo',
      );

    case 'MiniRT':
      return const ProjectDetails(
        overview:
            'MiniRT is a ray tracing engine built from scratch in C, demonstrating '
            'advanced computer graphics techniques. It renders photorealistic 3D scenes '
            'with accurate lighting, shadows, and reflections.',
        keyFeatures: [
          'Phong reflection model implementation',
          'Support for multiple light sources',
          'Sphere, plane, and cylinder primitives',
          'Ambient, diffuse, and specular lighting',
          'Shadow casting and reflection',
        ],
        technologies: 'C • MinilibX • Linear Algebra • Computer Graphics',
        ctaButtonText: 'View on GitHub',
      );

    case 'RUN':
      return const ProjectDetails(
        overview:
            'RUN is a comprehensive fitness tracking application focused on running '
            'and jogging activities. It tracks your routes, monitors performance metrics, '
            'and helps you achieve your fitness goals.',
        keyFeatures: [
          'GPS-based route tracking and mapping',
          'Real-time pace and distance calculations',
          'Performance analytics and progress tracking',
          'Social features to share runs with friends',
          'Custom workout plans and challenges',
        ],
        technologies: 'Flutter • Google Maps API • SQLite • Health Connect',
        ctaButtonText: 'Download App',
      );

    case 'Webserv':
      return const ProjectDetails(
        overview:
            'Webserv is a custom HTTP web server implementation written in C++. '
            'Following the HTTP/1.1 protocol, it handles multiple concurrent connections '
            'and serves static and dynamic content efficiently.',
        keyFeatures: [
          'HTTP/1.1 protocol implementation',
          'Multi-client connection handling with select()',
          'CGI script execution support',
          'Virtual host configuration',
          'Custom error pages and redirects',
        ],
        technologies: 'C++ • Socket Programming • HTTP Protocol • CGI',
        ctaButtonText: 'View Documentation',
      );

    default:
      return const ProjectDetails(
        overview:
            'This project showcases innovative solutions and creative design approaches. '
            'Built with attention to detail and user experience in mind.',
        keyFeatures: [
          'Modern and responsive design',
          'Smooth animations and transitions',
          'Optimized performance',
          'Clean and maintainable code',
        ],
        technologies: 'Flutter • Dart • Material Design',
        ctaButtonText: 'Learn More',
      );
  }
}

// make it look better
