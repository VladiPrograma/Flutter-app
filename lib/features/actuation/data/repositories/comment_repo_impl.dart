import 'package:cicero_app/core/error/failures.dart';
import 'package:cicero_app/features/actuation/data/datasources/comment_local_data_source.dart';
import 'package:cicero_app/features/actuation/data/models/comentario_actuacion_model.dart';
import 'package:cicero_app/features/actuation/domain/repositories/comment_repository.dart';
import 'package:fpdart/fpdart.dart';

class CommentRepositoryImpl implements CommentRepository{
  CommentLocalDataSource commentLocalDataSource;
  CommentRepositoryImpl(this.commentLocalDataSource);

  @override
  Future<Either<Failure, CommentModel>> createComment({required CommentModel comment}) async{
     try{
       CommentModel commentModel= await commentLocalDataSource.createComment(comment);
    return right(commentModel);
    }
    catch(e){
    return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteComment({required int id})async {
    try{
      bool isDeleted= await commentLocalDataSource.deleteComment(id);
      return isDeleted? right(isDeleted):left(Failure("Couldn't delete the comment"));
    }
    catch(e){
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CommentModel>>> getAllComment({required int id}) async{
    try{
      List<CommentModel> commentList= await commentLocalDataSource.getComment(id);
      return right(commentList);
    }
    catch(e){
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommentModel?>> updateComment({required CommentModel comment}) async{
    try{
      CommentModel? commentModel= await commentLocalDataSource.updateComment(comment);
      return commentModel==null?left(Failure("Couldn't update the comment")): right(commentModel);
    }
    catch(e){
      return left(Failure(e.toString()));
    }
  }


}