// import 'package:daily_planner/screens/homepage/components/task_function.dart';
import 'package:flutter/material.dart';
import 'package:daily_planner/models/task.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  AddNewTaskScreenState createState() => AddNewTaskScreenState();
}

class AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _taskContentController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  DateTime? _selectedDate;
  String? _selectedTimeRange;
  String? _selectedLeader;
  String? _selectedApprover;
  String _selectedStatus = "Tạo mới";

  // Dropdown items for time range and people
  final List<String> _timeRanges = ['8h->11h', '13h->16h', '16h->18h'];
  final List<String> _leaders = ['Thanh Ngân', 'Hữu Nghĩa'];
  final List<String> _approvers = ['Nguyễn Văn A', 'Trần Thị B'];
  final List<String> _statuses = [
    'Tạo mới',
    'Thực hiện',
    'Thành công',
    'Kết thúc'
  ];

  // Hàm chọn ngày
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm Công việc mới'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            // Chọn ngày
            ListTile(
              title: Text(_selectedDate == null
                  ? 'Chọn ngày'
                  : 'Thứ ${_selectedDate?.weekday}, Ngày ${_selectedDate?.day}/${_selectedDate?.month}/${_selectedDate?.year}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),

            // Nội dung công việc
            TextField(
              controller: _taskContentController,
              decoration:
                  const InputDecoration(labelText: 'Nội dung công việc'),
            ),

            // Thời gian
            DropdownButtonFormField<String>(
              value: _selectedTimeRange,
              hint: const Text('Chọn thời gian'),
              items: _timeRanges.map((time) {
                return DropdownMenuItem<String>(
                  value: time,
                  child: Text(time),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedTimeRange = newValue;
                });
              },
            ),

            // Địa điểm
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Địa điểm'),
            ),

            // Người chủ trì
            DropdownButtonFormField<String>(
              value: _selectedLeader,
              hint: const Text('Chọn người chủ trì'),
              items: _leaders.map((leader) {
                return DropdownMenuItem<String>(
                  value: leader,
                  child: Text(leader),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedLeader = newValue;
                });
              },
            ),

            // Ghi chú
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Ghi chú'),
            ),

            // Trạng thái kiểm duyệt
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration:
                  const InputDecoration(labelText: 'Trạng thái kiểm duyệt'),
              items: _statuses.map((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedStatus = newValue!;
                });
              },
            ),

            // Người kiểm duyệt
            DropdownButtonFormField<String>(
              value: _selectedApprover,
              hint: const Text('Chọn người kiểm duyệt'),
              items: _approvers.map((approver) {
                return DropdownMenuItem<String>(
                  value: approver,
                  child: Text(approver),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedApprover = newValue;
                });
              },
            ),

            // Nút Lưu
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_taskContentController.text.isNotEmpty &&
                    _selectedDate != null &&
                    _selectedTimeRange != null &&
                    _selectedLeader != null &&
                    _selectedApprover != null) {
                  final newTask = Task(
                    content: _taskContentController.text.trim(),
                    date: _selectedDate!,
                    timeRange: _selectedTimeRange!,
                    location: _locationController.text.trim(),
                    leader: _selectedLeader!,
                    notes: _notesController.text.trim(),
                    status: _selectedStatus,
                    approver: _selectedApprover!,
                  );
                  // Thêm công việc
                  Navigator.pop(context, newTask);
                  // Hiển thị thông báo
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Công việc mới đã được thêm!'),
                  ),);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Vui lòng điền đầy đủ thông tin!'),
                  ));
                }
              },
              child: const Text('Thêm công việc'),
            ),
          ],
        ),
      ),
    );
  }
}
