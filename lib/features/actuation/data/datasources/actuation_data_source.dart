import 'package:cicero_app/core/datasources/local_datasource.dart';
import 'package:sqflite/sqflite.dart';

import '/features/actuation/data/models/actuation_model.dart';

abstract interface class ActuationLocalDataSource {
Future<ActuationModel> createActuation(ActuationModel actuationModel);
Future<ActuationModel?> updateActuation(ActuationModel actuationModel);
Future<bool> deleteActuation(int id);
Future<List<ActuationModel>> getActuation();


}

class ActuationLocalDataSourceImpl implements ActuationLocalDataSource {
  ActuationLocalDataSourceImpl();

  @override
  Future<ActuationModel> createActuation(ActuationModel actuationModel) async{
    final Database db = await LocalDatabase.instance.database;
    actuationModel.id_actuacion =await db.insert(
      DatabaseTables.tActuation,
      actuationModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return actuationModel;
  }

  @override
  Future<bool> deleteActuation(int id)async {
    final Database db = await LocalDatabase.instance.database;
    int count =await db.delete(
      DatabaseTables.tActuation,
      where: 'id_actuacion = ?',
      whereArgs: [id],
    );
    return count>0;
  }

  @override
  Future<List<ActuationModel>> getActuation() async{
    final Database db = await LocalDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(DatabaseTables.tActuation);
   return maps.map((actuation) => ActuationModel.fromMap(actuation)).toList();
  }

  @override
  Future<ActuationModel?> updateActuation(ActuationModel actuationModel) async{
    final Database db = await LocalDatabase.instance.database;
    int count=await db.update(
      DatabaseTables.tActuation,
      actuationModel.toMap(),
      where: 'id_actuacion = ?',
      whereArgs: [actuationModel.id_actuacion],
    );
    return count==0? null: actuationModel;
  }

}
