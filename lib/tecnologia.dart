import 'package:flutter/material.dart';
import 'app_colors.dart';

class TechCategory {
  final String titulo;
  final String descricao;
  final IconData icon;
  final List<String> itens;

  const TechCategory({
    required this.titulo,
    required this.descricao,
    required this.icon,
    required this.itens,
  });
}

const techCategories = [
  TechCategory(
    titulo: 'Linguagens',
    descricao: 'Linguagens que uso nos meus projetos e estudos.',
    icon: Icons.terminal,
    itens: ['Java', 'Python', 'Dart', 'C#'],
  ),
  TechCategory(
    titulo: 'Front-end e Mobile',
    descricao: 'Interfaces para web e aplicativos.',
    icon: Icons.devices,
    itens: ['Flutter', 'HTML', 'CSS'],
  ),
  TechCategory(
    titulo: 'Ferramentas',
    descricao: 'Versionamento e ambiente de desenvolvimento.',
    icon: Icons.build_outlined,
    itens: ['Git', 'GitHub', 'GitHub Codespaces', 'VS Code'],
  ),
];

class TechSection extends StatelessWidget {
  const TechSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 900),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'TECNOLOGIAS',
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 12,
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Tecnologias dos meus projetos',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              for (final c in techCategories) _TechCard(category: c),
            ],
          ),
        ],
      ),
    );
  }
}

class _TechCard extends StatelessWidget {
  final TechCategory category;

  const _TechCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(category.icon, color: AppColors.accent),
              const SizedBox(width: 12),
              Text(
                category.titulo,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            category.descricao,
            style: const TextStyle(color: AppColors.textMuted, height: 1.5),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final item in category.itens) _TechChip(label: item),
            ],
          ),
        ],
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  final String label;

  const _TechChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.selected,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label, style: const TextStyle(fontSize: 13)),
    );
  }
}