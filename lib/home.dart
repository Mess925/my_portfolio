import 'dart:io' show Platform;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'about.dart';
import 'experience.dart';
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
  late final TabController _tabController;
  late final ScrollController _scrollController;
  late final List<GlobalKey> _sectionKeys;

  bool _isProgrammaticScroll = false;

  final List<_SectionItem> _sections = const [
    _SectionItem(
      title: 'About',
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      child: AboutPage(),
    ),
    _SectionItem(
      title: 'Experience',
      icon: Icons.work_history_outlined,
      selectedIcon: Icons.work_history,
      child: ExperiencePage(),
    ),
    _SectionItem(
      title: 'Projects',
      icon: Icons.code_outlined,
      selectedIcon: Icons.code,
      child: ProjectPage(),
    ),
    _SectionItem(
      title: 'Contact',
      icon: Icons.mail_outline,
      selectedIcon: Icons.mail,
      child: ContactPage(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _sections.length, vsync: this);
    _scrollController = ScrollController();
    _sectionKeys = List.generate(_sections.length, (_) => GlobalKey());

    _tabController.addListener(_handleTabChange);
    _scrollController.addListener(_syncTabWithScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _syncTabWithScroll();
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _scrollController.removeListener(_syncTabWithScroll);
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  bool _isNarrow(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      _scrollToSection(_tabController.index);
    }
  }

  Future<void> _scrollToSection(int index) async {
    final ctx = _sectionKeys[index].currentContext;
    if (ctx == null) return;

    _isProgrammaticScroll = true;

    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      alignment: 0,
    );

    if (!mounted) return;

    await Future.delayed(const Duration(milliseconds: 80));
    if (mounted) {
      _isProgrammaticScroll = false;
    }
  }

  void _syncTabWithScroll() {
    if (_isProgrammaticScroll || !mounted) return;

    final media = MediaQuery.of(context);
    final topTarget = kToolbarHeight + media.padding.top;

    int closestIndex = 0;
    double closestDistance = double.infinity;

    for (int i = 0; i < _sectionKeys.length; i++) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx == null) continue;

      final renderObject = ctx.findRenderObject();
      if (renderObject is! RenderBox || !renderObject.hasSize) continue;

      final dy = renderObject.localToGlobal(Offset.zero).dy;
      final distance = (dy - topTarget).abs();

      if (distance < closestDistance) {
        closestDistance = distance;
        closestIndex = i;
      }
    }

    if (_tabController.index != closestIndex) {
      _tabController.animateTo(closestIndex);
    }
  }

  ScrollPhysics _platformScrollPhysics() {
    try {
      if (Platform.isIOS || Platform.isMacOS) {
        return const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        );
      }
    } catch (_) {
      // Platform checks can fail on web
    }

    return const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final narrow = _isNarrow(context);

    final viewportHeight = media.size.height;
    final safeTop = media.padding.top;
    final safeBottom = media.padding.bottom;
    final keyboardHeight = media.viewInsets.bottom;

    final sectionMinHeight =
        viewportHeight - kToolbarHeight - safeTop - keyboardHeight;

    return Scaffold(
      appBar: _buildAppBar(context, narrow: narrow),
      bottomNavigationBar: narrow ? _buildBottomNav() : null,
      body: SafeArea(
        top: false,
        bottom: true,
        child: CustomScrollView(
          controller: _scrollController,
          physics: _platformScrollPhysics(),
          slivers: [
            for (int i = 0; i < _sections.length; i++)
              SliverToBoxAdapter(
                child: _SectionSized(
                  key: _sectionKeys[i],
                  minHeight: sectionMinHeight < 320 ? 320 : sectionMinHeight,
                  child: _sections[i].child,
                ),
              ),
            SliverToBoxAdapter(child: SizedBox(height: safeBottom + 24)),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context, {
    required bool narrow,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (narrow) {
      return AppBar(
        title: AnimatedBuilder(
          animation: _tabController,
          builder: (_, __) {
            return Text(
              _sections[_tabController.index].title,
              style: theme.textTheme.titleMedium,
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _ThemeToggleButton(
              themeMode: widget.themeMode,
              onToggle: widget.toggleTheme,
            ),
          ),
        ],
      );
    }

    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 88,
      leading: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Center(
          child: Text(
            '~/hmt',
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: colorScheme.primary,
            ),
          ),
        ),
      ),
      title: TabBar(
        controller: _tabController,
        dividerColor: Colors.transparent,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2, color: colorScheme.primary),
          insets: const EdgeInsets.symmetric(horizontal: 20),
        ),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: colorScheme.primary,
        unselectedLabelColor: colorScheme.onSurface.withOpacity(0.6),
        labelStyle: theme.textTheme.labelMedium?.copyWith(fontSize: 13),
        unselectedLabelStyle: theme.textTheme.labelMedium?.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        overlayColor: WidgetStatePropertyAll(
          colorScheme.primary.withOpacity(0.06),
        ),
        tabs: [for (final section in _sections) Tab(text: section.title)],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: _ThemeToggleButton(
            themeMode: widget.themeMode,
            onToggle: widget.toggleTheme,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return AnimatedBuilder(
      animation: _tabController,
      builder: (_, __) {
        final theme = Theme.of(context);
        final cs = theme.colorScheme;
        final isDark = theme.brightness == Brightness.dark;

        return NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: cs.surface,
            indicatorColor: isDark
                ? cs.primary.withOpacity(0.22)
                : cs.primary.withOpacity(0.12),
            iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
              final selected = states.contains(WidgetState.selected);
              return IconThemeData(
                size: 24,
                color: selected
                    ? cs.primary
                    : cs.onSurface.withOpacity(isDark ? 0.72 : 0.65),
              );
            }),
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
              states,
            ) {
              final selected = states.contains(WidgetState.selected);
              return theme.textTheme.labelMedium!.copyWith(
                fontSize: 11,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected
                    ? cs.primary
                    : cs.onSurface.withOpacity(isDark ? 0.72 : 0.65),
              );
            }),
          ),
          child: NavigationBar(
            selectedIndex: _tabController.index,
            onDestinationSelected: (index) {
              _tabController.animateTo(index);
            },
            height: 68,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: [
              for (final section in _sections)
                NavigationDestination(
                  icon: Icon(section.icon),
                  selectedIcon: Icon(section.selectedIcon),
                  label: section.title,
                ),
            ],
          ),
        );
      },
    );
  }
}

class _SectionItem {
  final String title;
  final IconData icon;
  final IconData selectedIcon;
  final Widget child;

  const _SectionItem({
    required this.title,
    required this.icon,
    required this.selectedIcon,
    required this.child,
  });
}

class _SectionSized extends StatelessWidget {
  final double minHeight;
  final Widget child;

  const _SectionSized({
    super.key,
    required this.minHeight,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight),
      child: child,
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
  late final AnimationController _controller;
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 280),
      vsync: this,
    );
    _rotation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    HapticFeedback.lightImpact();
    _controller.forward(from: 0);
    widget.onToggle();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = widget.themeMode == ThemeMode.dark;

    return IconButton(
      onPressed: _toggle,
      tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
      color: cs.onSurface,
      icon: AnimatedBuilder(
        animation: _rotation,
        builder: (_, __) {
          return Transform.rotate(
            angle: _rotation.value * math.pi,
            child: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: cs.onSurface,
            ),
          );
        },
      ),
    );
  }
}
