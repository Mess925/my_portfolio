import 'package:flutter/material.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Project Page"), centerTitle: true),
      body: Center(child: Text("Welcome to the Project Page!")),
    );
  }
}