class Project {
  final int? id;
  final String projectName;

  Project({
    this.id,
    required this.projectName,
  });

  // Convert a Map into a Project
  factory Project.fromMap(Map<String, dynamic> json) => Project(
        id: json['id'],
        projectName: json['project_name'],
      );

  // Convert a Project into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'project_name': projectName,
    };
  }
}
