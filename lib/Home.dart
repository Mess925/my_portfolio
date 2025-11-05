import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'WelcomePage.dart';

class HomePage extends StatelessWidget {
  final Function(int)? onNavigate;

  const HomePage({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.black],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 800;
          final isTablet =
              constraints.maxWidth >= 800 && constraints.maxWidth < 1200;
          if (isMobile) {
            return Column(
              children: [
                PhotoSection(isMobile: isMobile),
                HeroSection(isMobile: isMobile, isTablet: isTablet),
              ],
            );
          }

          return Row(
            children: [
              Expanded(
                child: Center(
                  child: HeroSection(isMobile: isMobile, isTablet: isTablet),
                ),
              ),
              Expanded(child: PhotoSection(isMobile: isMobile)),
            ],
          );
        },
      ),
    );
  }
}

class SocialButtonsRow extends StatelessWidget {
  final bool isMobile;

  const SocialButtonsRow({required this.isMobile});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final socialLinks = [
      SocialLink(
        icon: FontAwesomeIcons.linkedin,
        url: 'https://www.linkedin.com/in/han-min-thant-0b051a283/',
      ),
      SocialLink(
        icon: FontAwesomeIcons.github,
        url: 'https://github.com/Mess925',
      ),
      SocialLink(
        icon: FontAwesomeIcons.envelope,
        url: 'mailto:your-email@example.com',
      ),
      SocialLink(
        icon: FontAwesomeIcons.link,
        url: 'https://linktr.ee/yourprofile',
      ),
      SocialLink(icon: FontAwesomeIcons.phone, url: 'tel:+1234567890'),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: socialLinks
          .map(
            (link) => _SocialButton(
              icon: link.icon,
              isMobile: isMobile,
              onTap: () => _launchURL(link.url),
            ),
          )
          .toList(),
    );
  }
}

class SocialLink {
  final IconData icon;
  final String url;

  SocialLink({required this.icon, required this.url});
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final bool isMobile;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
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
    final double buttonSize = widget.isMobile ? 40 : 50;
    final double iconSize = widget.isMobile ? 24 : 28;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: _isHovered
              ? Colors.white.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _isHovered
                ? Colors.white.withOpacity(0.3)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: widget.onTap,
          icon: FaIcon(
            widget.icon,
            color: _isHovered ? Colors.white : Colors.white.withOpacity(0.85),
            size: iconSize,
          ),
          tooltip: _getTooltip(widget.icon),
        ),
      ),
    );
  }

  String _getTooltip(IconData icon) {
    if (icon == FontAwesomeIcons.linkedin) return 'LinkedIn';
    if (icon == FontAwesomeIcons.github) return 'GitHub';
    if (icon == FontAwesomeIcons.envelope) return 'Email';
    if (icon == FontAwesomeIcons.link) return 'Links';
    if (icon == FontAwesomeIcons.phone) return 'Phone';
    return '';
  }
}
