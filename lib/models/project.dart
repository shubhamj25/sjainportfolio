class Project {
  Project({
    String title,
    String description,
    String category,
    String link,
    String type,
  }) {
    _title = title;
    _description = description;
    _category = category;
    _link = link;
    _type = type;
  }

  factory Project.fromJson(dynamic json) {
    return Project(
      title: json['title'],
      description: json['description'],
      category: json['category'],
      link: json['link'],
      type: json['type'],
    );
  }

  String _title;
  String _description;
  String _category;
  String _link;
  String _type;

  String get title => _title;

  String get description => _description;

  String get category => _category;

  String get link => _link;

  String get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['description'] = _description;
    map['category'] = _category;
    map['link'] = _link;
    map['type'] = _type;
    return map;
  }
}
