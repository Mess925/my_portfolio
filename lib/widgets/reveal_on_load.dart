import 'package:flutter/material.dart';

/// Fades and slides a section up on first build, staggered by [delay] —
/// gives the page an entrance instead of every section appearing at once.
class RevealOnLoad extends StatefulWidget {
  const RevealOnLoad({super.key, required this.child, this.delay = Duration.zero});

  final Widget child;
  final Duration delay;

  @override
  State<RevealOnLoad> createState() => _RevealOnLoadState();
}

class _RevealOnLoadState extends State<RevealOnLoad> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      child: AnimatedSlide(
        offset: _visible ? Offset.zero : const Offset(0, 0.04),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}
