import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'AboutMe.dart';
import 'Home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const ScrollablePages(),
    );
  }
}

class ScrollablePages extends StatefulWidget {
  const ScrollablePages({super.key});

  @override
  State<ScrollablePages> createState() => _ScrollablePagesState();
}

class _ScrollablePagesState extends State<ScrollablePages> {
  final PageController _controller = PageController();
  // int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToPage(int page) {
    _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(context),
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.vertical,
        // onPageChanged: (int page) {
        //   setState(() {
        //     _currentPage = page;
        //   });
        // },
        children: [
          HomePage(onNavigate: _navigateToPage),
          const AboutMePage(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      toolbarHeight: 60,
      actions: <Widget>[
        _NavButton(label: 'HOME', onPressed: () => _navigateToPage(0)),
        _NavButton(label: 'ABOUT ME', onPressed: () => _navigateToPage(1)),
        _NavButton(
          label: 'PROJECTS',
          onPressed: () {
            // TODO: Implement projects page
          },
        ),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _NavButton({required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: GoogleFonts.abrilFatface(
          fontSize: 16,
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class PhotoSection extends StatelessWidget {
  final bool isMobile;

  const PhotoSection({Key? key, required this.isMobile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(isMobile ? 40 : 60),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: isMobile ? 300 : 700,
          maxHeight: isMobile ? 300 : 700,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/images/profile.jpg', // Replace with your image path
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // Placeholder when image is not found
              return Container(
                color: Colors.white.withOpacity(0.1),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: isMobile ? 100 : 150,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Add your photo here',
                        style: GoogleFonts.abrilFatface(
                          fontSize: isMobile ? 18 : 24,
                          color: Colors.white.withOpacity(0.7),
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
    );
  }
}

class HeroSection extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;

  const HeroSection({required this.isMobile, required this.isTablet});

  double _getFontSize(double mobile, double tablet, double desktop) {
    if (isMobile) return mobile;
    if (isTablet) return tablet;
    return desktop;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: isMobile ? 150 : 200),
          child: Text(
            'I am',
            style: GoogleFonts.abrilFatface(
              fontSize: _getFontSize(18, 22, 24),
              color: Colors.white,
              letterSpacing: 2,
              height: 0.1,
            ),
          ),
        ),
        Text(
          'HAN',
          style: GoogleFonts.abrilFatface(
            fontSize: _getFontSize(94, 110, 128),
            color: Colors.white,
            height: 0.9,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Mobile App Developer',
          style: GoogleFonts.abrilFatface(
            fontSize: _getFontSize(19, 23, 26),
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 40),
        SocialButtonsRow(isMobile: isMobile),
      ],
    );
  }
}
