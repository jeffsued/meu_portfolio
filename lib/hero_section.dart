import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app_colors.dart';
import 'neofetch_terminal.dart';

// Seção Principal (Hero)
// Apresenta meu nome com tipografia marcante, animação de máquina de escrever
// e o terminal interativo Neofetch com minhas informações acadêmicas e técnicas.

class HeroSection extends StatefulWidget {
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  const HeroSection({
    super.key,
    required this.onProjectsTap,
    required this.onContactTap,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  // Lista de cargos e papéis que alternam no efeito de digitação
  final List<String> _titles = [
    'Desenvolvedor de Software',
    'Desenvolvedor Flutter & Mobile',
    'Estudante de Ciência da Computação',
    'Entusiasta de UI/UX e Web',
  ];

  int _titleIndex = 0;
  String _currentText = '';
  int _charIndex = 0;
  bool _isDeleting = false;
  Timer? _typingTimer;
  Timer? _cursorTimer;
  bool _showCursor = true;

  @override
  void initState() {
    super.initState();
    // Inicia a digitação dinâmica e o cursor piscante
    _startTypewriter();
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (mounted) setState(() => _showCursor = !_showCursor);
    });
  }

  // Lógica do efeito máquina de escrever (digita -> pausa -> apaga -> próximo)
  void _startTypewriter() {
    final currentFullText = _titles[_titleIndex];
    final speed = _isDeleting ? 35 : 75; // Apaga mais rápido do que escreve

    _typingTimer = Timer(Duration(milliseconds: speed), () {
      if (!mounted) return;

      setState(() {
        if (!_isDeleting) {
          _currentText = currentFullText.substring(0, _charIndex + 1);
          _charIndex++;
          if (_charIndex == currentFullText.length) {
            _isDeleting = true;
            // Pausa de leitura antes de começar a apagar
            _typingTimer = Timer(const Duration(milliseconds: 1800), _startTypewriter);
            return;
          }
        } else {
          _currentText = currentFullText.substring(0, _charIndex - 1);
          _charIndex--;
          if (_charIndex == 0) {
            _isDeleting = false;
            _titleIndex = (_titleIndex + 1) % _titles.length;
          }
        }
      });

      _startTypewriter();
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _cursorTimer?.cancel();
    super.dispose();
  }

  // Utilitário para abrir links externos em nova aba no Flutter Web
  Future<void> _launch(String url) async {
    await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 960;

    // Coluna esquerda com meu nome, títulos e botões de chamada
    final infoColumn = Column(
      crossAxisAlignment:
          isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Prompt de terminal simulando comando whoami
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
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
              const SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.firaCode(fontSize: 12.5),
                  children: const [
                    TextSpan(
                      text: 'jefferson@sued:~\$ ',
                      style: TextStyle(
                        color: AppColors.cyan,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: 'whoami',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Tipografia com alto contraste: JEFFERSON (Branco) e SUED (Azul)
        RichText(
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'JEFFERSON\n',
                style: GoogleFonts.outfit(
                  fontSize: isDesktop ? 64 : 44,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                  height: 1.05,
                  letterSpacing: -1,
                ),
              ),
              TextSpan(
                text: 'SUED',
                style: GoogleFonts.outfit(
                  fontSize: isDesktop ? 64 : 44,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                  height: 1.05,
                  letterSpacing: -1,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Subtítulo dinâmico com o efeito typewriter
        SizedBox(
          height: 36,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _currentText,
                style: GoogleFonts.inter(
                  fontSize: isDesktop ? 21 : 17,
                  fontWeight: FontWeight.w500,
                  color: AppColors.cyan,
                ),
              ),
              Opacity(
                opacity: _showCursor ? 1.0 : 0.0,
                child: Text(
                  '|',
                  style: GoogleFonts.inter(
                    fontSize: isDesktop ? 21 : 17,
                    fontWeight: FontWeight.w300,
                    color: AppColors.cyan,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),

        // Botões de ação para navegação rápida
        Wrap(
          spacing: 14,
          runSpacing: 12,
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: [
            // Botão principal: Ver Projetos
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 4,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              onPressed: widget.onProjectsTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Ver Projetos',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded, size: 17),
                ],
              ),
            ),

            // Botão secundário: Entrar em Contato
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.cardSecondary,
                foregroundColor: AppColors.textPrimary,
                side: const BorderSide(color: AppColors.border, width: 1.2),
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              onPressed: widget.onContactTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Entrar em Contato',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.mail_outline_rounded, size: 17),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),

        // Atalhos para as minhas redes profissionais
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SocialIconButton(
              iconWidget: const FaIcon(FontAwesomeIcons.github, size: 18),
              tooltip: 'GitHub • @jeffsued',
              onTap: () => _launch('https://github.com/jeffsued'),
            ),
            const SizedBox(width: 12),
            _SocialIconButton(
              iconWidget: const FaIcon(FontAwesomeIcons.linkedinIn, size: 18),
              tooltip: 'LinkedIn • /in/jeffsued',
              onTap: () => _launch('https://www.linkedin.com/in/jeffsued'),
            ),
          ],
        ),
      ],
    );

    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 76,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 50 : 20,
        vertical: 40,
      ),
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 5, child: infoColumn),
                  const SizedBox(width: 44),
                  // Terminal Neofetch com arte ASCII e dados técnicos
                  const Expanded(flex: 6, child: NeofetchTerminal()),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  infoColumn,
                  const SizedBox(height: 40),
                  const NeofetchTerminal(),
                ],
              ),
      ),
    );
  }
}

// Botão com efeito hover para redes sociais
class _SocialIconButton extends StatefulWidget {
  final Widget iconWidget;
  final String tooltip;
  final VoidCallback onTap;

  const _SocialIconButton({
    required this.iconWidget,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _isHovered ? AppColors.primary : AppColors.cardSecondary,
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: _isHovered ? AppColors.cyan : AppColors.border,
                width: 1.2,
              ),
            ),
            child: Center(
              child: IconTheme(
                data: IconThemeData(
                  color: _isHovered ? Colors.white : AppColors.textSecondary,
                ),
                child: widget.iconWidget,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
