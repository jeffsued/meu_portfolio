import 'package:flutter_test/flutter_test.dart';
import 'package:meu_portfolio/main.dart';

void main() {
  testWidgets('Verifica renderizacao inicial do portfolio', (WidgetTester tester) async {
    // Inicializa o widget raiz do portfolio
    await tester.pumpWidget(const MeuPortfolio());
    expect(find.byType(MeuPortfolio), findsOneWidget);
  });
}
