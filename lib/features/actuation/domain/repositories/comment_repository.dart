import 'dart:io';

import 'package:cicero_app/features/actuation/data/models/comentario_actuacion_model.dart';
import 'package:cicero_app/features/actuation/domain/entities/comentario_actuacion.dart';

import '/core/error/failures.dart';
import '/features/actuation/domain/entities/actuation.dart';
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
