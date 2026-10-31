import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app_colors.dart';
import 'js_logo.dart';

// Rodapé institucional do portfólio
// Exibe links para redes sociais, direitos autorais e créditos das tecnologias utilizadas.

class PortfolioFooter extends StatelessWidget {
  final ValueChanged<int> onNavigate;

  const PortfolioFooter({
    super.key,
    required this.onNavigate,
  });

  // Abertura de links das minhas redes sociais
  Future<void> _launch(String url) async {
    await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(color: AppColors.border.withValues(alpha: 0.6)),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1140),
          child: Column(
            children: [
              // Linha Superior: Meu monograma JS + Identificação + Links externos
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const JsLogo(size: 24),
                      const SizedBox(width: 10),
                      Text(
                        'Jefferson Sued',
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '// UFCG',
                        style: GoogleFonts.firaCode(
                          fontSize: 11,
                          color: AppColors.cyan,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  // Atalhos rápidos para o meu GitHub e LinkedIn
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _footerSocialLink(
                        iconWidget: const FaIcon(
                          FontAwesomeIcons.github,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        label: 'GitHub',
                        onTap: () => _launch('https://github.com/jeffsued'),
                      ),
                      const SizedBox(width: 16),
                      _footerSocialLink(
                        iconWidget: const FaIcon(
                          FontAwesomeIcons.linkedinIn,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        label: 'LinkedIn',
                        onTap: () => _launch('https://www.linkedin.com/in/jeffsued'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Linha divisória geométrica sutil
              Container(height: 1, color: AppColors.border.withValues(alpha: 0.4)),
              const SizedBox(height: 20),

              // Linha Inferior: Copyright e tecnologias
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '© ${DateTime.now().year} Jefferson Sued. Todos os direitos reservados.',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Engenharia de Software • ',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ),
                      Text(
                        'Flutter Web & Dart',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.cyan,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Link compacto com ícone e label para o rodapé
  Widget _footerSocialLink({
    required Widget iconWidget,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconWidget,
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
