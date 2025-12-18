import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro_tasks/main.dart';

void main() {
  testWidgets('Adicionar, marcar e remover tarefa', (WidgetTester tester) async {
    await tester.pumpWidget(const PomodoroTasksApp());

    expect(find.text('Sem tarefas. Toque no + para adicionar.'), findsOneWidget);

    // Abrir dialog de adicionar
    await tester.tap(find.byTooltip('Adicionar tarefa'));
    await tester.pumpAndSettle();

    // Preencher e adicionar
    await tester.enterText(find.byType(TextField), 'Tarefa de teste');
    await tester.tap(find.text('Adicionar'));
    await tester.pumpAndSettle();

    expect(find.text('Tarefa de teste'), findsOneWidget);

    // Marcar como concluída (toggle checkbox)
    final checkbox = find.byType(Checkbox).first;
    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    // Remover
    await tester.tap(find.byIcon(Icons.delete).first);
    await tester.pumpAndSettle();

    expect(find.text('Tarefa de teste'), findsNothing);
  });

  testWidgets('Pomodoro inicia e decrementa 1 segundo', (WidgetTester tester) async {
    await tester.pumpWidget(const PomodoroTasksApp());

    // Ir para aba Pomodoro
    await tester.tap(find.text('Pomodoro'));
    await tester.pumpAndSettle();

    // Tempo inicial
    expect(find.text('25:00'), findsOneWidget);

    // Iniciar e avançar 1s
    await tester.tap(find.text('Iniciar'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('24:59'), findsOneWidget);
  });
}
