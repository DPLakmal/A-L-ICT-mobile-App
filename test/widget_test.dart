import 'package:flutter_test/flutter_test.dart';
import 'package:almcq/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    expect(const MyApp(), isNotNull);
  });
}
