import 'package:flutter/material.dart';

import 'theme/tokens.dart';
import 'widgets/hover_link.dart';
import 'widgets/video_embed.dart';

/// Served from `web/videos/` (compressed to stay under GitHub's 100 MB file
/// limit). The query string keeps Flutter's service worker from trying to
/// cache the whole file, so the browser streams and seeks it natively.
const String _videoUrl = 'videos/evaluation.mp4?stream=1';

/// Standalone page for the Thales internship evaluation video — reached from
/// the Experience section, and directly at `/#/evaluation`.
class EvaluationPage extends StatelessWidget {
  const EvaluationPage({super.key});

  static const routeName = '/evaluation';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.sizeOf(context).width < 700;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? AppSpacing.lg : AppSpacing.xl,
            vertical: AppSpacing.xl,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 880),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HoverLink(
                    text: '← Back',
                    underlineAtRest: false,
                    style: theme.textTheme.labelLarge,
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Text(
                    'Final internship evaluation',
                    style: theme.textTheme.displayLarge?.copyWith(
                      fontSize: isMobile ? 40 : 56,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Software Engineer Intern · Thales DIS · Singapore · '
                    'Feb – Jul 2026',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const VideoEmbed(
                    url: _videoUrl,
                    title: 'Final internship evaluation',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
