import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'shared_widgets.dart';

// Seção de Tecnologias & Ferramentas
// Organizado com filtros por categoria, busca textual e indicadores de proficiência.

enum TechStatus { aplicado, emDesenvolvimento, estudando, academico }

// Modelo para cada tecnologia do inventário
class TechItemDetail {
  final String name;
  final String description;
  final String categoryId;
  final String categoryName;
  final Widget iconWidget;
  final TechStatus status;

  const TechItemDetail({
    required this.name,
    required this.description,
    required this.categoryId,
    required this.categoryName,
    required this.iconWidget,
    required this.status,
  });

  String get statusLabel {
    switch (status) {
      case TechStatus.aplicado:
        return 'Aplicado';
      case TechStatus.emDesenvolvimento:
        return 'Em Dev';
      case TechStatus.estudando:
        return 'Estudo';
      case TechStatus.academico:
        return 'Acadêmico';
    }
  }
}

// Lista das tecnologias que domino e utilizo
final List<TechItemDetail> allTechItems = [
  // Linguagens
  const TechItemDetail(
    name: 'Java',
    description: 'POO, robustez tipada e regras de negócio estruturadas.',
    categoryId: 'linguagens',
    categoryName: 'Linguagens',
    iconWidget: FaIcon(FontAwesomeIcons.java, size: 16, color: AppColors.cyan),
    status: TechStatus.aplicado,
  ),
  const TechItemDetail(
    name: 'Dart',
    description: 'Linguagem base para construção de apps reativos e multiplataforma.',
    categoryId: 'linguagens',
    categoryName: 'Linguagens',
    iconWidget: Icon(Icons.code_rounded, size: 16, color: AppColors.cyan),
    status: TechStatus.aplicado,
  ),
  const TechItemDetail(
    name: 'Python',
    description: 'Algoritmos, scripts de automação e matrizes de jogos.',
    categoryId: 'linguagens',
    categoryName: 'Linguagens',
    iconWidget: FaIcon(FontAwesomeIcons.python, size: 16, color: AppColors.cyan),
    status: TechStatus.academico,
  ),
  const TechItemDetail(
    name: 'C#',
    description: 'Desenvolvimento voltado a sistemas operacionais',
    categoryId: 'linguagens',
    categoryName: 'Linguagens',
    iconWidget: Icon(Icons.laptop_chromebook_rounded, size: 16, color: AppColors.cyan),
    status: TechStatus.aplicado,
  ),

  // Frontend & Mobile
  const TechItemDetail(
    name: 'Flutter',
    description: 'Framework para interfaces modernas, responsivas e fluidas.',
    categoryId: 'frontend',
    categoryName: 'Frontend & Mobile',
    iconWidget: Icon(Icons.flutter_dash, size: 16, color: AppColors.cyan),
    status: TechStatus.aplicado,
  ),
  const TechItemDetail(
    name: 'HTML5 & CSS3',
    description: 'Semântica web, acessibilidade e estilização moderna.',
    categoryId: 'frontend',
    categoryName: 'Frontend & Mobile',
    iconWidget: FaIcon(FontAwesomeIcons.html5, size: 16, color: AppColors.cyan),
    status: TechStatus.aplicado,
  ),

  // Backend
  const TechItemDetail(
    name: 'POO & SOLID',
    description: 'Arquitetura orientada a objetos, desacoplamento e coesão.',
    categoryId: 'backend',
    categoryName: 'Backend',
    iconWidget: Icon(Icons.layers_rounded, size: 16, color: AppColors.cyan),
    status: TechStatus.aplicado,
  ),

  // Banco de Dados
  const TechItemDetail(
    name: 'SQL',
    description: 'Consultas estruturadas, DDL/DML, relacionamentos e joins.',
    categoryId: 'database',
    categoryName: 'Banco de Dados',
    iconWidget: Icon(Icons.table_chart_outlined, size: 16, color: AppColors.cyan),
    status: TechStatus.aplicado,
  ),

  // Ferramentas
  const TechItemDetail(
    name: 'Git',
    description: 'Controle de versão distribuído, branches e histórico seguro.',
    categoryId: 'tools',
    categoryName: 'Ferramentas',
    iconWidget: FaIcon(FontAwesomeIcons.gitAlt, size: 16, color: AppColors.cyan),
    status: TechStatus.aplicado,
  ),
  const TechItemDetail(
    name: 'GitHub',
    description: 'Hospedagem de código, code review e colaboração técnica.',
    categoryId: 'tools',
    categoryName: 'Ferramentas',
    iconWidget: FaIcon(FontAwesomeIcons.github, size: 16, color: AppColors.cyan),
    status: TechStatus.aplicado,
  ),
  const TechItemDetail(
    name: 'VS Code & IDEs',
    description: 'Ambiente de desenvolvimento integrado, linters e extensões.',
    categoryId: 'tools',
    categoryName: 'Ferramentas',
    iconWidget: Icon(Icons.terminal_rounded, size: 16, color: AppColors.cyan),
    status: TechStatus.aplicado,
  ),
];

