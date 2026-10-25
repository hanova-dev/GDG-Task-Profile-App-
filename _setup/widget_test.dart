import 'package:flutter_test/flutter_test.dart';
import 'package:profile_app/main.dart';

void main() {
  testWidgets('Profile screen shows my name', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Hanan bin Saleh'), findsWidgets);
  });
}
