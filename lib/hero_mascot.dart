import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'app_colors.dart';

class HeroMascot extends StatefulWidget {
  const HeroMascot({super.key});

  @override
  State<HeroMascot> createState() => _HeroMascotState();
}

class _HeroMascotState extends State<HeroMascot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final floatOffset = math.sin(_controller.value * 2 * math.pi) * 8;
        return Transform.translate(
          offset: Offset(0, floatOffset),
          child: child,
        );
      },
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Brilho Neon Radial de Fundo (Aura Azul Escuro / Ciano)
            Container(
              width: 360,
              height: 360,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.35),
                    AppColors.cyan.withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),

            // Mascote Pixel Art Desenhado em Canvas
            CustomPaint(
              size: const Size(340, 320),
              painter: _PixelCatPainter(),
            ),
          ],
        ),
      ),
    );
  }
}

class _PixelCatPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 44;
    final p = Paint()..isAntiAlias = false;

    // Cores no tom azul escuro / ciano / lavanda do tema
    final darkOutline = const Color(0xFF060914);
    final furDark = const Color(0xFF2563EB); // Royal Blue
    final furMid = const Color(0xFF3B82F6);  // Electric Blue
    final furLight = const Color(0xFF60A5FA); // Light Blue
    final whiteFur = const Color(0xFFF8FAFC); // White fur
    final eyeBlack = const Color(0xFF0F172A);
    final eyeCyan = const Color(0xFF38BDF8);  // Cyan highlights
    final laptopBase = const Color(0xFF1E293B);
    final laptopScreen = const Color(0xFF0F172A);
    final laptopBorder = const Color(0xFF38BDF8);
    final heartGlow = const Color(0xFF60A5FA);

    void drawPx(int x, int y, Color color) {
      p.color = color;
      canvas.drawRect(
        Rect.fromLTWH(x * scale, y * scale, scale, scale),
        p,
      );
    }

    void drawRectPx(int x, int y, int w, int h, Color color) {
      p.color = color;
      canvas.drawRect(
        Rect.fromLTWH(x * scale, y * scale, w * scale, h * scale),
        p,
      );
    }

    // --- 1. ORELHAS ---
    // Orelha Esquerda
    drawRectPx(10, 3, 2, 6, darkOutline);
    drawRectPx(12, 1, 3, 3, darkOutline);
    drawRectPx(12, 4, 3, 5, furDark);
    drawRectPx(14, 5, 2, 4, furMid);

    // Orelha Direita
    drawRectPx(29, 3, 2, 6, darkOutline);
    drawRectPx(26, 1, 3, 3, darkOutline);
    drawRectPx(26, 4, 3, 5, furDark);
    drawRectPx(25, 5, 2, 4, furMid);

    // --- 2. CABEÇA / ROSTO ---
    // Contorno da cabeça
    drawRectPx(15, 3, 11, 2, darkOutline);
    drawRectPx(9, 8, 2, 8, darkOutline);
    drawRectPx(30, 8, 2, 8, darkOutline);
    drawRectPx(11, 16, 19, 2, darkOutline);

    // Pelagem base azul da cabeça
    drawRectPx(12, 5, 17, 7, furMid);
    drawRectPx(10, 7, 3, 7, furDark);
    drawRectPx(28, 7, 3, 7, furDark);

    // Pelagem branca do rosto / bochechas
    drawRectPx(14, 11, 13, 5, whiteFur);
    drawRectPx(12, 12, 3, 4, whiteFur);
    drawRectPx(26, 12, 3, 4, whiteFur);

    // Olhos Pixelados Estilo Anime
    // Olho Esquerdo
    drawRectPx(15, 9, 3, 4, eyeBlack);
    drawPx(15, 9, eyeCyan);
    drawPx(16, 9, whiteFur);
    drawPx(17, 11, eyeCyan);

    // Olho Direito
    drawRectPx(23, 9, 3, 4, eyeBlack);
    drawPx(23, 9, eyeCyan);
    drawPx(24, 9, whiteFur);
    drawPx(25, 11, eyeCyan);

    // Focinho e Boquinha fofa :3
    drawPx(20, 12, darkOutline);
    drawPx(19, 13, darkOutline);
    drawPx(21, 13, darkOutline);

    // --- 3. CORPO E PATINHAS ---
    drawRectPx(14, 17, 13, 8, furDark);
    drawRectPx(16, 17, 9, 7, whiteFur); // Peito branco
    drawRectPx(12, 19, 3, 6, furMid);  // Braço esquerdo
    drawRectPx(26, 19, 3, 6, furMid);  // Braço direito

    // Patinhas brancas apoiadas
    drawRectPx(13, 24, 3, 2, whiteFur);
    drawRectPx(25, 24, 3, 2, whiteFur);

    // Rabinho para a direita
    drawRectPx(29, 20, 3, 6, furMid);
    drawRectPx(32, 17, 3, 5, furLight);
    drawRectPx(33, 15, 3, 4, whiteFur);

    // --- 4. LAPTOP MODERNO ---
    // Tampa do Laptop
    drawRectPx(8, 16, 15, 11, laptopScreen);
    drawRectPx(7, 15, 17, 1, laptopBorder);
    drawRectPx(7, 16, 1, 11, laptopBorder);
    drawRectPx(23, 16, 1, 11, laptopBorder);

    // Logo no laptop (Coraçãozinho estilizado / tag)
    drawRectPx(14, 19, 4, 1, heartGlow);
drawPx(13, 20, heartGlow);
drawRectPx(14, 21, 3, 1, heartGlow);
drawPx(17, 22, heartGlow);
drawRectPx(13, 23, 4, 1, heartGlow);

    // Base do Laptop / Teclado
    drawRectPx(6, 27, 20, 2, laptopBase);
    drawRectPx(5, 29, 22, 1, laptopBorder);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
