import 'dart:io';

import 'package:cicero_app/features/actuation/data/models/media_model.dart';
import 'package:cicero_app/features/actuation/domain/entities/comentario_actuacion.dart';

import '../entities/media.dart';
import '/core/error/failures.dart';
import '/features/actuation/domain/entities/actuation.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class MediaRepository {
  Future<Either<Failure, MediaModel>> createMedia({
    required MediaModel media
  });
  Future<Either<Failure, MediaModel?>> updateMedia({
    required MediaModel media

  });
  Future<Either<Failure, bool>> deleteMedia({
    required int id,
  });

  Future<Either<Failure, List<MediaModel>>> getAllMedia({required int id});
}
