import 'package:flutter/material.dart';
import 'screens/tasks_screen.dart';
import 'screens/pomodoro_screen.dart';

void main() {
  runApp(const PomodoroTasksApp());
}

class PomodoroTasksApp extends StatelessWidget {
  const PomodoroTasksApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Tasks',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;

  static const List<Widget> _screens = <Widget>[
    TasksScreen(),
    PomodoroScreen(),
  ];

  void _onTap(int idx) {
    setState(() {
      _index = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tarefas'),
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Pomodoro'),
        ],
      ),
    );
  }
}
