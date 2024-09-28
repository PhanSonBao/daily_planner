import 'package:daily_planner/route/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:daily_planner/screens/task/components/task_provider.dart';

import 'package:daily_planner/models/task.dart';
import 'package:provider/provider.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {

  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context); // Đảm bảo rằng Provider có thể được truy cập

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách công việc'),
      ),
      body: taskProvider.tasks.isEmpty
          ? const Center(child: Text('Không có công việc nào'))
          : ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];
                return Card(
                  color: Colors.blue[100],
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: ListTile(
                    title: Text(task.content),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          taskProvider.removeTask(index); // Xóa công việc khỏi Provider
                        });
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Mở màn hình AddNewTaskScreen và đợi phản hồi
          final newTask = await Navigator.pushNamed(context, addNewTaskScreenRoute);

          // Kiểm tra nếu đối tượng trả về là Task, không phải String
          if (newTask != null && newTask is Task) {
            taskProvider.addTask(newTask);  // Thêm công việc mới vào Provider
          }
        },
        child: const Icon(Icons.add, color: Colors. white),
      ),
    );
  }
}