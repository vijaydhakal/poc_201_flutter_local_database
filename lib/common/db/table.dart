/// Represents a database table along with its name and creation query.
class Table {
  /// Creates a [Table] instance with the specified [tableName] and
  ///  [createTableQuery].
  Table({
    required this.tableName,
    required this.createTableQuery,
  });

  /// The name of the database table.
  final String tableName;

  /// The SQL query used to create the database table.
  final String createTableQuery;
}
