import 'dart:io';

import 'package:cicero_app/features/actuation/data/models/actuation_model.dart';

import '/core/error/failures.dart';
import '/features/actuation/domain/entities/actuation.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ActuationRepository {
  Future<Either<Failure, ActuationModel>> createActuation({
    required ActuationModel actuation
  });
  Future<Either<Failure, ActuationModel>> updateActuation({
    required ActuationModel actuation

  });
  Future<Either<Failure, bool>> deleteActuation({
    required int id,
  });

  Future<Either<Failure, List<ActuationModel>>> getAllActuation();
}
