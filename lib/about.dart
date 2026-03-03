import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Column(
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
                              fontSize: 92,
                              letterSpacing: 2.5,
                              fontWeight: FontWeight.bold,
                              height: 1.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            "Min Thant",
                            style: TextStyle(
                              fontSize: 92,
                              letterSpacing: 2.5,
                              fontWeight: FontWeight.bold,
                              height: 1.0,
                              fontStyle: FontStyle.italic
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
