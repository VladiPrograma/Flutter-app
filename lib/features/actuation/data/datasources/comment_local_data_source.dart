import 'package:cicero_app/core/datasources/local_datasource.dart';
import 'package:sqflite/sqflite.dart';

import '../models/comentario_actuacion_model.dart';


abstract interface class CommentLocalDataSource {
  Future<CommentModel> createComment(CommentModel commentModel);
  Future<CommentModel?> updateComment(CommentModel commentModel);
  Future<bool> deleteComment(int id);
  Future<List<CommentModel>> getComment(int id);


}

class CommentLocalDataSourceImpl implements CommentLocalDataSource {
  CommentLocalDataSourceImpl();

  @override
  Future<CommentModel> createComment(CommentModel commentModel) async{
    final Database db = await LocalDatabase.instance.database;
    commentModel.id_comentario =await db.insert(
      DatabaseTables.tComment,
      commentModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return commentModel;
  }

  @override
  Future<bool> deleteComment(int id)async {
    final Database db = await LocalDatabase.instance.database;
    int count =await db.delete(
      DatabaseTables.tComment,
      where: 'id_comentario = ?',
      whereArgs: [id],
    );
    return count>0;
  }

  @override
  Future<List<CommentModel>> getComment(int id) async{
    final Database db = await LocalDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(DatabaseTables.tComment, where: 'id_actuacion = ?',
      whereArgs: [id],);
    return maps.map((comment) => CommentModel.fromMap(comment)).toList();
  }

  @override
  Future<CommentModel?> updateComment(CommentModel commentModel) async{
    final Database db = await LocalDatabase.instance.database;
    int count=await db.update(
      DatabaseTables.tComment,
      commentModel.toMap(),
      where: 'id_comentario = ?',
      whereArgs: [commentModel.id_comentario],
    );
    return count==0? null: commentModel;
  }

}
