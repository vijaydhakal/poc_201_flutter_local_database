class Department {
  final int? id;
  final String departmentName;

  Department({
    this.id,
    required this.departmentName,
  });

  // Convert a Map into a Department
  factory Department.fromMap(Map<String, dynamic> json) => Department(
        id: json['id'],
        departmentName: json['department_name'],
      );

  // Convert a Department into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'department_name': departmentName,
    };
  }
}
