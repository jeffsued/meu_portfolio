import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app_colors.dart';
import 'shared_widgets.dart';

// Seção de Projetos Selecionados
// Exibe meus projetos reais (portfólio, RecruitMe, AturaCursos, etc.)
// Organizados em destaque editorial principal e grade em 2 colunas com filtros horizontais.

enum ProjectCategory { web, mobile, backend, outros }

// Modelo para estruturar as informações de cada projeto
class ProjectData {
  final String id;
  final String tagNumber;
  final String title;
  final String categoryName;
  final ProjectCategory category;
  final String description;
  final List<String> technologies;
  final String repoUrl;
  final String? liveUrl;
  final IconData visualIcon;
  final String mockupSnippet;

  const ProjectData({
    required this.id,
    required this.tagNumber,
    required this.title,
    required this.categoryName,
    required this.category,
    required this.description,
    required this.technologies,
    required this.repoUrl,
    this.liveUrl,
    required this.visualIcon,
    required this.mockupSnippet,
  });
}

// Lista dos meus projetos reais e verificáveis hospedados no meu GitHub
final List<ProjectData> realProjectsList = [
  const ProjectData(
    id: 'portfolio',
    tagNumber: '01 // WEB & MULTIPLATAFORMA',
    title: 'Portfólio Pessoal em Flutter Web',
    categoryName: 'Web & Mobile',
    category: ProjectCategory.web,
    description:
        'Aplicação web desenvolvida com Flutter e Dart, estruturada com navegação modular, tipografia técnica, terminal personalizado Neofetch e design system no tom azul escuro.',
    technologies: ['Flutter Web', 'Dart', 'Google Fonts', 'Font Awesome'],
    repoUrl: 'https://github.com/jeffsued/meu_portfolio',
    liveUrl: 'https://github.com/jeffsued/meu_portfolio',
    visualIcon: Icons.web_rounded,
    mockupSnippet: 'class PortfolioWeb extends StatelessWidget {\n  // UI/UX & Responsive Web\n}',
  ),
  const ProjectData(
    id: 'recruitme',
    tagNumber: '02 // GESTÃO & BACKEND',
    title: 'RecruitMe',
    categoryName: 'Web & Backend',
    category: ProjectCategory.web,
    description:
        'Aplicação voltada para o gerenciamento e triagem de candidatos em processos de seleção, aplicando persistência de dados, modularização e regras de negócio estruturadas.',
    technologies: ['Java', 'REST API', 'POO', 'CRUD'],
    repoUrl: 'https://github.com/jeffsued/RecruitMe',
    visualIcon: Icons.groups_outlined,
    mockupSnippet: 'public class CandidateService {\n  public void evaluateCandidate() {}\n}',
  ),
  const ProjectData(
    id: 'aturacursos',
    tagNumber: '03 // ARQUITETURA DE SOFTWARE',
    title: 'AturaCursos',
    categoryName: 'Backend & Acadêmico',
    category: ProjectCategory.backend,
    description:
        'Sistema acadêmico para gerenciamento de cursos, matrículas e catálogo de alunos, fundamentado nos princípios de Programação Orientada a Objetos e organização modular.',
    technologies: ['Java', 'POO', 'Arquitetura Modular', 'Estrutura de Dados'],
    repoUrl: 'https://github.com/jeffsued/AturaCursos',
    visualIcon: Icons.menu_book_rounded,
    mockupSnippet: 'public class Curso {\n  private List<Aluno> inscritos;\n}',
  ),
  const ProjectData(
    id: 'estacionamento',
    tagNumber: '04 // CONTROLE & PERSISTÊNCIA',
    title: 'Sistema de Estacionamento',
    categoryName: 'Backend & Desktop',
    category: ProjectCategory.backend,
    description:
        'Software para controle operacional de pátio de veículos, registrando fluxo de entrada e saída, tarifação dinâmica por tempo e persistência de registros.',
    technologies: ['C#', '.NET', 'POO'],
    repoUrl: 'https://github.com/jeffsued/SistemaDeEstacionamento',
    visualIcon: Icons.directions_car_outlined,
    mockupSnippet: 'public class Estacionamento {\n  public decimal CalcularTarifa() {}\n}',
  ),
  const ProjectData(
    id: 'pizzaria',
    tagNumber: '05 // FLUXO OPERACIONAL',
    title: 'Sistema de Pizzaria',
    categoryName: 'Backend & Gestão',
    category: ProjectCategory.backend,
    description:
        'Plataforma para gestão de pedidos, manutenção de cardápio e controle básico de estoque para estabelecimentos de alimentação.',
    technologies: ['Java', 'Lógica de Negócio', 'POO'],
    repoUrl: 'https://github.com/jeffsued/SistemaPizzaria',
    visualIcon: Icons.local_pizza_outlined,
    mockupSnippet: 'public class Pedido {\n  private StatusPedido status;\n}',
  ),
  const ProjectData(
    id: 'snake',
    tagNumber: '06 // ALGORITMOS & MATRIZES',
    title: 'Snake Game em Python',
    categoryName: 'Outros & Lógica',
    category: ProjectCategory.outros,
    description:
        'Implementação clássica do jogo da cobrinha construída em Python, explorando loop de jogo, detecção de colisão matricial e manipulação de eventos.',
    technologies: ['Python', 'Matrizes', 'Lógica de Jogos'],
    repoUrl: 'https://github.com/jeffsued/snake_game_python',
    visualIcon: Icons.sports_esports_outlined,
    mockupSnippet: 'def update_snake_position(grid, direction):\n  # Matrix collision detection',
  ),
];

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  // Categoria de filtro ativa
  String _selectedTab = 'todos';

  final List<Map<String, String>> _tabs = [
    {'id': 'todos', 'label': 'Todos'},
    {'id': 'web', 'label': 'Web'},
    {'id': 'mobile', 'label': 'Mobile'},
    {'id': 'backend', 'label': 'Backend'},
    {'id': 'outros', 'label': 'Outros'},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 960;

    // Filtra os projetos dinamicamente conforme a categoria selecionada
    final filtered = realProjectsList.where((p) {
      if (_selectedTab == 'todos') return true;
      if (_selectedTab == 'web') return p.category == ProjectCategory.web;
      if (_selectedTab == 'mobile') return p.category == ProjectCategory.mobile;
      if (_selectedTab == 'backend') return p.category == ProjectCategory.backend;
      if (_selectedTab == 'outros') return p.category == ProjectCategory.outros;
      return true;
    }).toList();

    // Composição Editorial: O primeiro projeto ganha card expandido e os demais ficam em grade
    final ProjectData? featured = filtered.isNotEmpty ? filtered.first : null;
    final List<ProjectData> secondary = filtered.length > 1
        ? filtered.sublist(1)
        : <ProjectData>[];

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
            // Cabeçalho da seção de projetos
            const SectionHeaderBlock(
              tag: '02 // ARQUIVO DE PROJETOS',
              title: 'Projetos Selecionados',
              description:
                  'Projetos acadêmicos e pessoais desenvolvidos durante minha trajetória em Ciência da Computação.',
              statusText: 'STATUS: ATIVO • REPOSITÓRIOS GITHUB',
            ),
            const SizedBox(height: 30),

            // Barra de filtros horizontais por categoria
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final tab in _tabs)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _FilterPill(
                        label: tab['label']!,
                        isSelected: _selectedTab == tab['id'],
                        onTap: () => setState(() => _selectedTab = tab['id']!),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 36),

            // Exibição vazia caso nenhum projeto case com o filtro
            if (filtered.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: AppColors.border),
                ),
                child: Center(
                  child: Text(
                    'Nenhum projeto encontrado nesta categoria.',
                    style: GoogleFonts.inter(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            else ...[
              // Projeto principal em destaque widescreen
              if (featured != null)
                _FeaturedProjectCard(
                  project: featured,
                  isDesktop: isDesktop,
                ),

              if (secondary.isNotEmpty) ...[
                const SizedBox(height: 28),
                // Projetos secundários distribuídos em 2 colunas responsivas
                LayoutBuilder(
                  builder: (context, constraints) {
                    final cardWidth = isDesktop
                        ? (constraints.maxWidth - 20) / 2
                        : constraints.maxWidth;

                    return Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: [
                        for (final item in secondary)
                          SizedBox(
                            width: cardWidth,
                            child: _SecondaryProjectCard(project: item),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

// Botão de filtro em formato de pill
class _FilterPill extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterPill({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_FilterPill> createState() => _FilterPillState();
}

class _FilterPillState extends State<_FilterPill> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.isSelected;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: active
                ? const Color(0xFF142B24)
                : (_isHovered ? AppColors.cardHover : AppColors.surface),
            borderRadius: BorderRadius.circular(2),
            border: Border.all(
              color: active
                  ? AppColors.cyan
                  : (_isHovered ? AppColors.borderLight : AppColors.border),
              width: active ? 1.5 : 1.0,
            ),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: AppColors.cyan.withValues(alpha: 0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              color: active
                  ? Colors.white
                  : (_isHovered ? AppColors.textPrimary : AppColors.textSecondary),
            ),
          ),
        ),
      ),
    );
  }
}

// Card do projeto principal com área ampliada de código e preview
class _FeaturedProjectCard extends StatefulWidget {
  final ProjectData project;
  final bool isDesktop;

  const _FeaturedProjectCard({
    required this.project,
    required this.isDesktop,
  });

  @override
  State<_FeaturedProjectCard> createState() => _FeaturedProjectCardState();
}

class _FeaturedProjectCardState extends State<_FeaturedProjectCard> {
  bool _isHovered = false;

  Future<void> _open(String url) async {
    await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.project;

    // Área visual simulando uma janela de código do projeto
    final visualPreview = Container(
      height: widget.isDesktop ? 280 : 210,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Barra superior da janela de código com botões macOS
          Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.cardSecondary,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
              border: Border(
                bottom: BorderSide(color: AppColors.border.withValues(alpha: 0.7)),
              ),
            ),
            child: Row(
              children: [
                _dot(const Color(0xFFEF4444)),
                const SizedBox(width: 6),
                _dot(const Color(0xFFF59E0B)),
                const SizedBox(width: 6),
                _dot(const Color(0xFF10B981)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'SRC // ${p.id}.dart',
                    style: GoogleFonts.firaCode(
                      fontSize: 10.5,
                      color: AppColors.textMuted,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  'FEATURED',
                  style: GoogleFonts.firaCode(
                    fontSize: 9.5,
                    color: AppColors.cyan,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          // Trecho de código e ícone da tecnologia
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(p.visualIcon, color: AppColors.cyan, size: 22),
                      const SizedBox(width: 10),
                      Text(
                        p.categoryName,
                        style: GoogleFonts.firaCode(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
                    ),
                    child: Text(
                      p.mockupSnippet,
                      style: GoogleFonts.firaCode(
                        fontSize: 11.5,
                        color: AppColors.cyan,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    // Conteúdo textual com título, descrição e tags
    final textContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tag técnica com número de referência
        Text(
          p.tagNumber,
          style: GoogleFonts.firaCode(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: AppColors.cyan,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),

        // Título do projeto
        Text(
          p.title,
          style: GoogleFonts.outfit(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),

        // Descrição da arquitetura e propósito
        Text(
          p.description,
          style: GoogleFonts.inter(
            fontSize: 14.5,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 20),

        // Lista de tags de tecnologias
        Wrap(
          spacing: 7,
          runSpacing: 7,
          children: [
            for (final tech in p.technologies) TechTag(label: tech),
          ],
        ),
        const SizedBox(height: 24),

        // Botões de ação (Demo ao vivo e repositório)
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            if (p.liveUrl != null)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                onPressed: () => _open(p.liveUrl!),
                icon: const Icon(Icons.open_in_new_rounded, size: 15),
                label: Text(
                  'Ver Demonstração',
                  style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700),
                ),
              ),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.cardSecondary,
                foregroundColor: AppColors.textPrimary,
                side: const BorderSide(color: AppColors.border),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              onPressed: () => _open(p.repoUrl),
              icon: const FaIcon(FontAwesomeIcons.github, size: 15),
              label: Text(
                'Código-fonte',
                style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(widget.isDesktop ? 28 : 20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(
            color: _isHovered ? AppColors.borderGlow : AppColors.border,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: widget.isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 6, child: textContent),
                  const SizedBox(width: 32),
                  Expanded(flex: 5, child: visualPreview),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textContent,
                  const SizedBox(height: 22),
                  visualPreview,
                ],
              ),
      ),
    );
  }

  Widget _dot(Color c) => Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: c, shape: BoxShape.circle),
      );
}

// Card para projetos secundários distribuídos na grade
class _SecondaryProjectCard extends StatefulWidget {
  final ProjectData project;

  const _SecondaryProjectCard({required this.project});

  @override
  State<_SecondaryProjectCard> createState() => _SecondaryProjectCardState();
}

class _SecondaryProjectCardState extends State<_SecondaryProjectCard> {
  bool _isHovered = false;

  Future<void> _open(String url) async {
    await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.cardHover : AppColors.surface,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(
            color: _isHovered ? AppColors.borderGlow : AppColors.border,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho do Card: Tag + Ícone direto do GitHub
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  p.tagNumber,
                  style: GoogleFonts.firaCode(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.cyan,
                    letterSpacing: 1.1,
                  ),
                ),
                InkWell(
                  onTap: () => _open(p.repoUrl),
                  borderRadius: BorderRadius.circular(2),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: FaIcon(
                      FontAwesomeIcons.github,
                      size: 16,
                      color: _isHovered ? AppColors.cyan : AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Título do Projeto
            Text(
              p.title,
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),

            // Descrição curta
            Text(
              p.description,
              style: GoogleFonts.inter(
                fontSize: 13.5,
                color: AppColors.textSecondary,
                height: 1.55,
              ),
            ),
            const SizedBox(height: 18),

            // Snippet de código ilustrativo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: AppColors.border.withValues(alpha: 0.6)),
              ),
              child: Text(
                p.mockupSnippet,
                style: GoogleFonts.firaCode(
                  fontSize: 11,
                  color: AppColors.cyan,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Badges das tecnologias utilizadas no projeto
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final tech in p.technologies) TechTag(label: tech),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
