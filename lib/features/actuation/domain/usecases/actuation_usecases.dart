import '../../data/models/actuation_model.dart';
import '/core/error/failures.dart';
import '/core/usecase/usecase.dart';
import '/features/actuation/domain/entities/actuation.dart';
import '/features/actuation/domain/repositories/actuation_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllActuation implements UseCase<List<ActuationModel>, NoParams> {
  final ActuationRepository actuationRepository;
  GetAllActuation(this.actuationRepository);

  @override
  Future<Either<Failure, List<ActuationModel>>> call(NoParams params) async {
    return await actuationRepository.getAllActuation();
  }
}

class CreateActuation implements UseCase<ActuationModel, ActuationModel> {
  final ActuationRepository actuationRepository;
  CreateActuation(this.actuationRepository);
  @override
  Future<Either<Failure, ActuationModel>> call(ActuationModel actuation) async {
    return await actuationRepository.createActuation(actuation: actuation);
  }
}

class UpdateActuation implements UseCase<ActuationModel?, ActuationModel> {
  final ActuationRepository actuationRepository;
  UpdateActuation(this.actuationRepository);
  @override
  Future<Either<Failure, ActuationModel?>> call(ActuationModel actuation) async {
    return await actuationRepository.updateActuation(actuation: actuation);
  }
}

class DeleteActuation implements UseCase<bool, int> {
  final ActuationRepository actuationRepository;
  DeleteActuation(this.actuationRepository);
  @override
  Future<Either<Failure, bool>> call(int id) async {
    return await actuationRepository.deleteActuation(id: id);
  }
}
