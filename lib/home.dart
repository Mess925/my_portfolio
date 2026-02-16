import 'package:flutter/material.dart';
import 'project.dart';
import 'contact.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(
            tabs: [
              Tab(text: "About"),
              Tab(text: "Projects"),
              Tab(text: "Contact"),
              Spacer(),
              Spacer(),
              Spacer(),
              Spacer(),
              Spacer(),
              Spacer(),
            ],
          ),
          // actions: [], // I will add a logo later.
        ),
        body: const TabBarView(children: [AboutPage(), ProjectPage(), ContactPage()]),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("About Page Content"));
  }
}