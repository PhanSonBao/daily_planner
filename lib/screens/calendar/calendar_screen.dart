import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:daily_planner/screens/task/components/task_provider.dart';
import 'package:daily_planner/screens/task/task_details_screen.dart';
import 'package:daily_planner/models/task.dart';
import 'package:daily_planner/route/route_constants.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  CalendarScreenState createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    // Lấy danh sách công việc theo ngày đã chọn
    final tasksForSelectedDay = taskProvider.getTasksByDate(_selectedDay);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TH9'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.calendar_today),
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // Cập nhật ngày được chọn
              });
            },
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                shape: BoxShape.circle,
              ),
              markersMaxCount: 1,
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, tasks) {
                if (tasks.isNotEmpty) {
                  return Positioned(
                    bottom: 1,
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
            eventLoader: (day) {
              return taskProvider.getTasksByDate(day);
            },
          ),
          const SizedBox(height: 8),

          // Hiển thị danh sách công việc hoặc thông báo không có công việc
          tasksForSelectedDay.isEmpty
              ? const Expanded(
                  child: Center(
                    child: Text(
                      'Không có công việc nào',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: tasksForSelectedDay.length,
                    itemBuilder: (context, index) {
                      final task = tasksForSelectedDay[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskDetailsScreen(task: task),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.blue[100],
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task.timeRange,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    task.content,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.pushNamed(context, addNewTaskScreenRoute);

          if (newTask != null && newTask is Task) {
            taskProvider.addTask(newTask);  // Thêm công việc mới vào Provider
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
