import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 600;

    final nameSize = isMobile ? 52.0 : 92.0;
    final padding = isMobile ? 20.0 : 32.0;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 400),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, I'm",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade500,
                  letterSpacing: 1.2,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                "Han",
                style: TextStyle(
                  fontSize: nameSize,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                "Min Thant",
                style: TextStyle(
                  fontSize: nameSize,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
