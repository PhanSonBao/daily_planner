import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];

  // Lấy danh sách công việc
  List<Task> get tasks => _tasks;

  // Thêm công việc mới
  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners(); // Thông báo cho các widget lắng nghe khi dữ liệu thay đổi
  }

  // Xóa công việc
  void removeTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  // Lấy công việc theo ngày
  List<Task> getTasksByDate(DateTime date) {
    return _tasks.where((task) {
      final taskDate = DateFormat('yyyy-MM-dd').format(task.date);
      final selectedDate = DateFormat('yyyy-MM-dd').format(date);
      return taskDate == selectedDate;
    }).toList();
  }
}
