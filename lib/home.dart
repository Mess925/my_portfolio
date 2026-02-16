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
    return Padding(padding: EdgeInsets.all(80.0), child: Text("Welcome to my portfolio! I'm a passionate developer with experience in Flutter, Dart, and various other technologies. I enjoy creating beautiful and functional applications that provide great user experiences. Feel free to explore my projects and contact me for any inquiries!"));
  }
}
