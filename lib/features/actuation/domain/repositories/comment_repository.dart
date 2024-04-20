
import 'package:cicero_app/features/actuation/data/models/comentario_actuacion_model.dart';

import '/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CommentRepository {
  Future<Either<Failure, CommentModel>> createComment({
    required CommentModel comment
  });
  Future<Either<Failure, CommentModel?>> updateComment({
    required CommentModel comment

  });
  Future<Either<Failure, bool>> deleteComment({
    required int id,
  });

  Future<Either<Failure, List<CommentModel>>> getAllComment({required int id});
}
