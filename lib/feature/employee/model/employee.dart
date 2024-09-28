class Employee {
  final int? id;
  final String name;
  final int? departmentId;
  final String? departmentName;
  final String salary;
  final int? projectId;
  final String? projectName;
  final String assignmentStatus;

  Employee({
    this.id,
    required this.name,
    this.departmentId,
    this.departmentName,
    required this.salary,
    this.projectId,
    this.projectName,
    required this.assignmentStatus,
  });

  factory Employee.fromMap(Map<String, dynamic> json) => Employee(
        id: json['id'],
        name: json['name'],
        departmentId: json['department_id'],
        departmentName: json['department_name'],
        salary: json['salary'].toString(),
        projectId: json['project_id'],
        projectName: json['project_name'],
        assignmentStatus: json['assignment_status'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'department_id': departmentId,
      'department_name': departmentName,
      'salary': salary,
      'project_id': projectId,
      'project_name': projectName,
      'assignment_status': assignmentStatus,
    };
  }
}
