import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      animationDuration: const Duration(milliseconds: 400),
      length: 3,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          children: [AboutPage(), ProjectPage(), ContactPage()],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 1,
      titleSpacing: 0,
      title: TabBar(
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding: const EdgeInsets.symmetric(horizontal: 16),
        splashBorderRadius: BorderRadius.circular(8),
        overlayColor: WidgetStateProperty.all(
          Theme.of(context).colorScheme.primary.withOpacity(0.05),
        ),
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        tabs: const [
          Tab(text: "About"),
          Tab(text: "Projects"),
          Tab(text: "Contact"),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: _ThemeToggleButton(
            themeMode: themeMode,
            onToggle: toggleTheme,
          ),
        ),
      ],
    );
  }
}

class _ThemeToggleButton extends StatefulWidget {
  final ThemeMode themeMode;
  final VoidCallback onToggle;

  const _ThemeToggleButton({required this.themeMode, required this.onToggle});

  @override
  State<_ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<_ThemeToggleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleToggle() {
    _controller.forward(from: 0);
    HapticFeedback.lightImpact();
    widget.onToggle();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.themeMode == ThemeMode.dark;

    return IconButton(
      onPressed: _handleToggle,
      tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
      icon: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _animation.value * 3.14159,
            child: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          );
        },
      ),
    );
  }
}

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with AutomaticKeepAliveClientMixin {
  static const double _smallBreakpoint = 700.0;
  static const double _mediumBreakpoint = 900.0;
  static const double _largeBreakpoint = 1000.0;
  static const double _maxContentWidth = 1200.0;

  @override
  bool get wantKeepAlive => true;

  double _getHeadlineSize(double width) {
    if (width < _smallBreakpoint) return 64.0;
    if (width < _largeBreakpoint) return 84.0;
    return 104.0;
  }

  EdgeInsets _getPadding(double width) {
    return EdgeInsets.symmetric(
      horizontal: width < _smallBreakpoint ? 24 : 80,
      vertical: width < _smallBreakpoint ? 32 : 60,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final headlineSize = _getHeadlineSize(screenWidth);
    final isNarrow = screenWidth < _mediumBreakpoint;

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: _getPadding(screenWidth),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: _maxContentWidth,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: isNarrow
                          ? _AboutColumnLayout(
                              key: const ValueKey('column'),
                              headline: headlineSize,
                            )
                          : _AboutRowLayout(
                              key: const ValueKey('row'),
                              headline: headlineSize,
                            ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AboutRowLayout extends StatelessWidget {
  final double headline;

  const _AboutRowLayout({super.key, required this.headline});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: _FadeInWidget(
            delay: const Duration(milliseconds: 150),
            child: _AboutTextBlock(headline: headline),
          ),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 2,
          child: _FadeInWidget(
            delay: const Duration(milliseconds: 300),
            child: const _AboutImageBlock(),
          ),
        ),
      ],
    );
  }
}

class _AboutColumnLayout extends StatelessWidget {
  final double headline;

  const _AboutColumnLayout({super.key, required this.headline});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FadeInWidget(
          delay: const Duration(milliseconds: 150),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: const _AboutImageBlock(),
            ),
          ),
        ),
        const SizedBox(height: 40),
        _FadeInWidget(
          delay: const Duration(milliseconds: 300),
          child: _AboutTextBlock(headline: headline),
        ),
      ],
    );
  }
}

class _FadeInWidget extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const _FadeInWidget({required this.child, this.delay = Duration.zero});

  @override
  State<_FadeInWidget> createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<_FadeInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
          ),
        );

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(position: _slideAnimation, child: widget.child),
    );
  }
}

class _AboutTextBlock extends StatelessWidget {
  final double headline;

  static const String _greeting = "Hi, I'm";
  static const String _fullName = "HAN MIN THANT";
  static const String _bio =
      "A passionate Software Engineer specializing in Mobile Development. "
      "I craft high-quality mobile applications with seamless user experiences and intuitive interfaces. "
      "Always exploring new technologies and best practices to deliver exceptional results.";

  static const double _maxBioWidth = 600.0;

  const _AboutTextBlock({required this.headline});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _greeting,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface.withValues(alpha: 0.6),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        _buildNameDisplay(textTheme, colorScheme),
        const SizedBox(height: 24),
        _buildRoleChip(colorScheme, textTheme),
        const SizedBox(height: 32),
        _buildBio(textTheme, colorScheme),
      ],
    );
  }

  Widget _buildNameDisplay(TextTheme textTheme, ColorScheme colorScheme) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          colorScheme.primary,
          colorScheme.primary.withValues(alpha: 0.8),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        _fullName,
        style: textTheme.displayLarge?.copyWith(
          fontSize: headline,
          fontWeight: FontWeight.w900,
          height: 1.1,
          letterSpacing: -2.0,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildRoleChip(ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.primaryContainer.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.flutter_dash,
            size: 20,
            color: colorScheme.onPrimaryContainer,
          ),
          const SizedBox(width: 10),
          Text(
            'Mobile Developer',
            style: textTheme.titleSmall?.copyWith(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBio(TextTheme textTheme, ColorScheme colorScheme) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: _maxBioWidth),
      child: Text(
        _bio,
        style: textTheme.bodyLarge?.copyWith(
          height: 1.7,
          fontSize: 17,
          color: colorScheme.onSurface.withValues(alpha: 0.75),
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _AboutImageBlock extends StatelessWidget {
  static const double _minImageWidth = 200.0;
  static const double _maxImageWidth = 450.0;
  static const String _darkModeImage = 'assets/images/pfw.png';
  static const String _lightModeImage = 'assets/images/pfb.png';

  const _AboutImageBlock();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final imagePath = isDark ? _darkModeImage : _lightModeImage;

    return Align(
      alignment: Alignment.centerRight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final constrainedWidth = constraints.maxWidth.clamp(
            _minImageWidth,
            _maxImageWidth,
          );

          return ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              semanticLabel: 'Profile image of Han Min Thant',
              cacheWidth: (constrainedWidth * 2).toInt(),
            ),
          );
        },
      ),
    );
  }

}
