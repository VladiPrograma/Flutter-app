import 'package:cicero_app/core/datasources/local_datasource.dart';
import 'package:sqflite/sqflite.dart';

import '../models/media_model.dart';


abstract interface class MediaLocalDataSource {
  Future<MediaModel> createMedia(MediaModel mediaModel);
  Future<MediaModel?> updateMedia(MediaModel mediaModel);
  Future<bool> deleteMedia(int id);
  Future<List<MediaModel>> getMedia(int id);


}

class MediaLocalDataSourceImpl implements MediaLocalDataSource {
  MediaLocalDataSourceImpl();

  @override
  Future<MediaModel> createMedia(MediaModel mediaModel) async{
    final Database db = await LocalDatabase.instance.database;
    mediaModel.id_media =await db.insert(
      DatabaseTables.tMedia,
      mediaModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return mediaModel;
  }

  @override
  Future<bool> deleteMedia(int id)async {
    final Database db = await LocalDatabase.instance.database;
    int count =await db.delete(
      DatabaseTables.tMedia,
      where: 'id_media = ?',
      whereArgs: [id],
    );
    return count>0;
  }

  @override
  Future<List<MediaModel>> getMedia(int id) async{
    final Database db = await LocalDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(DatabaseTables.tMedia,where: 'id_actuacion = ?',
      whereArgs: [id],);
    return maps.map((media) => MediaModel.fromMap(media)).toList();
  }

  @override
  Future<MediaModel?> updateMedia(MediaModel mediaModel) async{
    final Database db = await LocalDatabase.instance.database;
    int count=await db.update(
      DatabaseTables.tMedia,
      mediaModel.toMap(),
      where: 'id_media = ?',
      whereArgs: [mediaModel.id_media],
    );
    return count==0? null: mediaModel;
  }

}
