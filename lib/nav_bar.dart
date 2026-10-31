import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app_colors.dart';
import 'js_logo.dart';

// Modelo para os itens da barra de navegação
class NavItemData {
  final String label;
  final IconData icon;

  const NavItemData(this.label, this.icon);
}

// Seções principais do meu site (Início, Sobre, Projetos, Stack e Contato)
const navItemsList = [
  NavItemData('Início', Icons.terminal_rounded),
  NavItemData('Sobre', Icons.person_outline_rounded),
  NavItemData('Projetos', Icons.layers_outlined),
  NavItemData('Stack', Icons.code_rounded),
  NavItemData('Contato', Icons.mail_outline_rounded),
];

class MainNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final VoidCallback? onOpenDrawer;

  const MainNavBar({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
    this.onOpenDrawer,
  });

  // Abertura do link do meu currículo atualizado no Google Drive
  Future<void> _downloadCV() async {
    const url = 'https://drive.google.com/file/d/1c0rps7DFxj89fUHV3mMc6a9mDJr9_ZpE/view?usp=sharing';
    await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 960;

    return ClipRect(
      child: BackdropFilter(
        // Efeito de desfoque de fundo (frosted glass) para dar profundidade
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          height: 64,
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 40 : 18),
          decoration: BoxDecoration(
            color: AppColors.background.withValues(alpha: 0.92),
            border: Border(
              bottom: BorderSide(
                color: AppColors.border.withValues(alpha: 0.7),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              // Logo JS vetorial + Identificação profissional
              InkWell(
                onTap: () => onSelected(0),
                borderRadius: BorderRadius.circular(2),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const JsLogo(size: 26),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Jefferson Sued',
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'SOFTWARE DEVELOPER',
                            style: GoogleFonts.firaCode(
                              fontSize: 9.5,
                              color: AppColors.cyan,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Layout da barra em telas Desktop
              if (isDesktop) ...[
                // Links com efeito de hover e sublinhado animado
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < navItemsList.length; i++)
                      _NavLink(
                        label: navItemsList[i].label,
                        isSelected: selectedIndex == i,
                        onTap: () => onSelected(i),
                      ),
                  ],
                ),
                const SizedBox(width: 18),

                // Pill indicando que estou aberto a estágios e projetos
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.cardSecondary,
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.cyan,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Disponível para oportunidades',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: AppColors.cyan,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),

                // Botão para baixar meu CV em PDF
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: AppColors.textPrimary,
                    side: const BorderSide(color: AppColors.border, width: 1.2),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  onPressed: _downloadCV,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Baixar CV',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(Icons.arrow_downward_rounded, size: 14),
                    ],
                  ),
                ),
              ] else ...[
                // Botão hamburguer para abrir a gaveta no mobile
                IconButton(
                  onPressed: onOpenDrawer,
                  icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 22),
                  tooltip: 'Menu',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Widget auxiliar para cada link da navbar com animação de hover
class _NavLink extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: widget.isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: widget.isSelected
                      ? Colors.white
                      : (_isHovered ? AppColors.cyan : AppColors.textSecondary),
                ),
              ),
              const SizedBox(height: 3),
              // Linha indicadora sutil abaixo do item ativo
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: widget.isSelected ? 18 : (_isHovered ? 10 : 0),
                height: 2,
                decoration: BoxDecoration(
                  color: AppColors.cyan,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
