// about_section.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constants.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimations.verySlow,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

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

    return SingleChildScrollView(
      padding: Responsive.pagePadding(context),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  SizedBox(height: isMobile ? 40 : 60),
                  _buildBio(context),
                  SizedBox(height: isMobile ? 40 : 60),
                  _buildSkills(context),
                  SizedBox(height: isMobile ? 40 : 60),
                  _buildSocialLinks(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          'MEET',
          style: GoogleFonts.inter(
            fontSize: Responsive.fontSize(
              context,
              mobile: 14,
              tablet: 16,
              desktop: 18,
            ),
            color: AppColors.primaryCyan,
            letterSpacing: 4,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.primaryGradient.createShader(bounds),
          child: Text(
            'HAN MIN THANT',
            style: GoogleFonts.abrilFatface(
              fontSize: Responsive.fontSize(
                context,
                mobile: 48,
                tablet: 72,
                desktop: 96,
              ),
              color: Colors.white,
              height: 1.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Mobile App Developer',
          style: GoogleFonts.inter(
            fontSize: Responsive.fontSize(
              context,
              mobile: 20,
              tablet: 24,
              desktop: 28,
            ),
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w300,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildBio(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Text(
        '''I'm a recent Computer Science graduate with First Class Honours from Coventry University. Currently honing my coding skills at 42 Singapore, I'm passionate about mobile app development.

I specialize in Swift and Flutter for cross-platform applications, with strong backend capabilities in Python. My focus is on creating intuitive, accessible mobile experiences that solve real-world problems.''',
        style: GoogleFonts.inter(
          fontSize: Responsive.fontSize(
            context,
            mobile: 16,
            tablet: 17,
            desktop: 18,
          ),
          color: Colors.white.withOpacity(0.85),
          height: 1.8,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildSkills(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    // Center only on mobile, not on tablet or desktop
    final shouldCenter = isMobile && !isTablet;

    final skills = [
      {
        'name': 'Swift',
        'icon': FontAwesomeIcons.swift,
        'color': const Color(0xFFFF6F00),
      },
      {
        'name': 'Flutter',
        'icon': FontAwesomeIcons.code,
        'color': const Color(0xFF00ACC1),
      },
      {
        'name': 'Dart',
        'icon': FontAwesomeIcons.dartLang,
        'color': const Color(0xFF0175C2),
      },
      {
        'name': 'Python',
        'icon': FontAwesomeIcons.python,
        'color': const Color(0xFF3776AB),
      },
      {
        'name': 'C/C++',
        'icon': FontAwesomeIcons.c,
        'color': const Color(0xFF5C6BC0),
      },
    ];

    return Column(
      crossAxisAlignment: shouldCenter
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: shouldCenter
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Container(
              width: 4,
              height: 32,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              'Technical Stack',
              style: GoogleFonts.abrilFatface(
                fontSize: Responsive.fontSize(
                  context,
                  mobile: 28,
                  tablet: 32,
                  desktop: 36,
                ),
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        isMobile
            ? Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: shouldCenter
                    ? WrapAlignment.center
                    : WrapAlignment.start,
                children: skills.asMap().entries.map((entry) {
                  return TweenAnimationBuilder(
                    duration: Duration(milliseconds: 600 + (entry.key * 100)),
                    tween: Tween<double>(begin: 0, end: 1),
                    curve: AppAnimations.bounceCurve,
                    builder: (context, double value, child) {
                      return Transform.scale(
                        scale: value,
                        child: _SkillChip(skill: entry.value),
                      );
                    },
                  );
                }).toList(),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: skills.asMap().entries.map((entry) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: entry.key < skills.length - 1 ? 16 : 0,
                    ),
                    child: TweenAnimationBuilder(
                      duration: Duration(milliseconds: 600 + (entry.key * 100)),
                      tween: Tween<double>(begin: 0, end: 1),
                      curve: AppAnimations.bounceCurve,
                      builder: (context, double value, child) {
                        return Transform.scale(
                          scale: value,
                          child: _SkillChip(skill: entry.value),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
      ],
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final shouldCenter = isMobile;

    return Column(
      crossAxisAlignment: shouldCenter
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: shouldCenter
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Container(
              width: 4,
              height: 32,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              'Connect With Me',
              style: GoogleFonts.abrilFatface(
                fontSize: Responsive.fontSize(
                  context,
                  mobile: 28,
                  tablet: 32,
                  desktop: 36,
                ),
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        SocialButtonsRow(isMobile: isMobile, isTablet: isTablet),
      ],
    );
  }
}

class _SkillChip extends StatefulWidget {
  final Map<String, dynamic> skill;

  const _SkillChip({required this.skill});

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppAnimations.fast,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isHovered
                ? [
                    widget.skill['color'] as Color,
                    (widget.skill['color'] as Color).withOpacity(0.7),
                  ]
                : [
                    (widget.skill['color'] as Color).withOpacity(0.2),
                    (widget.skill['color'] as Color).withOpacity(0.1),
                  ],
          ),
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusSmall),
          border: Border.all(
            color: (widget.skill['color'] as Color).withOpacity(
              _isHovered ? 0.8 : 0.3,
            ),
            width: 2,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: (widget.skill['color'] as Color).withOpacity(0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              widget.skill['icon'] as IconData,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              widget.skill['name'] as String,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Social Buttons Component
class SocialButtonsRow extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;

  const SocialButtonsRow({
    Key? key,
    required this.isMobile,
    required this.isTablet,
  }) : super(key: key);

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final personalLinks = [
      SocialLink(
        icon: FontAwesomeIcons.instagram,
        url: 'https://www.instagram.com/hthant__/?hl=en',
        label: 'Instagram',
        color: const Color(0xFFE4405F),
      ),
      SocialLink(
        icon: FontAwesomeIcons.github,
        url: 'https://github.com/Mess925',
        label: 'GitHub',
        color: const Color(0xFF333333),
      ),
      SocialLink(
        icon: FontAwesomeIcons.whatsapp,
        url: 'tel:+6588247721',
        label: 'WhatsApp',
        color: const Color(0xFF25D366),
      ),
    ];

    final professionalLinks = [
      SocialLink(
        icon: FontAwesomeIcons.link,
        url: 'https://linktr.ee/han_min',
        label: 'LinkTree',
        color: const Color(0xFF43E55E),
      ),
      SocialLink(
        icon: FontAwesomeIcons.envelope,
        url: 'mailto:hanminthant222@gmail.com',
        label: 'E-Mail',
        color: const Color(0xFFEA4335),
      ),
      SocialLink(
        icon: FontAwesomeIcons.linkedin,
        url: 'https://www.linkedin.com/in/han-min-thant-0b051a283/',
        label: 'LinkedIn',
        color: const Color(0xFF0A66C2),
      ),
    ];

    if (isMobile || isTablet) {
      return Column(
        children: [
          _buildSection('Personal', personalLinks, true),
          const SizedBox(height: 32),
          _buildSection('Professional', professionalLinks, true),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildSection('Personal', personalLinks, false)),
          const SizedBox(width: 80),
          Expanded(
            child: _buildSection('Professional', professionalLinks, false),
          ),
        ],
      );
    }
  }

  Widget _buildSection(
    String header,
    List<SocialLink> links,
    bool isMobileLayout,
  ) {
    return Column(
      crossAxisAlignment: isMobileLayout
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          header,
          style: GoogleFonts.inter(
            fontSize: isMobileLayout ? 18 : 20,
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: isMobileLayout ? 16 : 20),
        isMobileLayout
            ? Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: links
                    .map(
                      (link) => _SocialButton(
                        icon: link.icon,
                        label: link.label,
                        color: link.color,
                        isMobile: isMobileLayout,
                        onTap: () => _launchURL(link.url),
                      ),
                    )
                    .toList(),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < links.length; i++) ...[
                    _SocialButton(
                      icon: links[i].icon,
                      label: links[i].label,
                      color: links[i].color,
                      isMobile: isMobileLayout,
                      onTap: () => _launchURL(links[i].url),
                    ),
                    if (i < links.length - 1) const SizedBox(width: 16),
                  ],
                ],
              ),
      ],
    );
  }
}

class SocialLink {
  final IconData icon;
  final String url;
  final String label;
  final Color color;

  SocialLink({
    required this.icon,
    required this.url,
    required this.label,
    required this.color,
  });
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isMobile;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.isMobile,
    required this.onTap,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final double buttonSize = widget.isMobile ? 70 : 80;
    final double iconSize = widget.isMobile ? 28 : 32;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppAnimations.normal,
          curve: AppAnimations.defaultCurve,
          width: buttonSize,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: AppAnimations.normal,
                curve: AppAnimations.defaultCurve,
                width: buttonSize,
                height: buttonSize,
                decoration: BoxDecoration(
                  gradient: _isHovered
                      ? LinearGradient(
                          colors: [widget.color.withOpacity(0.8), widget.color],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: _isHovered ? null : Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(
                    AppSizes.borderRadiusMedium,
                  ),
                  border: Border.all(
                    color: _isHovered
                        ? widget.color.withOpacity(0.5)
                        : Colors.white.withOpacity(0.15),
                    width: 2,
                  ),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: widget.color.withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: AnimatedScale(
                    duration: AppAnimations.normal,
                    scale: _isHovered ? 1.1 : 1.0,
                    child: FaIcon(
                      widget.icon,
                      color: _isHovered
                          ? Colors.white
                          : Colors.white.withOpacity(0.7),
                      size: iconSize,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: widget.isMobile ? 11 : 12,
                  color: _isHovered
                      ? Colors.white
                      : Colors.white.withOpacity(0.6),
                  fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
