class Task {
  String content;        // Nội dung công việc
  DateTime date;         // Ngày
  String timeRange;      // Khoảng thời gian
  String location;       // Địa điểm
  String leader;         // Người chủ trì
  String notes;          // Ghi chú
  String status;         // Trạng thái
  String approver;       // Người kiểm duyệt

  Task({
    required this.content,
    required this.date,
    required this.timeRange,
    required this.location,
    required this.leader,
    required this.notes,
    required this.status,
    required this.approver,
  });
}
