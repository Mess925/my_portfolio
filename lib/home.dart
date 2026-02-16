import 'package:flutter/material.dart';
import 'project.dart';
import 'contact.dart';

class HomePage extends StatelessWidget {
  final VoidCallback toggleTheme;
  final ThemeMode themeMode;

  const HomePage({
    super.key,
    required this.toggleTheme,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 500),
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            dividerColor: Colors.transparent,
            indicator: BoxDecoration(color: Colors.transparent),
            isScrollable: true,
            tabs: [
              Tab(text: "About"),
              Tab(text: "Projects"),
              Tab(text: "Contact"),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 80.0),
              child: IconButton(
                onPressed: toggleTheme,
                icon: Icon(
                  themeMode == ThemeMode.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
              ),
            ),
          ],
        ),
        body: const TabBarView(
          children: [AboutPage(), ProjectPage(), ContactPage()],
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(80.0),
      child: Row(children: [
        Text('Hello There! I am a software developer with a passion for creating innovative solutions. I have experience in various programming languages and frameworks, and I enjoy working on projects that challenge me to learn and grow. In my free time, I like to explore new technologies and contribute to open-source projects.'),
      ],
    ),
    );
  }
}
