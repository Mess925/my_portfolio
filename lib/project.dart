import 'package:flutter/material.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.sizeOf(context).width;

    int crossAxisCount;
    double aspectRatio;
    double horizontalPadding;
    double titleSize;

    if (screenWidth < 600) {
      crossAxisCount = 1;
      aspectRatio = 1.3;
      horizontalPadding = 16;
      titleSize = 28;
    } else if (screenWidth < 1000) {
      crossAxisCount = 2;
      aspectRatio = 1.0;
      horizontalPadding = 24;
      titleSize = 36;
    } else {
      crossAxisCount = 4;
      aspectRatio = 0.85;
      horizontalPadding = 40;
      titleSize = 44;
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
                "Projects",
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w800,
                  color: cs.primary,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 40),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                shrinkWrap: true,
                childAspectRatio: aspectRatio,
                children: const [
                  _ProjectCard(
                    title: "Little Lemon",
                    description:
                        "Flutter web portfolio with smooth sections and theme toggle.",
                    tags: ["Flutter", "Web", "UI"],
                  ),
                  _ProjectCard(
                    title: "miniRT",
                    description:
                        "A small ray tracer with lighting, normals, and reflections.",
                    tags: ["C", "Math", "Graphics"],
                  ),
                  _ProjectCard(
                    title: "Protective Path",
                    description:
                        "Threading + mutexes with strict timing constraints.",
                    tags: ["C", "Threads", "Mutex"],
                  ),
                  _ProjectCard(
                    title: "MiniShell",
                    description:
                        "Parsing and executing commands with pipes and semicolons.",
                    tags: ["C", "Parsing", "Unix"],
                  ),
                ],
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
                      Text("More on my GitHub"),
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

class _ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> tags;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: cs.outline.withOpacity(0.6)),
        color: cs.surface,
      ),
      child: Column(
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
                  title,
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
            description,
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              color: cs.onSurface.withOpacity(0.75),
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags
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
                  ),
                  child: const Text("Details"),
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
                  ),
                  child: const Text("GitHub"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
