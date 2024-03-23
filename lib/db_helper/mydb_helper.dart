import 'package:path/path.dart';
import 'package:sqf_db2_32/pages/student_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelpers {
  static const String createStTableContact = '''
create table $st_tableContact(
  $st_tableContactColId integer primary key,
  $st_tableContactColName text,
  $st_tableContactColPhone text,
  $st_tableContactColAddress text,
  $st_tableContactColinstitute text,
  $st_tableContactColDob text,
  $st_tableContactColGender text,
  $st_tableContactColImage text,
  $st_tableContactColFav integer
  )
''';
  static Future<Database> openDb() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'st_cotact.db');

    return openDatabase(dbPath, version: 1, onCreate:  (  db, version) {
      db.execute(createStTableContact);
    });
  }

  static Future<int> insertStContact(StudentModel studentModel) async {
    final st_db = await openDb();
    return st_db.insert(st_tableContact, studentModel.toMap());
  }

  static Future<List<StudentModel>> getAllContacts() async {
    final db = await openDb();
    final mapList = await db.query(st_tableContact);
    return List.generate(
        mapList.length, (index) => StudentModel.fromMap(mapList[index]));
  }

  static Future<int> updateFavarite(int id, int value) async {
    final db = await openDb();

    return db.update(st_tableContact, {st_tableContactColFav: value},
        where: '$st_tableContactColId = ? ', whereArgs: [id]);
  }
}