class TechSection extends StatefulWidget {
  const TechSection({super.key});

  @override
  State<TechSection> createState() => _TechSectionState();
}

class _TechSectionState extends State<TechSection> {
  String _selectedCategory = 'all';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _categories = [
    {'id': 'all', 'label': 'Todas'},
    {'id': 'linguagens', 'label': 'Linguagens'},
    {'id': 'frontend', 'label': 'Frontend & Mobile'},
    {'id': 'backend', 'label': 'Backend'},
    {'id': 'database', 'label': 'Banco de Dados'},
    {'id': 'tools', 'label': 'Ferramentas'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;
    final isTablet = screenWidth >= 680 && screenWidth < 1024;

    // Filtra tecnologias por categoria e por texto de busca
    final filtered = allTechItems.where((item) {
      final matchesCategory =
          _selectedCategory == 'all' || item.categoryId == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

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
            // Cabeçalho com Painel Lateral de Especialidade / Filosofia
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: const SectionHeaderBlock(
                    tag: 'SYS.CAPABILITIES',
                    title: 'Tecnologia & Ferramentas',
                    description:
                        'Ferramentas, linguagens e tecnologias utilizadas nos meus estudos e projetos de desenvolvimento de software.',
                    statusText: 'TECNOLOGIAS MAPEADAS',
                  ),
                ),
                if (isDesktop) ...[
                  const SizedBox(width: 32),
                  _SidePhilosophyPanel(),
                ],
              ],
            ),
            const SizedBox(height: 32),

            // Barra de Filtros + Campo de Pesquisa em Tempo Real
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: AppColors.border),
              ),
              child: isDesktop
                  ? Row(
                      children: [
                        Expanded(child: _buildFilterTabs()),
                        const SizedBox(width: 16),
                        SizedBox(width: 250, child: _buildSearchField()),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildFilterTabs(),
                        const SizedBox(height: 12),
                        _buildSearchField(),
                      ],
                    ),
            ),
            const SizedBox(height: 32),

            // Grid de Cards Tecnológicos em 4 Colunas (Desktop), 2 (Tablet) ou 1 (Mobile)
            if (filtered.isEmpty)
              Padding(
                padding: const EdgeInsets.all(40),
                child: Center(
                  child: Text(
                    'Nenhuma tecnologia encontrada para a busca informada.',
                    style: GoogleFonts.inter(color: AppColors.textSecondary),
                  ),
                ),
              )
            else
              LayoutBuilder(
                builder: (context, constraints) {
                  int columns = 1;
                  if (isDesktop) {
                    columns = 4;
                  } else if (isTablet) {
                    columns = 2;
                  }

                  final cardWidth =
                      (constraints.maxWidth - ((columns - 1) * 16)) / columns;

                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      for (final tech in filtered)
                        SizedBox(
                          width: cardWidth,
                          child: _TechInventoryCard(item: tech),
                        ),
                    ],
                  );
                },
              ),
            const SizedBox(height: 52),

            // Painel: Distribuição de Conhecimento e Aplicação
            _KnowledgeDistributionPanel(),
            const SizedBox(height: 44),

            // Subseção: Laboratório de Tecnologias em Experimentação
            _ExperimentationLabSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final cat in _categories)
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: InkWell(
                onTap: () => setState(() => _selectedCategory = cat['id']!),
                borderRadius: BorderRadius.circular(2),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: _selectedCategory == cat['id']!
                        ? const Color(0xFF142B24)
                        : AppColors.cardSecondary,
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(
                      color: _selectedCategory == cat['id']!
                          ? AppColors.cyan
                          : AppColors.border,
                      width: _selectedCategory == cat['id']! ? 1.4 : 1.0,
                    ),
                    boxShadow: _selectedCategory == cat['id']!
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
                    cat['label']!,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: _selectedCategory == cat['id']!
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: _selectedCategory == cat['id']!
                          ? Colors.white
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: AppColors.border),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (val) => setState(() => _searchQuery = val),
        style: GoogleFonts.inter(fontSize: 12.5, color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Filtrar por tecnologia...',
          hintStyle: GoogleFonts.inter(fontSize: 12, color: AppColors.textMuted),
          prefixIcon: const Icon(Icons.search_rounded, size: 16, color: AppColors.cyan),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close_rounded, size: 14),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class _SidePhilosophyPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ESPECIALIDADE',
                style: GoogleFonts.firaCode(
                  fontSize: 10,
                  color: AppColors.cyan,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'Engenharia & Código',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'FILOSOFIA',
                style: GoogleFonts.firaCode(
                  fontSize: 10,
                  color: AppColors.cyan,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'Estrutura & POO',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TechInventoryCard extends StatefulWidget {
  final TechItemDetail item;

  const _TechInventoryCard({required this.item});

  @override
  State<_TechInventoryCard> createState() => _TechInventoryCardState();
}

class _TechInventoryCardState extends State<_TechInventoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.cardHover : AppColors.surface,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(
            color: _isHovered ? AppColors.borderGlow : AppColors.border,
            width: 1.1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Topo do Card: Ícone + Nome + Badge Qualitativo
            Row(
              children: [
                item.iconWidget,
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    item.name,
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                  decoration: BoxDecoration(
                    color: AppColors.cardSecondary,
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    item.statusLabel,
                    style: GoogleFonts.firaCode(
                      fontSize: 9.5,
                      color: AppColors.cyan,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Categoria
            Text(
              item.categoryName,
              style: GoogleFonts.firaCode(
                fontSize: 10,
                color: AppColors.textMuted,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 6),

            // Pequena Descrição Objetiva
            Text(
              item.description,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.textSecondary,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Painel: Distribuição de Conhecimento e Aplicação (Sem percentuais falsos, com status qualitativos)
class _KnowledgeDistributionPanel extends StatelessWidget {
  final List<Map<String, String>> _areas = const [
    {
      'title': 'Programação Orientada a Objetos (Java)',
      'status': 'Aplicado em Projetos',
      'level': '0.70',
    },
    {
      'title': 'Desenvolvimento Mobile & Web (Flutter / Dart)',
      'status': 'Aplicado em Projetos',
      'level': '0.50',
    },
    {
      'title': 'Modelagem e Banco de Dados (SQL)',
      'status': 'Em desenvolvimento',
      'level': '0.50',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TELEMETRIA DE DOMÍNIO PRÁTICO',
                    style: GoogleFonts.firaCode(
                      fontSize: 11,
                      color: AppColors.cyan,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Distribuição de Conhecimento e Aplicação',
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _legendDot(AppColors.cyan, 'Aplicação Real'),
                  const SizedBox(width: 14),
                  _legendDot(AppColors.primary, 'Estudo Acadêmico'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 22),

          for (final area in _areas) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        area['title']!,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        area['status']!,
                        style: GoogleFonts.firaCode(
                          fontSize: 11,
                          color: AppColors.cyan,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(1),
                    child: LinearProgressIndicator(
                      value: double.parse(area['level']!),
                      minHeight: 5,
                      backgroundColor: AppColors.cardSecondary,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.cyan),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _legendDot(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.inter(fontSize: 11, color: AppColors.textMuted),
        ),
      ],
    );
  }
}

/// Subseção: Laboratório de Tecnologias em Experimentação
class _ExperimentationLabSection extends StatelessWidget {
  final List<Map<String, String>> _experiments = const [
    {
      'title': 'Arquitetura Limpa em Flutter',
      'status': 'EM APLICAÇÃO',
      'description':
          'Separação rigorosa de camadas em Domain, Data e Presentation com State Management reativo.',
      'tech': 'Dart • Clean Architecture • BLoC/Signals',
    },
    {
      'title': 'Spring Boot',
      'status': 'PESQUISA',
      'description':
          'Estruturação de serviços independentes em Java com comunicação REST e persistência isolada.',
      'tech': 'Java • Spring Boot • Docker',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                color: AppColors.cyan,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'LABORATÓRIO EM ANDAMENTO',
              style: GoogleFonts.firaCode(
                fontSize: 11,
                color: AppColors.cyan,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Radar de Tecnologias em Experimentação',
          style: GoogleFonts.outfit(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 18),

        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 800;
            final itemWidth = isDesktop
                ? (constraints.maxWidth - 32) / 3
                : constraints.maxWidth;

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                for (final exp in _experiments)
                  SizedBox(
                    width: itemWidth,
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                exp['status']!,
                                style: GoogleFonts.firaCode(
                                  fontSize: 10,
                                  color: AppColors.cyan,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Icon(
                                Icons.science_outlined,
                                size: 16,
                                color: AppColors.cyan,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            exp['title']!,
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            exp['description']!,
                            style: GoogleFonts.inter(
                              fontSize: 12.5,
                              color: AppColors.textSecondary,
                              height: 1.45,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            exp['tech']!,
                            style: GoogleFonts.firaCode(
                              fontSize: 10.5,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
