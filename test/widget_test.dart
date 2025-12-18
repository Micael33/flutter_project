import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro_tasks/main.dart';

void main() {
  testWidgets('App shows two bottom navigation items and app loads; Pomodoro screen shows controls', (WidgetTester tester) async {
    await tester.pumpWidget(const PomodoroTasksApp());

    expect(find.text('Tarefas'), findsWidgets);
    expect(find.text('Pomodoro'), findsWidgets);

    // Verify initial screen content
    expect(find.text('Sem tarefas. Toque no + para adicionar.'), findsOneWidget);

    // Go to Pomodoro tab
    await tester.tap(find.text('Pomodoro'));
    await tester.pumpAndSettle();

    expect(find.text('Pomodoro'), findsWidgets);
    expect(find.text('Iniciar'), findsOneWidget);
    // Initial time should be 25:00
    expect(find.text('25:00'), findsOneWidget);
  });
}
