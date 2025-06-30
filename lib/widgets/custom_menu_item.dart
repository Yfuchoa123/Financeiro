// lib/widgets/custom_menu_item.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_financeiro_pessoal/providers/favorites_provider.dart';

class CustomMenuItem extends ConsumerStatefulWidget {
  final IconData? icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final List<Widget>? children;
  final bool initiallyExpanded;
  final ValueChanged<bool>? onExpansionChanged;
  final bool isFavoritable;

  const CustomMenuItem({
    super.key,
    this.icon,
    required this.title,
    this.isSelected = false,
    required this.onTap,
    this.children,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.isFavoritable = false,
  });

  @override
  ConsumerState<CustomMenuItem> createState() => _CustomMenuItemState();
}

class _CustomMenuItemState extends ConsumerState<CustomMenuItem> {
  bool _isExpanded = false;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoritesProvider);
    final isFavorited = favorites[widget.title] ?? false;

    // Lógica para o menu expansível (com filhos)
    if (widget.children != null && widget.children!.isNotEmpty) {
      return Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
              if (widget.onExpansionChanged != null) {
                widget.onExpansionChanged!(_isExpanded);
              }
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  if (widget.icon != null) ...[
                    SizedBox(
                        width: 24.0,
                        child: Icon(widget.icon, color: Colors.black54)),
                    const SizedBox(width: 16.0),
                  ],
                  // Garantindo que o título não cause overflow
                  Expanded(
                      child: Text(widget.title,
                          style: const TextStyle(color: Colors.black87))),
                  Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.black54),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: Column(
              children: _isExpanded
                  ? widget.children!
                      .map((child) => Padding(
                          padding: const EdgeInsets.only(left: 48.0),
                          child: child))
                      .toList()
                  : [],
            ),
          ),
        ],
      );
    }

    // Lógica para o item de menu simples (sem filhos)
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Material(
        color: widget.isSelected ? Colors.grey[200] : Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  SizedBox(
                      width: 24.0,
                      child: Icon(widget.icon, color: Colors.black54)),
                  const SizedBox(width: 16.0),
                ],
                // Garantindo que o título não cause overflow
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(color: Colors.black87),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (widget.isFavoritable && (_isHovering || isFavorited))
                  IconButton(
                    icon: Icon(isFavorited ? Icons.star : Icons.star_border,
                        color: Colors.amber[700]),
                    onPressed: () {
                      ref
                          .read(favoritesProvider.notifier)
                          .setFavorite(widget.title);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
