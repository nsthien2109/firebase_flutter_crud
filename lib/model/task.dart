class Task {
  String? id;
  String? name;
  String? description;
  String? uid;

  Task({this.id,this.name, this.description, this.uid});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['uid'] = uid;
    return data;
  }
}