import 'package:flutter/material.dart';

class ListLessonsProvider extends ChangeNotifier {
  List<String> topicList = [];
  List<String> topicListPath = [];

  final List<Map<String, dynamic>> _lessons = [
    {"Türkçe": "assets/turkish.png"},
    {"Matematik": "assets/math.png"},
    {"Fizik": "assets/physics.png"},
    {"Kimya": "assets/chemistry.png"},
    {"Biyoloji": "assets/biology.png"},
    {"Coğrafya": "assets/geograpy.png"},
    {"İngilizce": "assets/english.png"},
    {"Din Kültürü": "assets/mosque.png"},
  ];
  Map<String, dynamic> grade_12 = {
    "T.C. İnkılap Tarihi Ve Atatürkçülük": "assets/history.png"
  };
  Map<String, dynamic> grade_10 = {"Felsefe": "assets/philosophy.png"};
  Map<String, dynamic> other_grades = {"Tarih": "assets/history.png"};

  List<Map<String, dynamic>> get lessons => _lessons;

  List<Map<String, dynamic>> getLessons(item) {
    print(item);
    if (item == "12. Sınıf") {
      isExist(other_grades, grade_12);
      removeGrade10(grade_10);
    } else if (item == "10. Sınıf") {
      isGrade10(grade_10);
      isExist(grade_12, other_grades);
    } else {
      isExist(grade_12, other_grades);
      removeGrade10(grade_10);
    }
    return _lessons;
  }

  void isExist(remove, add) {
    if (!lessons.contains(add)) {
      lessons.remove(remove);
      lessons.insert(5, add);
    }
  }

  void isGrade10(add) {
    if (!lessons.contains(add)) {
      lessons.insert(5, add);
    }
  }

  void removeGrade10(remove) {
    if (lessons.contains(remove)) {
      lessons.remove(remove);
    }
  }

  Future<void> setTopics(String data) async {
    topicList.add(data);
    print(data);
    notifyListeners();
  }

  Future<void> setTopicsPath(String data) async {
    topicListPath.add(data);

    notifyListeners();
  }

  notifyListeners();
}
