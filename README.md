# Pomodoro Tasks

App Flutter simples para gerenciar tarefas e usar um temporizador Pomodoro (25/5/15).

Principais características:
- Lista de tarefas: adicionar, concluir, remover (usando setState)
- Temporizador Pomodoro: iniciar, pausar, resetar; alterna entre foco, pausa curta e longa
- Desenvolvido seguindo princípios de XP: pequenos ciclos, testar sempre, refatorar aos poucos

Como executar:
1. Tenha o Flutter SDK instalado e configurado.
2. No terminal, rode:

```bash
flutter pub get
flutter run
```

Testes:
```
flutter test
```

Observações:
- O projeto usa apenas setState para gerenciamento de estado.
- Implementações futuras podem adicionar persistência simples (shared_preferences) ou personalização de tempos.

Estrutura de arquivos:
- lib/main.dart — ponto de entrada e navegação
- lib/screens/tasks_screen.dart — tela de tarefas
- lib/screens/pomodoro_screen.dart — tela do temporizador Pomodoro
- lib/widgets/task_item.dart — widget para item de tarefa
- lib/models/task.dart — modelo simples de Task
- test/widget_test.dart — testes de widget básicos

Princípios de XP aplicados:
- Pequenos ciclos de desenvolvimento
- Testes adicionados ao implementar telas
- Refatorações e melhorias incrementais
- Entreguei partes funcionais rapidamente
# flutter_project
