import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'js_logo.dart';

// Terminal Neofetch Personalizado
// Desenvolvido para exibir minhas informações acadêmicas e técnicas
// simulando a saída clássica do comando Neofetch no terminal zsh/Linux.

class NeofetchTerminal extends StatelessWidget {
  const NeofetchTerminal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 620),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(2), // Bordas retas e geométricas para estética profissional
        border: Border.all(color: AppColors.border, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Barra superior da janela com os botões de controle
          Container(
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppColors.cardSecondary,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
              border: Border(
                bottom: BorderSide(color: AppColors.border.withValues(alpha: 0.6)),
              ),
            ),
            child: Row(
              children: [
                _windowDot(const Color(0xFFEF4444)), // Vermelho fechar
                const SizedBox(width: 7),
                _windowDot(const Color(0xFFF59E0B)), // Amarelo minimizar
                const SizedBox(width: 7),
                _windowDot(const Color(0xFF10B981)), // Verde expandir
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'jefferson@sued: ~ (zsh)',
                    style: GoogleFonts.firaCode(
                      fontSize: 11.5,
                      color: AppColors.textSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  'UTF-8',
                  style: GoogleFonts.firaCode(
                    fontSize: 10,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),

          // Corpo do Terminal com a execução do comando profile --info
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Linha de Comando Executada
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.firaCode(fontSize: 13, height: 1.4),
                    children: const [
                      TextSpan(
                        text: 'jefferson@sued',
                        style: TextStyle(
                          color: AppColors.cyan,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: ':~\$ ',
                        style: TextStyle(color: Colors.white70),
                      ),
                      TextSpan(
                        text: 'profile --info',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Grid do Neofetch: Arte ASCII à esquerda e ficha técnica à direita
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isCompact = constraints.maxWidth < 480;

                    // Coluna com a arte ASCII do monograma JS e a paleta de cores
                    final logoSection = Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const JsAsciiLogo(fontSize: 10),
                        const SizedBox(height: 8),
                        // Paleta clássica de cores do Neofetch no tema midnight & esmeralda
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _colorSwatch(const Color(0xFF070B0E)),
                            _colorSwatch(const Color(0xFF14202B)),
                            _colorSwatch(const Color(0xFF1C362F)),
                            _colorSwatch(AppColors.primary),
                            _colorSwatch(AppColors.cyan),
                            _colorSwatch(const Color(0xFF6EE7B7)),
                            _colorSwatch(const Color(0xFFF1F5F9)),
                          ],
                        ),
                      ],
                    );

                    // Minhas informações acadêmicas e foco de estudo (sem menção a períodos ou anos)
                    final infoSection = Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'jefferson@sued',
                          style: GoogleFonts.firaCode(
                            color: AppColors.cyan,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          height: 1,
                          color: AppColors.border,
                        ),

                        _infoLine('NAME:', 'Jefferson Sued'),
                        _infoLine('ROLE:', 'Computer Science Student'),
                        _infoLine('UNIVERSITY:', 'UFCG'),
                        const SizedBox(height: 8),

                        _sectionTitle('OBJECTIVE:'),
                        _bulletLine('Software Development Internship'),
                        const SizedBox(height: 8),

                        _sectionTitle('MAIN FOCUS:'),
                        _bulletLine('Java'),
                        _bulletLine('Object-Oriented Programming'),
                        _bulletLine('Flutter / Dart'),
                        const SizedBox(height: 8),

                        _sectionTitle('PROGRAMMING:'),
                        _bulletLine('Java • Dart • Python'),
                        const SizedBox(height: 8),

                        _sectionTitle('TOOLS:'),
                        _bulletLine('Git • GitHub • VS Code'),
                      ],
                    );

                    if (isCompact) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: logoSection),
                          const SizedBox(height: 20),
                          infoSection,
                        ],
                      );
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: logoSection,
                        ),
                        Container(
                          width: 1,
                          height: 260,
                          color: AppColors.border.withValues(alpha: 0.5),
                          margin: const EdgeInsets.only(right: 18),
                        ),
                        Expanded(child: infoSection),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 16),
                // Linha de prompt ativa com cursor piscante
                Row(
                  children: [
                    Text(
                      'jefferson@sued:~\$ ',
                      style: GoogleFonts.firaCode(
                        fontSize: 12.5,
                        color: AppColors.cyan,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const _BlinkingCursor(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Círculos de controle estilo macOS/Linux
  Widget _windowDot(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  // Quadrados de amostra de cor (estilo Neofetch terminal)
  Widget _colorSwatch(Color color) {
    return Container(
      width: 11,
      height: 10,
      margin: const EdgeInsets.symmetric(horizontal: 1.5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }

  // Linha formatada com chave em ciano/esmeralda e valor em branco
  Widget _infoLine(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.firaCode(fontSize: 12, height: 1.35),
          children: [
            TextSpan(
              text: key.padRight(12),
              style: const TextStyle(
                color: AppColors.cyan,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.firaCode(
        fontSize: 11,
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _bulletLine(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, top: 1),
      child: Text(
        '  $text',
        style: GoogleFonts.firaCode(
          fontSize: 11.5,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

// Cursor piscante com AnimationController
class _BlinkingCursor extends StatefulWidget {
  const _BlinkingCursor();

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _ctrl,
      child: Container(
        width: 8,
        height: 14,
        color: AppColors.cyan,
      ),
    );
  }
}
