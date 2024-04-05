import 'package:cicero_app/features/actuation/data/datasources/actuation_data_source.dart';
import 'package:cicero_app/features/actuation/data/models/actuation_model.dart';
import 'package:sqflite/sqflite.dart';

import '/core/error/failures.dart';
import '/features/actuation/domain/entities/actuation.dart';
import '/features/actuation/domain/repositories/actuation_repository.dart';
import 'package:fpdart/fpdart.dart';

class ActuationRepositoryImpl implements ActuationRepository {
  ActuationLocalDataSource actuationLocalDataSource;
  ActuationRepositoryImpl(this.actuationLocalDataSource);

  @override
  Future<Either<Failure, ActuationModel>> createActuation({required ActuationModel actuation}) async{

    try{
    ActuationModel actuationModel= await actuationLocalDataSource.createActuation(actuation);
    return right(actuationModel);
    }
        catch(e){
      return left(Failure(e.toString()));
        }
  }

  @override
  Future<Either<Failure, bool>> deleteActuation({required int id}) async{
    try{
      bool isDeleted= await actuationLocalDataSource.deleteActuation(id);
      return isDeleted? right(isDeleted):left(Failure("Couldn't delete the actuation"));
    }
    catch(e){
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ActuationModel>>> getAllActuation()async {
    try{
      List<ActuationModel> actuationList= await actuationLocalDataSource.getActuation();
      return right(actuationList);
    }
    catch(e){
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActuationModel>> updateActuation({required ActuationModel actuation}) async{
    try{
      ActuationModel? actuationModel= await actuationLocalDataSource.updateActuation(actuation);
      return actuationModel==null?left(Failure("Couldn't update the actuation")): right(actuationModel);
    }
    catch(e){
      return left(Failure(e.toString()));
    }
  }



}
