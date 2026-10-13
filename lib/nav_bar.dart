import 'package:flutter/material.dart';
import 'app_colors.dart';

class NavItem {
  final String label;
  final IconData icon;
  const NavItem(this.label, this.icon);
}

const navItems = [
  NavItem('Início', Icons.home_outlined),
  NavItem('Sobre', Icons.person_outline),
  NavItem('Tecnologias', Icons.code),
  NavItem('Projetos', Icons.folder_outlined),
  NavItem('Contato', Icons.mail_outline),
];

enum NavPosition { left, top }

class NavBar extends StatelessWidget {
  final NavPosition position;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final VoidCallback onTogglePosition;

  const NavBar({
    super.key,
    required this.position,
    required this.selectedIndex,
    required this.onSelected,
    required this.onTogglePosition,
  });

  @override
  Widget build(BuildContext context) {
    final isLeft = position == NavPosition.left;

    final tiles = [
      for (int i = 0; i < navItems.length; i++)
        _NavTile(
          item: navItems[i],
          selected: i == selectedIndex,
          onTap: () => onSelected(i),
        ),
    ];

    final name = const Text(
      'Jefferson Sued',
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );

    final toggle = IconButton(
      tooltip: isLeft ? 'Mover menu para o topo' : 'Mover menu para a lateral',
      onPressed: onTogglePosition,
      icon: Icon(
        isLeft ? Icons.vertical_align_top : Icons.view_sidebar_outlined,
        color: AppColors.textMuted,
      ),
    );

    if (isLeft) {
      return Container(
        width: 220,
        color: AppColors.card,
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            name,
            const SizedBox(height: 40),
            ...tiles,
            const Spacer(),
            toggle,
          ],
        ),
      );
    }

    return Container(
      height: 64,
      color: AppColors.card,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          name,
          const Spacer(),
          ...tiles,
          const SizedBox(width: 8),
          toggle,
        ],
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  final NavItem item;
  final bool selected;
  final VoidCallback onTap;

  const _NavTile({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.accent : AppColors.textMuted;

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Material(
        color: selected ? AppColors.selected : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(item.icon, size: 20, color: color),
                const SizedBox(width: 12),
                Text(item.label, style: TextStyle(color: color)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}