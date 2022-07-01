import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:pinterest_project/models/pinterest_model.dart';

class HiveDB {
  static const String dbName = "fact";
  static var box = Hive.box(dbName);

  // fact write
  static void storeFacts(List <Post> facts) async {
    List <String> fact = facts.map((e) => jsonEncode(e.toJson())).toList();
    await box.put('fact', fact);
  }

  // fact return
  static List<Post> loadFact() {
    List <String> factList = box.get("fact") ?? <String>[];
    List <Post> fact = factList.map((string) => Post.fromJson(jsonDecode(string))).toList();
    return fact;
  }

  // fact delete
  static Future <void> removeFact() async {
    await box.delete('fact');
  }
}