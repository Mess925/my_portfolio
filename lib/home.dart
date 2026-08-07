import 'package:flutter/material.dart';

import 'about.dart';
import 'contact.dart';
import 'experience.dart';
import 'project.dart';
import 'theme/tokens.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 600;
    final horizontalPadding = isMobile ? AppSpacing.lg : AppSpacing.xxl;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            isMobile ? AppSpacing.xxxl : 120,
            horizontalPadding,
            isMobile ? AppSpacing.xxxl : AppSpacing.section * 2,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeroHeader(),
                  const SizedBox(height: AppSpacing.section),
                  const AboutSection(),
                  const SizedBox(height: AppSpacing.section),
                  const ExperienceSection(),
                  const SizedBox(height: AppSpacing.section),
                  const ProjectsSection(),
                  const SizedBox(height: AppSpacing.section),
                  const SkillsSection(),
                  const SizedBox(height: AppSpacing.section),
                  const ContactSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
