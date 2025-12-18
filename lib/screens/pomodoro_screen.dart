import 'dart:async';

import 'package:flutter/material.dart';

enum PomodoroMode { focus, shortBreak, longBreak }

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({Key? key}) : super(key: key);

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  static const int focusDuration = 25 * 60; // 25 minutes
  static const int shortBreakDuration = 5 * 60; // 5 minutes
  static const int longBreakDuration = 15 * 60; // 15 minutes

  PomodoroMode _mode = PomodoroMode.focus;
  int _remaining = focusDuration;
  Timer? _timer;
  bool _running = false;
  int _completedFocusCount = 0;

  void _start() {
    if (_running) return;
    setState(() {
      _running = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (_remaining > 0) {
          _remaining -= 1;
        } else {
          _onCompleteInterval();
        }
      });
    });
  }

  void _pause() {
    _timer?.cancel();
    setState(() {
      _running = false;
    });
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _running = false;
      _setMode(_mode);
    });
  }

  void _setMode(PomodoroMode mode) {
    _mode = mode;
    switch (mode) {
      case PomodoroMode.focus:
        _remaining = focusDuration;
        break;
      case PomodoroMode.shortBreak:
        _remaining = shortBreakDuration;
        break;
      case PomodoroMode.longBreak:
        _remaining = longBreakDuration;
        break;
    }
  }

  void _onCompleteInterval() {
    _timer?.cancel();
    if (_mode == PomodoroMode.focus) {
      _completedFocusCount += 1;
      if (_completedFocusCount % 4 == 0) {
        _setMode(PomodoroMode.longBreak);
      } else {
        _setMode(PomodoroMode.shortBreak);
      }
    } else {
      _setMode(PomodoroMode.focus);
    }
    _running = false;
    // Auto-start next interval is optional; keep paused for user control
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = _mode == PomodoroMode.focus ? 'Foco' : (_mode == PomodoroMode.shortBreak ? 'Pausa curta' : 'Pausa longa');
    return Scaffold(
      appBar: AppBar(title: const Text('Pomodoro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 24),
            Text(_formatTime(_remaining), style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Semantics(
                  button: true,
                  label: _running ? 'Pausar temporizador' : 'Iniciar temporizador',
                  child: ElevatedButton.icon(
                    icon: Icon(_running ? Icons.pause : Icons.play_arrow),
                    label: Text(_running ? 'Pausar' : 'Iniciar'),
                    onPressed: () {
                      if (_running) {
                        _pause();
                      } else {
                        _start();
                      }
                    },
                    style: ElevatedButton.styleFrom(),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: _reset,
                  child: const Text('Resetar'),
                )
              ],
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Foco'),
                  selected: _mode == PomodoroMode.focus,
                  onSelected: (_) => setState(() => _setMode(PomodoroMode.focus)),
                ),
                ChoiceChip(
                  label: const Text('Pausa curta'),
                  selected: _mode == PomodoroMode.shortBreak,
                  onSelected: (_) => setState(() => _setMode(PomodoroMode.shortBreak)),
                ),
                ChoiceChip(
                  label: const Text('Pausa longa'),
                  selected: _mode == PomodoroMode.longBreak,
                  onSelected: (_) => setState(() => _setMode(PomodoroMode.longBreak)),
                ),
              ],
            ),
            const Spacer(),
            Text('Pomodoros concluídos: $_completedFocusCount'),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
