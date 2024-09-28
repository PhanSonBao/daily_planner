import 'package:flutter/material.dart';
import '../../models/task.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Task task;

  const TaskDetailsScreen({super.key, required this.task});

  @override
  TaskDetailsScreenState createState() => TaskDetailsScreenState();
}

class TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final List<String> _timeRanges = ['8h->11h', '13h->16h', '16h->18h'];
  final List<String> _leaders = ['Thanh Ngân', 'Hữu Nghĩa'];
  final List<String> _approvers = ['Nguyễn Văn A', 'Trần Thị B'];
  final List<String> _statuses = ['Tạo mới', 'Thực hiện', 'Thành công', 'Kết thúc'];

  late TextEditingController _contentController;
  late TextEditingController _notesController;
  late TextEditingController _locationController;
  late TextEditingController _dateController;
  String? _selectedTimeRange;
  String? _selectedLeader;
  String? _selectedApprover;
  String? _selectedStatus;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.task.content);
    _notesController = TextEditingController(text: widget.task.notes);
    _locationController = TextEditingController(text: widget.task.location);
    _dateController = TextEditingController(text: "${widget.task.date.day}/${widget.task.date.month}/${widget.task.date.year}");
    _selectedDate = widget.task.date;
    _selectedTimeRange = widget.task.timeRange;
    _selectedLeader = widget.task.leader;
    _selectedApprover = widget.task.approver;
    _selectedStatus = widget.task.status;
  }

  @override
  void dispose() {
    _contentController.dispose();
    _notesController.dispose();
    _locationController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết công việc'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              setState(() {
                widget.task.content = _contentController.text;
                widget.task.notes = _notesController.text;
                widget.task.location = _locationController.text;
                widget.task.date = _selectedDate;
                widget.task.timeRange = _selectedTimeRange!;
                widget.task.leader = _selectedLeader!;
                widget.task.approver = _selectedApprover!;
                widget.task.status = _selectedStatus!;
              });
              Navigator.pop(context, widget.task);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Nội dung công việc'),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Ngày thực hiện',
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 20),

              ListTile(
                title: const Text('Khoảng thời gian'),
                trailing: DropdownButton<String>(
                  value: _selectedTimeRange,
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
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Địa điểm'),
              ),
              const SizedBox(height: 20),

              ListTile(
                title: const Text('Người chủ trì'),
                trailing: DropdownButton<String>(
                  value: _selectedLeader,
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
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Ghi chú'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),

              ListTile(
                title: const Text('Trạng thái'),
                trailing: DropdownButton<String>(
                  value: _selectedStatus,
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
              ),
              const SizedBox(height: 20),

              ListTile(
                title: const Text('Người kiểm duyệt'),
                trailing: DropdownButton<String>(
                  value: _selectedApprover,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
