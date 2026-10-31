import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'contact_section.dart';
import 'footer.dart';
import 'hero_section.dart';
import 'nav_bar.dart';
import 'projects_section.dart';
import 'sobre_section.dart';
import 'tech_section.dart';

// Portfólio Pessoal - Jefferson Sued
// Desenvolvido em Flutter Web com foco em UI/UX moderna, arquitetura limpa e performance.

void main() {
  runApp(const MeuPortfolio());
}

class MeuPortfolio extends StatelessWidget {
  const MeuPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jefferson Sued | Engenharia de Software',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          surface: AppColors.surface,
        ),
        // Configuração de alto contraste para seleção de texto (evita conflito com o fundo escuro)
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Color(0x6610B981), // Esmeralda translúcido
          selectionHandleColor: AppColors.cyan,
          cursorColor: AppColors.cyan,
        ),
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
  // Índice da seção ativa: 0: Início, 1: Sobre, 2: Projetos, 3: Stack, 4: Contato
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Chaves globais para medir a posição de cada seção na tela
  final List<GlobalKey> _sectionKeys = List.generate(5, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    // Ouvinte para atualizar o menu superior conforme o usuário navega
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // Detecta qual seção está visível na tela e atualiza o estado da navbar
  void _onScroll() {
    for (int i = _sectionKeys.length - 1; i >= 0; i--) {
      final context = _sectionKeys[i].currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero);
          // Offset de 180px para compensar a navbar fixa no topo
          if (position.dy <= 180) {
            if (_selectedIndex != i) {
              setState(() => _selectedIndex = i);
            }
            break;
          }
        }
      }
    }
  }

  // Animação de scroll suave até a seção escolhida
  void _scrollToSection(int index) {
    setState(() => _selectedIndex = index);

    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      // Menu lateral gaveta para dispositivos móveis
      endDrawer: Drawer(
        backgroundColor: AppColors.surface,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'NAVEGAÇÃO // MENU',
                      style: GoogleFonts.firaCode(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.cyan,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: Colors.white, size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              const Divider(color: AppColors.border, height: 1),
              // Itens de navegação no drawer móvel
              for (int i = 0; i < navItemsList.length; i++)
                ListTile(
                  leading: Icon(
                    navItemsList[i].icon,
                    size: 18,
                    color: _selectedIndex == i ? AppColors.cyan : AppColors.textSecondary,
                  ),
                  title: Text(
                    navItemsList[i].label,
                    style: GoogleFonts.inter(
                      fontSize: 13.5,
                      fontWeight:
                          _selectedIndex == i ? FontWeight.bold : FontWeight.w500,
                      color: _selectedIndex == i ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
                  selected: _selectedIndex == i,
                  selectedTileColor: AppColors.cardSecondary,
                  onTap: () {
                    Navigator.of(context).pop();
                    _scrollToSection(i);
                  },
                ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          // Conteúdo principal rolável (com as seções estruturadas verticalmente)
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  const SizedBox(height: 64), // Compensação de espaçamento para a navbar fixa

                  // 0. Hero Section com terminal interativo Neofetch
                  Container(
                    key: _sectionKeys[0],
                    child: HeroSection(
                      onProjectsTap: () => _scrollToSection(2),
                      onContactTap: () => _scrollToSection(4),
                    ),
                  ),

                  // 1. Seção Sobre Mim (perfil acadêmico na UFCG)
                  Container(
                    key: _sectionKeys[1],
                    child: const SobreSection(),
                  ),

                  // 2. Galeria de Projetos Selecionados com filtros
                  Container(
                    key: _sectionKeys[2],
                    child: const ProjectsSection(),
                  ),

                  // 3. Stack Tecnológica & Inventário de Ferramentas
                  Container(
                    key: _sectionKeys[3],
                    child: const TechSection(),
                  ),

                  // 4. Seção de Contato e canais diretos
                  Container(
                    key: _sectionKeys[4],
                    child: const ContactSection(),
                  ),

                  // Rodapé com links e créditos autorais
                  PortfolioFooter(
                    onNavigate: _scrollToSection,
                  ),
                ],
              ),
            ),
          ),

          // Navbar fixa no topo com blur e status de disponibilidade
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: MainNavBar(
              selectedIndex: _selectedIndex,
              onSelected: _scrollToSection,
              onOpenDrawer: () => _scaffoldKey.currentState?.openEndDrawer(),
            ),
          ),
        ],
      ),
    );
  }
}
