import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'shared_widgets.dart';

class TimelineEntry {
  final String period;
  final String role;
  final String institution;
  final String description;
  final List<String> technologies;

  const TimelineEntry({
    required this.period,
    required this.role,
    required this.institution,
    required this.description,
    required this.technologies,
  });
}

const List<TimelineEntry> trajectoryList = [
  TimelineEntry(
    period: '2024 — PRESENTE',
    role: 'Graduação em Ciência da Computação',
    institution: 'Universidade Federal de Campina Grande (UFCG)',
    description:
        'Formação acadêmica sólida com foco em fundamentos da computação, análise de algoritmos, estruturas de dados avançadas, paradigmas de linguagens de programação e engenharia de software.',
    technologies: ['Algoritmos', 'Estrutura de Dados', 'POO', 'Teoria da Computação'],
  ),
  TimelineEntry(
    period: '2024 — PRESENTE',
    role: 'Desenvolvimento de Software & Projetos Práticos',
    institution: 'Projetos Pessoais e Acadêmicos Autônomos',
    description:
        'Concepção e implementação de sistemas funcionais para consolidar conhecimentos teóricos. Aplicação de arquitetura em camadas, modularização, regras de negócio em Java/C# e interfaces com Flutter.',
    technologies: ['Java', 'Flutter', 'Dart', 'C#', '.NET', 'Git'],
  ),
  TimelineEntry(
    period: '2024 — PRESENTE',
    role: 'Estudos Avançados de Engenharia de Software',
    institution: 'Pesquisa Aplicada & Aperfeiçoamento Técnico',
    description:
        'Aprofundamento em boas práticas de programação, controle de versão colaborativo no GitHub, desenvolvimento de APIs RESTful e persistência com bancos de dados relacionais.',
    technologies: ['SOLID', 'REST API', 'GitHub', 'Clean Code'],
  ),
];

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 880;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40 : 20,
        vertical: 60,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1140),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeaderBlock(
              tag: '03 // TRAJETÓRIA',
              title: 'Experiência & Formação',
              description:
                  'Linha do tempo da minha trajetória acadêmica em Ciência da Computação na UFCG e evolução técnica na prática de desenvolvimento.',
              statusText: 'UFCG // GRADUAÇÃO ATIVA',
            ),
            const SizedBox(height: 38),

            // Linha do Tempo Técnica
            Column(
              children: [
                for (int i = 0; i < trajectoryList.length; i++)
                  _TimelineNodeCard(
                    entry: trajectoryList[i],
                    isLast: i == trajectoryList.length - 1,
                    isDesktop: isDesktop,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineNodeCard extends StatelessWidget {
  final TimelineEntry entry;
  final bool isLast;
  final bool isDesktop;

  const _TimelineNodeCard({
    required this.entry,
    required this.isLast,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Coluna do Marcador / Linha
          Column(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.cyan, width: 2.5),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.5,
                    color: AppColors.border.withValues(alpha: 0.7),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),

          // Conteúdo do Card
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 32),
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border, width: 1.1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),

                    // Título / Papel
                    Text(
                      entry.role,
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Instituição
                    Text(
                      entry.institution,
                      style: GoogleFonts.inter(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Descrição
                    Text(
                      entry.description,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.55,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Tags de Tecnologias
                    Wrap(
                      spacing: 7,
                      runSpacing: 7,
                      children: [
                        for (final tech in entry.technologies) TechTag(label: tech),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
