import 'dart:convert';
import 'package:schoolnotes/model/User.dart';
import 'package:http/http.dart' as http;

class LoginService {
  final String _firebaseUrl =
      "https://schoolnotes-ea0cc-default-rtdb.europe-west1.firebasedatabase.app";

  Uri getUrl(String endpoint) => Uri.parse("$_firebaseUrl/$endpoint.json");

  Future<ModelUser?> postUser(ModelUser user) async {
    final response = await http.post(
      getUrl("users"),
      body: json.encode(user.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var data = json.decode(response.body);

      user.id = data["name"];
      return ModelUser.fromMap(json.decode(response.body));
    } else {
      throw Exception('Failed to post user');
    }
  }

  Future<ModelUser?> getCurrentUser(String email) async {
    final response = await http.get(
      getUrl("users"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      List<ModelUser> userList = [];
      var data = json.decode(response.body);
      print("users -> $data");
      data.forEach((key, value) {
        ModelUser m = ModelUser();
        List<String> userNotes = [];

        m.id = key;
        m.email = value["email"];
        m.grade = value["grade"];
        if (value.containsKey("notes") && value["notes"] != null) {
          for (var note in value["notes"]) {
            userNotes.add(note);
            print(" user -> ${value["username"]} notes -> ${m.notes}");
          }
        }
        m.notes = userNotes;
        m.username = value["username"];
        userList.add(m);
        print("usernotes  $userNotes");
      });
      ModelUser? user =
          userList.firstWhere((element) => element.email == email);

      return user;
    } else {
      throw Exception('Failed to get user');
    }
  }

  Future<ModelUser?> setNotesToUser(ModelUser user) async {
    final response = await http.put(
      getUrl("users/${user.id}"),
      body: json.encode(user.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return user;
    } else {
      throw Exception('Failed to post user');
    }
  }

  Future<ModelUser?> updateUser(ModelUser user) async {
    final response = await http.put(
      getUrl("users/${user.id}"),
      body: json.encode(user.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print(" updating usename is -> ${user.username}");
      return user;
    } else {
      throw Exception('Failed to get user');
    }
  }
}

/*


Future<List<String>?> getUsers(String email) async {
    try {
      final response = await http.get(
        getUrl("users"),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<ModelUser> userList = [];
        List<String> notesList = [];
        var data = json.decode(response.body);
        data.forEach((key, value) {
          userList.add(ModelUser.fromMap(value));
        });
        ModelUser user = userList
            .firstWhere((element) => element.email == email, orElse: null);
        print(user.email);
        if (user.notes != null) {
          for (var note in user.notes!) {
            notesList.add(note);
          }
        } else {
          print('Hiç Not Yok');
        }
        print(notesList);
        return notesList;
      } else {
        throw Exception('Kullanıcılar getirilirken bir hata oldu');
      }
    } catch (e) {
      print('Error fetching users: $e');
      return null;
    }
  }

  Future<ModelUser> getCurrentuser(ModelUser user) async {
    http.Response response = await http.post(getUrl("users/${id}"),
        body: user.toJson(), headers: {"Content-Type": "application/json"});
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var data = json.decode(response.body);
      user.id = data["localId"];

      return user;
    } else {
      return user;
    }
  }

  Future<void> setNote(ModelUser currentUser) async {
    try {
      final response = await http.put(
        getUrl("users/${currentUser}"),
        body: currentUser.toJson(),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
      } else {
        throw Exception('Kullanıcılar getirilirken bir hata oldu');
      }
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

 */