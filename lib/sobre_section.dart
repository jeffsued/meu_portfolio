import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'shared_widgets.dart';

// Seção Sobre Mim
// Apresenta meu perfil acadêmico em Ciência da Computação na UFCG,
// meus interesses em POO, Java, Flutter e engenharia de software.

class SobreSection extends StatelessWidget {
  const SobreSection({super.key});

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
            // Cabeçalho da seção com marcador numérico editorial
            const SectionHeaderBlock(
              tag: '01 // APRESENTAÇÃO',
              title: 'Construindo soluções através da programação.',
              description:
                  'Estudante de Ciência da Computação na UFCG com foco em engenharia de software, código modular e soluções práticas.',
              statusText: 'PERFIL // ATIVO',
            ),
            const SizedBox(height: 36),

            // Card principal com minha trajetória acadêmica e interesses
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isDesktop ? 36 : 24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: AppColors.border, width: 1.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cardSecondary,
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Text(
                          'ENGENHARIA DE SOFTWARE & DESENVOLVIMENTO',
                          style: GoogleFonts.firaCode(
                            color: AppColors.cyan,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Descrição objetiva da minha formação e objetivos
                  Text(
                    'Sou estudante de Ciência da Computação na UFCG, com interesse em desenvolvimento de software e programação orientada a objetos.',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: AppColors.textPrimary,
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Atualmente, concentro meus estudos em Java e Flutter, desenvolvendo projetos acadêmicos e pessoais para aprimorar minhas habilidades de programação e engenharia de software.',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Divisor entre o texto e as badges
                  Container(height: 1, color: AppColors.border.withValues(alpha: 0.6)),
                  const SizedBox(height: 24),

                  //Estudos e interesses acadêmicos destacados
                  Wrap(
                    spacing: 20,
                    runSpacing: 14,
                    children: const [
                      _IndicatorBadge(
                        icon: Icons.school_outlined,
                        label: 'Ciência da Computação — UFCG',
                      ),
                      _IndicatorBadge(
                        icon: Icons.devices_rounded,
                        label: 'Desenvolvimento Multiplataforma — Flutter e Dart',
                      ),
                      _IndicatorBadge(
                        icon: Icons.code_rounded,
                        label: 'Programação Orientada a Objetos — Java',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Destaque para as competências acadêmicas
class _IndicatorBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IndicatorBadge({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.cardSecondary,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.cyan),
          const SizedBox(width: 9),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
