// projects_section.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'constants.dart';
import 'project_detail_page.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Responsive.verticalPadding(context),
        horizontal: Responsive.horizontalPadding(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: isMobile
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Text(
                r'C:\PROJECTS> DIR /W',
                style: GoogleFonts.courierPrime(
                  fontSize: Responsive.fontSize(
                    context,
                    mobile: 18,
                    tablet: 24,
                    desktop: 28,
                  ),
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 24 : 40),

          // Projects List
          isMobile
              ? _buildMobileProjects(context)
              : _buildDesktopTabletProjects(context, isTablet),
        ],
      ),
    );
  }

  Widget _buildMobileProjects(BuildContext context) {
    final projects = _getProjects(false);

    return Column(
      children: [
        for (int i = 0; i < projects.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: projects[i],
          ),
      ],
    );
  }

  Widget _buildDesktopTabletProjects(BuildContext context, bool isTablet) {
    final projects = _getProjects(isTablet);

    return SizedBox(
      height: 520, // Fixed height for horizontal scroll
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
          },
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 40),
            child: Row(
              children: [
                for (int i = 0; i < projects.length; i++) ...[
                  projects[i],
                  if (i < projects.length - 1) const SizedBox(width: 30),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _getProjects(bool isTablet) {
    return [
      ProjectCard(
        title: 'ProtectivePath',
        subtitle: 'Navigation App For Visually Impaired',
        imagePath: 'assets/images/ppth.png',
        gradient: const LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
        ),
        isTablet: isTablet,
      ),
      ProjectCard(
        title: 'Little Lemon',
        subtitle: 'Restaurant Reservation App',
        imagePath: 'assets/images/res.png',
        gradient: const LinearGradient(
          colors: [Color(0xFFEC4899), Color(0xFFF43F5E)],
        ),
        isTablet: isTablet,
      ),
      ProjectCard(
        title: 'MiniRT',
        subtitle: 'Ray Tracing with C',
        imagePath: 'assets/images/minirt.png',
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)],
        ),
        isTablet: isTablet,
      ),
      ProjectCard(
        title: 'RUN',
        subtitle: 'Fitness Running App',
        imagePath: 'assets/images/r.png',
        gradient: const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF059669)],
        ),
        isTablet: isTablet,
      ),
      ProjectCard(
        title: 'Webserv',
        subtitle: 'A WebServer',
        imagePath: 'assets/images/webserv.png',
        gradient: const LinearGradient(
          colors: [Color(0xFFF59E0B), Color(0xFFEF4444)],
        ),
        isTablet: isTablet,
      ),
    ];
  }
}

class ProjectCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final LinearGradient gradient;
  final bool isTablet;

  const ProjectCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.gradient,
    this.isTablet = false,
  }) : super(key: key);

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final cardWidth = isMobile
        ? double.infinity
        : (widget.isTablet ? 320.0 : 380.0);
    final cardHeight = isMobile ? 400.0 : (widget.isTablet ? 480.0 : 540.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectDetailPage(
                title: widget.title,
                subtitle: widget.subtitle,
                details: getProjectDetails(widget.title),
              ),
            ),
          );
        },
        child: AnimatedContainer(
          duration: AppAnimations.normal,
          curve: AppAnimations.defaultCurve,
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -10.0 : 0.0),
          width: cardWidth,
          height: cardHeight,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.cardBackground.withOpacity(0.8),
              border: Border.all(
                color: _isHovered
                    ? AppColors.primary
                    : AppColors.primary.withOpacity(0.5),
                width: 3,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.4),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // DOS-style title bar
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? AppColors.primary
                        : AppColors.primary.withOpacity(0.8),
                    border: Border(
                      bottom: BorderSide(color: AppColors.primary, width: 2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '█ ',
                        style: GoogleFonts.courierPrime(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 4 : 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            color: AppColors.primary,
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '╔═══ ${widget.title.toUpperCase()} ═══╗',
                              style: GoogleFonts.courierPrime(
                                fontSize: isMobile ? 12 : 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.3,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '[█]',
                        style: GoogleFonts.courierPrime(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Image Section with DOS frame
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.black,
                          child: Center(
                            child: Image.asset(
                              widget.imagePath,
                              width: double.infinity,
                              height: double.infinity,
                              fit: isMobile ? BoxFit.contain : BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return _buildPlaceholder();
                              },
                            ),
                          ),
                        ),
                        if (_isHovered)
                          Positioned.fill(
                            child: Container(
                              color: AppColors.primary.withOpacity(0.2),
                              child: Center(
                                child: Text(
                                  '>>> CLICK TO OPEN <<<',
                                  style: GoogleFonts.courierPrime(
                                    fontSize: isMobile ? 14 : 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    backgroundColor: AppColors.primary,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                // DOS-style info section
                Container(
                  padding: EdgeInsets.all(isMobile ? 12.0 : 16.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    border: Border(
                      top: BorderSide(
                        color: AppColors.primary.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'FILE: ${widget.title.toUpperCase()}.EXE',
                        style: GoogleFonts.courierPrime(
                          color: AppColors.primary,
                          fontSize: isMobile ? 11 : 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.subtitle.toUpperCase(),
                        style: GoogleFonts.courierPrime(
                          color: AppColors.textSecondary,
                          fontSize: isMobile ? 10 : 11,
                          letterSpacing: 0,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '█ PROJECT DATA █',
              style: GoogleFonts.courierPrime(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '>>> LOADING... <<<',
              style: GoogleFonts.courierPrime(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
