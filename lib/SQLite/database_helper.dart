// ignore_for_file: avoid_print

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  final String databaseName = "auth.db";

  // Tables
  // No comma at the end of SQLite statement.
  final String user = '''
  CREATE TABLE users(
  usrId INTEGER PRIMARY KEY AUTOINCREMENT,
  fullname TEXT,
  email TEXT UNIQUE,
  usrPassword TEXT
  )
  ''';

  // Our Connection is ready
  Future<Database> initDB() async {
    final String databasePath = await getDatabasesPath();
    final String path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(user);
    });
  }

  // Authentication
  Future<bool> authenticate(Users user) async {
    final Database db = await initDB();
    var result = await db.rawQuery(
        "SELECT * FROM users WHERE email = ? AND usrPassword = ?",
        [user.email, user.usrPassword]);
    return result.isNotEmpty;
  }

  // Sign up
  Future<int> createUser(Users user) async {
    try {
      final Database db = await initDB();
      return await db.insert("users", user.toMap());
    } catch (e) {
      print("Error creating user: $e");
      return -1;
    }
  }

  // Get current user details
  Future<Users?> getUser(String email) async {
    try {
      final Database db = await initDB();
      var res = await db.query("users", where: "email = ?", whereArgs: [email]);
      return res.isNotEmpty ? Users.fromMap(res.first) : null;
    } catch (e) {
      print("Error getting user: $e");
      return null;
    }
  }
}

class Users {
  final String fullname;
  final String email;
  final String usrPassword;

  Users({
    required this.fullname,
    required this.email,
    required this.usrPassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullname': fullname,
      'email': email,
      'usrPassword': usrPassword,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      fullname: map['fullname'],
      email: map['email'],
      usrPassword: map['usrPassword'],
    );
  }
}
