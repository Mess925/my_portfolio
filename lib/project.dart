import 'package:flutter/material.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  static const List<ProjectItem> _projects = [
    ProjectItem(
      title: 'Little Lemon',
      description:
          'Flutter web portfolio with smooth sections and theme toggle.',
      tags: ['Flutter', 'Web', 'UI'],
    ),
    ProjectItem(
      title: 'miniRT',
      description:
          'A small ray tracer with lighting, normals, and reflections.',
      tags: ['C', 'Math', 'Graphics'],
    ),
    ProjectItem(
      title: 'Protective Path',
      description: 'Threading + mutexes with strict timing constraints.',
      tags: ['C', 'Threads', 'Mutex'],
    ),
    ProjectItem(
      title: 'MiniShell',
      description: 'Parsing and executing commands with pipes and semicolons.',
      tags: ['C', 'Parsing', 'Unix'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.sizeOf(context).width;

    double horizontalPadding;
    double titleSize;
    double cardWidth;

    if (screenWidth < 600) {
      horizontalPadding = 16;
      titleSize = 28;
      cardWidth = screenWidth - (horizontalPadding * 2);
    } else if (screenWidth < 1000) {
      horizontalPadding = 24;
      titleSize = 36;
      cardWidth = (screenWidth - (horizontalPadding * 2) - 20) / 2;
    } else {
      horizontalPadding = 40;
      titleSize = 44;
      cardWidth = 340;
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 60,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Projects',
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w800,
                  color: cs.primary,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: _projects
                    .map(
                      (project) => SizedBox(
                        width: cardWidth.clamp(260.0, 360.0),
                        child: ProjectCard(project: project),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 40),
              Center(
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('More on my GitHub'),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_ios_sharp, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectItem {
  final String title;
  final String description;
  final List<String> tags;

  const ProjectItem({
    required this.title,
    required this.description,
    required this.tags,
  });
}

class ProjectCard extends StatelessWidget {
  final ProjectItem project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: cs.outline.withOpacity(0.35)),
        color: cs.surface,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: cs.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  project.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: cs.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            project.description,
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              color: cs.onSurface.withOpacity(0.75),
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: project.tags
                .map(
                  (t) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: cs.primary.withOpacity(0.35)),
                      color: cs.primary.withOpacity(0.08),
                    ),
                    child: Text(
                      t,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: cs.primary,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: cs.primary.withOpacity(0.6)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Details'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('GitHub'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
