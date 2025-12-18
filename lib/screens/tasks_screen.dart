import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_item.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<Task> _tasks = [];
  final TextEditingController _controller = TextEditingController();

  void _addTask(String title) {
    if (title.trim().isEmpty) return;
    setState(() {
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      _tasks.insert(0, Task(id: id, title: title.trim()));
    });
    _controller.clear();
    Navigator.of(context).pop();
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Adicionar tarefa'),
        content: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Digite o título'),
          onSubmitted: _addTask,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
          ElevatedButton(onPressed: () => _addTask(_controller.text), child: const Text('Adicionar'))
        ],
      ),
    );
  }

  void _toggleTask(Task t) {
    setState(() {
      t.isDone = !t.isDone;
    });
  }

  void _removeTask(Task t) {
    setState(() {
      _tasks.removeWhere((x) => x.id == t.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarefas')),
      body: _tasks.isEmpty
          ? const Center(child: Text('Sem tarefas. Toque no + para adicionar.'))
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (ctx, i) {
                final t = _tasks[i];
                return Dismissible(
                  key: ValueKey(t.id),
                  background: Container(color: Colors.red, alignment: Alignment.centerLeft, padding: const EdgeInsets.only(left: 16), child: const Icon(Icons.delete, color: Colors.white)),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (_) => _removeTask(t),
                  child: TaskItem(task: t, onToggle: () => _toggleTask(t), onDelete: () => _removeTask(t)),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        tooltip: 'Adicionar tarefa',
        child: const Icon(Icons.add),
      ),
    );
  }
}
