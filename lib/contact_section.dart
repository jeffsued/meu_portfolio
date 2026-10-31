import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app_colors.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  // Controladores do formulário de mensagem
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  String _selectedNature = 'Oportunidade de estágio';
  bool _isDispatching = false;

  // Opções de assunto para a mensagem
  final List<String> _natureOptions = [
    'Oportunidade de estágio',
    'Projeto colaborativo',
    'Dúvida técnica',
    'Outros assuntos',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launch(String url) async {
    await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
  }

  void _copyEmail(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: 'dev.jeffersonsued@gmail.com'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: AppColors.cyan, size: 18),
            const SizedBox(width: 8),
            Text(
              'dev.jeffersonsued@gmail.com copiado para a área de transferência.',
              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        backgroundColor: AppColors.cardSecondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isDispatching = true);

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final subject = _subjectController.text.trim();
    final message = _messageController.text.trim();

    final mailtoUri = Uri(
      scheme: 'mailto',
      path: 'dev.jeffersonsued@gmail.com',
      queryParameters: {
        'subject': '[$_selectedNature] $subject',
        'body': 'Nome: $name\nE-mail: $email\nNatureza: $_selectedNature\n\nMensagem:\n$message',
      },
    );

    try {
      await launchUrl(mailtoUri);
    } catch (_) {}

    if (!mounted) return;
    setState(() => _isDispatching = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.send_rounded, color: AppColors.cyan, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Cliente de e-mail acionado com os dados preenchidos para envio direto a dev.jeffersonsued@gmail.com.',
                style: GoogleFonts.inter(fontSize: 13),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.cardSecondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 960;

    // Coluna da Esquerda — Informações & Canais
    final leftColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tag Técnica
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
              'OPORTUNIDADES',
              style: GoogleFonts.firaCode(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: AppColors.cyan,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Título
        
        const SizedBox(height: 14),

        // Descrição
        Text(
          'Estou aberto a oportunidades de estágio em desenvolvimento de software, colaborações técnicas e novos projetos.',
          style: GoogleFonts.inter(
            fontSize: 15,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 28),

        // Card de Disponibilidade
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(2),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: AppColors.cyan,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Disponibilidade Ativa',
                    style: GoogleFonts.inter(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.cardSecondary,
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      'ESTÁGIO // DEV',
                      style: GoogleFonts.firaCode(
                        fontSize: 9.5,
                        color: AppColors.cyan,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Interesse focado em desenvolvimento de software (Java, Flutter, backend e desenvolvimento de sistemas).',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 15, color: AppColors.cyan),
                  const SizedBox(width: 6),
                  Text(
                    'Campina Grande, PB, Brasil',
                    style: GoogleFonts.inter(
                      fontSize: 12.5,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Canais Diretos de Comunicação
        Text(
          'CANAIS DIRETOS DE COMUNICAÇÃO',
          style: GoogleFonts.firaCode(
            fontSize: 10.5,
            color: AppColors.textMuted,
            letterSpacing: 1.1,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),

        // Card de E-mail com botão Copiar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(2),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              const Icon(Icons.mail_outline_rounded, size: 18, color: AppColors.cyan),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'E-MAIL PRINCIPAL',
                      style: GoogleFonts.firaCode(
                        fontSize: 9.5,
                        color: AppColors.textMuted,
                      ),
                    ),
                    Text(
                      'dev.jeffersonsued@gmail.com',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.cardSecondary,
                  foregroundColor: AppColors.cyan,
                  side: const BorderSide(color: AppColors.border),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                onPressed: () => _copyEmail(context),
                child: Text(
                  'COPIAR',
                  style: GoogleFonts.firaCode(fontSize: 11, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Cards de Redes (GitHub & LinkedIn)
        Row(
          children: [
            Expanded(
              child: _ChannelCard(
                iconWidget: const FaIcon(FontAwesomeIcons.github, size: 16),
                title: 'GitHub',
                subtitle: '@jeffsued',
                onTap: () => _launch('https://github.com/jeffsued'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ChannelCard(
                iconWidget: const FaIcon(FontAwesomeIcons.linkedinIn, size: 16),
                title: 'LinkedIn',
                subtitle: '/in/jeffsued',
                onTap: () => _launch('https://www.linkedin.com/in/jeffsued'),
              ),
            ),
          ],
        ),
      ],
    );

    // Coluna da Direita — Protocolo de Contato / Formulário
    final rightColumn = Container(
      padding: EdgeInsets.all(isDesktop ? 30 : 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PROTOCOLO DE CONTATO // 01',
              style: GoogleFonts.firaCode(
                fontSize: 11,
                color: AppColors.cyan,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Especificações da Demanda',
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Preencha os campos abaixo para direcionamento direto e alinhamento de oportunidade.',
              style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),

            // Campos: Identificação / Nome e E-mail
            if (isDesktop)
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _nameController,
                      label: 'IDENTIFICAÇÃO / NOME',
                      hint: 'Seu nome ou organização',
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? 'Informe seu nome' : null,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildTextField(
                      controller: _emailController,
                      label: 'E-MAIL DE CONTATO',
                      hint: 'seu.email@exemplo.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => v == null || !v.contains('@')
                          ? 'E-mail inválido'
                          : null,
                    ),
                  ),
                ],
              )
            else ...[
              _buildTextField(
                controller: _nameController,
                label: 'IDENTIFICAÇÃO / NOME',
                hint: 'Seu nome ou organização',
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Informe seu nome' : null,
              ),
              const SizedBox(height: 14),
              _buildTextField(
                controller: _emailController,
                label: 'E-MAIL DE CONTATO',
                hint: 'seu.email@exemplo.com',
                keyboardType: TextInputType.emailAddress,
                validator: (v) =>
                    v == null || !v.contains('@') ? 'E-mail inválido' : null,
              ),
            ],
            const SizedBox(height: 18),

            // Natureza do Contato (Pills Selecionáveis)
            Text(
              'NATUREZA DO CONTATO / TIPO DE DEMANDA',
              style: GoogleFonts.firaCode(
                fontSize: 10,
                color: AppColors.textMuted,
                letterSpacing: 1.1,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final opt in _natureOptions)
                  InkWell(
                    onTap: () => setState(() => _selectedNature = opt),
                    borderRadius: BorderRadius.circular(2),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: _selectedNature == opt
                            ? const Color(0xFF142B24)
                            : AppColors.cardSecondary,
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(
                          color: _selectedNature == opt
                              ? AppColors.cyan
                              : AppColors.border,
                          width: _selectedNature == opt ? 1.4 : 1.0,
                        ),
                        boxShadow: _selectedNature == opt
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
                        opt,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: _selectedNature == opt
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: _selectedNature == opt
                              ? Colors.white
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 18),

            // Assunto
            _buildTextField(
              controller: _subjectController,
              label: 'ASSUNTO',
              hint: '',
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Informe o assunto' : null,
            ),
            const SizedBox(height: 14),

            // Mensagem
            _buildTextField(
              controller: _messageController,
              label: 'CONTEXTO & DETALHES',
              hint: 'Descreva a oportunidade, proposta de projeto ou mensagem...',
              maxLines: 4,
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Informe a mensagem' : null,
            ),
            const SizedBox(height: 22),

            // Botão Despachar Mensagem
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                onPressed: _isDispatching ? null : _submitForm,
                icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                label: Text(
                  _isDispatching ? 'Acionando...' : 'Despachar Mensagem',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 13.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Indicadores de Etapas Abaixo do Formulário
            Container(
              padding: const EdgeInsets.only(top: 18),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.border.withValues(alpha: 0.6)),
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isCompact = constraints.maxWidth < 450;
                  final stepWidth = isCompact
                      ? constraints.maxWidth
                      : (constraints.maxWidth - 20) / 3;

                  return Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _StepExplanatoryCard(
                        width: stepWidth,
                        code: '01 / RECEBIMENTO',
                        text: 'Leitura e triagem inicial da mensagem enviada.',
                      ),
                      _StepExplanatoryCard(
                        width: stepWidth,
                        code: '02 / ANÁLISE',
                        text: 'Alinhamento técnico de escopo e compatibilidade.',
                      ),
                      _StepExplanatoryCard(
                        width: stepWidth,
                        code: '03 / RETORNO',
                        text: 'Resposta direta por e-mail ou canais indicados.',
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40 : 20,
        vertical: 60,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1140),
        child: isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: leftColumn),
                  const SizedBox(width: 44),
                  Expanded(flex: 6, child: rightColumn),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  leftColumn,
                  const SizedBox(height: 40),
                  rightColumn,
                ],
              ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.firaCode(
            fontSize: 10,
            color: AppColors.textMuted,
            letterSpacing: 1.1,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: GoogleFonts.inter(fontSize: 13, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(fontSize: 13, color: AppColors.textMuted),
            filled: true,
            fillColor: AppColors.background,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: const BorderSide(color: AppColors.cyan, width: 1.2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: const BorderSide(color: Color(0xFFEF4444)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: const BorderSide(color: Color(0xFFEF4444)),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
        ),
      ],
    );
  }
}

class _ChannelCard extends StatelessWidget {
  final Widget iconWidget;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ChannelCard({
    required this.iconWidget,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(2),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            IconTheme(
              data: const IconThemeData(color: AppColors.cyan),
              child: iconWidget,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.firaCode(
                      fontSize: 10.5,
                      color: AppColors.textMuted,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepExplanatoryCard extends StatelessWidget {
  final double width;
  final String code;
  final String text;

  const _StepExplanatoryCard({
    required this.width,
    required this.code,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.cardSecondary,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            code,
            style: GoogleFonts.firaCode(
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
              color: AppColors.cyan,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: AppColors.textMuted,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
