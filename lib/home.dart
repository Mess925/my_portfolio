import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'about.dart';
import 'project.dart';
import 'contact.dart';

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final ThemeMode themeMode;

  const HomePage({
    super.key,
    required this.toggleTheme,
    required this.themeMode,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  static const _tabs = <String>["About", "Projects", "Contact"];

  late final TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  final List<GlobalKey> _sectionKeys = List.generate(
    _tabs.length,
    (_) => GlobalKey(),
  );

  bool _isProgrammaticScroll = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _scrollToSection(_tabController.index);
      }
    });

    _scrollController.addListener(_syncTabWithScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncTabWithScroll();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _scrollToSection(int index) async {
    final ctx = _sectionKeys[index].currentContext;
    if (ctx == null) return;

    _isProgrammaticScroll = true;

    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 520),
      curve: Curves.easeOutCubic,
      alignment: 0.0,
    );

    await Future.delayed(const Duration(milliseconds: 80));
    _isProgrammaticScroll = false;
  }

  void _syncTabWithScroll() {
    if (_isProgrammaticScroll) return;

    final topTarget = kToolbarHeight + MediaQuery.of(context).padding.top;

    int bestIndex = 0;
    double bestDist = double.infinity;

    for (int i = 0; i < _sectionKeys.length; i++) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx == null) continue;

      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) continue;

      final dy = box.localToGlobal(Offset.zero).dy;
      final dist = (dy - topTarget).abs();

      if (dist < bestDist) {
        bestDist = dist;
        bestIndex = i;
      }
    }

    if (_tabController.index != bestIndex) {
      _tabController.animateTo(bestIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final viewportHeight = media.size.height;
    final safeTop = media.padding.top;

    final sectionHeight = viewportHeight - (kToolbarHeight + safeTop);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: _SectionSized(
                key: _sectionKeys[0],
                height: sectionHeight,
                child: const AboutPage(),
              ),
            ),
            SliverToBoxAdapter(
              child: _SectionSized(
                key: _sectionKeys[1],
                height: sectionHeight,
                child: const ProjectPage(),
              ),
            ),
            SliverToBoxAdapter(
              child: _SectionSized(
                key: _sectionKeys[2],
                height: sectionHeight,
                child: const ContactPage(),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AppBar(
      title: TabBar(
        controller: _tabController,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: cs.primary.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding: const EdgeInsets.symmetric(horizontal: 16),
        splashBorderRadius: BorderRadius.circular(8),
        overlayColor: WidgetStateProperty.all(
          cs.primary.withValues(alpha: 0.05),
        ),
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        tabs: _tabs.map((t) => Tab(text: t)).toList(),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: _ThemeToggleButton(
            themeMode: widget.themeMode,
            onToggle: widget.toggleTheme,
          ),
        ),
      ],
    );
  }
}

class _SectionSized extends StatelessWidget {
  final double height;
  final Widget child;

  const _SectionSized({super.key, required this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, child: child);
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
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 280),
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
            angle: _animation.value * math.pi,
            child: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          );
        },
      ),
    );
  }
}
