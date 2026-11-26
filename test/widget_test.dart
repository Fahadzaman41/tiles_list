import 'package:flutter_test/flutter_test.dart';
import 'package:list_tile/main.dart';

void main() {
  testWidgets('Student Management App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const StudentManagementApp());
    expect(find.text('EduManager Portal'), findsOneWidget);
  });
}
