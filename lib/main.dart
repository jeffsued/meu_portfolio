import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'nav_bar.dart';

void main() {
  runApp(const MeuPortfolio());
}

class MeuPortfolio extends StatelessWidget {
  const MeuPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfólio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  NavPosition navPosition = NavPosition.left;

  final keys = List.generate(navItems.length, (_) => GlobalKey());

  void _goTo(int i) {
    setState(() => selectedIndex = i);
    Scrollable.ensureVisible(
      keys[i].currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _togglePosition() {
    setState(() {
      navPosition = navPosition == NavPosition.left
          ? NavPosition.top
          : NavPosition.left;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLeft = navPosition == NavPosition.left;

    return Scaffold(
      body: Flex(
        direction: isLeft ? Axis.horizontal : Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NavBar(
            position: navPosition,
            selectedIndex: selectedIndex,
            onSelected: _goTo,
            onTogglePosition: _togglePosition,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < navItems.length; i++)
                    Section(
                      key: keys[i],
                      title: navItems[i].label,
                      child: i == 1 ? const SobreCard() : null,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final Widget? child;

  const Section({super.key, required this.title, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(32),
      child: child ??
          Text(
            title,
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
    );
  }
}

class SobreCard extends StatelessWidget {
  const SobreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 900,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SOBRE MIM',
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 12,
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Desenvolvimento de software com experiência prática.',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            '''Estudante de Ciência da Computação desde 2024, com foco no desenvolvimento de aplicativos móveis para Android e iOS.
            Aprendendo e praticando com o framework Flutter e a linguagem de programação Dart para criar interfaces modernas e responsivas.
            Buscando desenvolver habilidades técnicas e de trabalho em equipe para contribuir com projetos de software de alta qualidade.''',
            textAlign: TextAlign.center, // Centraliza o parágrafo descritivo
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}