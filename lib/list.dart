class TodoList {
  final int? id;
  final String? title;
  final String? description;
  final String? dateandtime;

  TodoList({
    this.id,
    this.title,
    this.description,
    this.dateandtime,
  });

  TodoList.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        description = res['description'],
        dateandtime = res['dateandtime'];

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "dateandtime": dateandtime,
    };
  }
}
