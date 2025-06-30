import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading; // Parâmetro para o ícone do menu
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leading, // Adicionado ao construtor
    this.actions,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: leading, // Usado aqui
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize {
    final double bottomHeight = bottom?.preferredSize.height ?? 0;
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }
}
