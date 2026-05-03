import 'package:flutter/material.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TaskPage(),
    );
  }
}

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TextEditingController taskController = TextEditingController();

  List<Map<String, dynamic>> tasks = [];

  void addTask() {
    if (taskController.text.trim().isEmpty) return;

    setState(() {
      tasks.add({
        "title": taskController.text,
        "done": false,
      });
    });

    taskController.clear();
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index]["done"] = !tasks[index]["done"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Task Tracker"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [

            TextField(
              controller: taskController,
              decoration: const InputDecoration(
                labelText: "Enter Task",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: addTask,
              child: const Text("Add Task"),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: tasks.isEmpty
                  ? const Center(
                child: Text(
                  "No Tasks Added",
                  style: TextStyle(fontSize: 18),
                ),
              )
                  : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        tasks[index]["title"],
                        style: TextStyle(
                          decoration: tasks[index]["done"]
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: Checkbox(
                        value: tasks[index]["done"],
                        onChanged: (value) {
                          toggleTask(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}