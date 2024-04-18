import 'package:schoolnotes/model/User.dart';
import 'package:schoolnotes/service/user_service.dart';
import 'package:flutter/material.dart';

class SaveTopicProvider extends ChangeNotifier {
  final LoginService services = LoginService();
  List<String> _topics = [];
  List<String> get topics => _topics;

  Future<List<String>?> listMyTopics(ModelUser user) async {
    if (user.notes == null) {
      _topics = [];
      return _topics;
    } else {
      print(" listmytopics ${user.notes!}");
      _topics = user.notes!;
      return _topics;
    }
  }

  void addTopic(ModelUser u, String topic) async {
    final isExist = _topics.contains(topic);
    if (isExist) {
      u.notes = _topics;
      u.notes!.remove(topic);
      await services.setNotesToUser(u);
    } else {
      u.notes = _topics;
      u.notes!.add(topic);
      await services.setNotesToUser(u);
    }
    notifyListeners();
  }

  bool isExist(String topic) {
    final isExist = _topics.contains(topic);
    return isExist;
  }

  notifyListeners();
}
