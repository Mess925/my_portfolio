import 'package:flutter/material.dart';
import 'ProjectDetailPage.dart';
import 'dart:ui';

class ProjectPage extends StatelessWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
        child: ScrollConfiguration(
          // Add a custom scroll behavior that
          // allows all devices to drag the list.
          behavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {...PointerDeviceKind.values},
          ),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          ProjectCard(
                            title: 'ProtectivePath',
                            subtitle: 'Navigation App For Visually Impaired',
                            imagePath: 'images/ppth.png',
                            route: '/protective-path',
                          ),
                          SizedBox(width: 30),
                          ProjectCard(
                            title: 'Little Lemon',
                            subtitle: 'Restaurant Reservation App',
                            imagePath: 'images/res.png',
                            route: '/little-lemon',
                          ),
                          SizedBox(width: 30),
                          ProjectCard(
                            title: 'MiniRT',
                            subtitle: 'Ray Tracing with C',
                            imagePath: 'images/minirt.png',
                            route: '/minirt',
                          ),
                          SizedBox(width: 30),
                          ProjectCard(
                            title: 'RUN',
                            subtitle: 'Fitness Running App',
                            imagePath: 'images/r.png',
                            route: '/run',
                          ),
                          SizedBox(width: 30),
                          ProjectCard(
                            title: 'Webserv',
                            subtitle: 'A WebServer',
                            imagePath: 'images/project5.png',
                            route: '/webserv',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const NavButton({Key? key, required this.text, required this.onTap})
    : super(key: key);

  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isHovered ? 0.6 : 1.0,
          child: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              letterSpacing: 2,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final String route;

  const ProjectCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.route,
  }) : super(key: key);

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Fixed card dimensions for horizontal scrolling
    final cardWidth = 350.0;
    final cardHeight = 500.0;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectDetailPage(
                title: widget.title,
                subtitle: widget.subtitle,
              ),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, isHovered ? -10 : 0, 0),
          width: cardWidth,
          height: cardHeight,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(20),
              boxShadow: isHovered
                  ? [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.4),
                        blurRadius: 40,
                        offset: const Offset(0, 20),
                      ),

                      BoxShadow(
                        color: Colors.white.withOpacity(0.4),
                        blurRadius: 40,
                        offset: const Offset(0, -20),
                      ),
                    ]
                  : [],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image Container (75% of card height)
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Center(
                      child: Image.asset(
                        widget.imagePath,
                        fit: BoxFit.cover,
                        // height: d,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFF404040),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.broken_image,
                                    size: 60,
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'On Going Project',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                // Text Container (25% of card height)
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.subtitle,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
