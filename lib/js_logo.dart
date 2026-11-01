import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Monograma JS e arte do terminal
// Desenvolvido para a identidade visual do meu portfolio pessoal.
// Jefferson Sued - Ciencia da Computacao @ UFCG

/// Representacao ASCII do monograma para o terminal Neofetch
class JsAsciiLogo extends StatelessWidget {
  final double fontSize;

  const JsAsciiLogo({
    super.key,
    this.fontSize = 10.5,
  });

  // Arte ASCII alinhada com as proporcoes do terminal
  static const String asciiArt = '''
       /-----------:\\
      /----------    \\
     /-------/shhOMMo-\\
    /-----/shhM------ M--:
   /-----/shhS---:---M--:
  /------MMMSSS---:---:\\
 |-------MMSSSS----:---:--
 |---------SSSSSS--:---:---
  \\-------/    SSSSM:---:---
   \\-MMMM--:    MMMSSSS-----/
    \\-MMM-----/    MMMSS----
     \\-shMM------/MMMS-----;
      \\:MMMM---/hMMMS-----:
       \\:dNdhhhSSSSSS----;
        \\:sdNMMMMNDs----:
         \\----://:-----::
          \\-----------://
''';

  @override
  Widget build(BuildContext context) {
    // Aplico o gradiente esmeralda luminoso na fonte monoespacada
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          Color(0xFF34D399),
          Color(0xFF059669),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        asciiArt,
        style: GoogleFonts.firaCode(
          fontSize: fontSize,
          height: 1.15,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}

/// Logo vetorial JS para a Navbar e o Rodape
/// Desenhei usando CustomPainter para garantir nitidez perfeita em qualquer resolucao
class JsLogo extends StatelessWidget {
  final double size;

  const JsLogo({
    super.key,
    this.size = 28,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _JsTribalPainter(),
      ),
    );
  }
}

/// Painter vetorial do meu monograma tribal (J e S entrelaçados)
/// Estilo gotico/tribal com pontas agudas e curvas dinamicas
class _JsTribalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // Gradiente esmeralda característico da minha identidade visual
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF34D399), // Verde Esmeralda claro
          Color(0xFF059669), // Verde Esmeralda profundo
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    // -------------------------------------------------------------
    // 1. Letra J: Haste sólida, topo nivelado e gancho tribal inferior
    // -------------------------------------------------------------
    final pathJ = Path();
    // Topo do J nivelado e sem prolongamento superior
    pathJ.moveTo(w * 0.36, h * 0.26); // Canto superior esquerdo
    pathJ.lineTo(w * 0.49, h * 0.25); // Canto superior direito
    pathJ.lineTo(w * 0.49, h * 0.53); // Haste descendo
    // Gancho inferior curvando à esquerda com esporão pontiagudo
    pathJ.cubicTo(w * 0.48, h * 0.65, w * 0.35, h * 0.68, w * 0.26, h * 0.66);
    pathJ.lineTo(w * 0.33, h * 0.52); // Esporão voltado para cima
    pathJ.cubicTo(w * 0.38, h * 0.56, w * 0.41, h * 0.55, w * 0.42, h * 0.50);
    // Haste esquerda subindo de volta
    pathJ.lineTo(w * 0.41, h * 0.33);
    pathJ.close();

    canvas.drawPath(pathJ, paint);

    // -------------------------------------------------------------
    // 2. Letra S: Formato tribal cortando e entrelaçado ao J
    // -------------------------------------------------------------
    final pathS = Path();
    // Asa superior direita do S
    pathS.moveTo(w * 0.60, h * 0.31);
    pathS.lineTo(w * 0.72, h * 0.39); // Ponta direita superior
    pathS.cubicTo(w * 0.64, h * 0.43, w * 0.56, h * 0.46, w * 0.51, h * 0.46);
    // Corte diagonal pelo meio
    pathS.lineTo(w * 0.66, h * 0.54);
    pathS.cubicTo(w * 0.72, h * 0.59, w * 0.70, h * 0.67, w * 0.62, h * 0.72);
    // Cauda inferior longa pontiaguda
    pathS.lineTo(w * 0.47, h * 0.79); // Ponta mais baixa do S
    pathS.lineTo(w * 0.58, h * 0.68);
    // Esporão intermediario
    pathS.lineTo(w * 0.43, h * 0.64);
    pathS.lineTo(w * 0.54, h * 0.61);
    // Retorno pelo centro do S
    pathS.cubicTo(w * 0.58, h * 0.58, w * 0.56, h * 0.54, w * 0.49, h * 0.50);
    pathS.lineTo(w * 0.56, h * 0.39);
    pathS.close();

    canvas.drawPath(pathS, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
