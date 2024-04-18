import 'dart:convert';

class ModelUser {
  String? id;
  String? username;
  String? email;
  String? grade;
  List<String>? notes;

  ModelUser({this.username, this.email, this.grade, this.notes, String? id});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      'username': username,
      'email': email,
      'grade': grade,
      'notes': notes,
    };
  }

  ModelUser.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    username = json['username'];
    email = json['email'];
    grade = json['grade'];
    if (json['notes'] != null) {
      notes = List<String>.from(json['notes']);
    }
  }

  factory ModelUser.fromMap(Map<String, dynamic> map) {
    return ModelUser(
      id: map['id'] != null ? map['id'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      grade: map['grade'] != null ? map['grade'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      notes: map['notes'] != null
          ? List<String>.from(map['notes'] as List<dynamic>)
          : null,
    );
  }

  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data['username'] = username;
    data['email'] = email;
    data['grade'] = grade;
    data['notes'] = notes;
    return data;
  }

  String toJsonModel() => json.encode(toMap());
}
