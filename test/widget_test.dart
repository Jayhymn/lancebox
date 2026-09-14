import 'package:flutter_test/flutter_test.dart';
import 'package:lance_box/main.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Lance Box'), findsOneWidget);
  });
}