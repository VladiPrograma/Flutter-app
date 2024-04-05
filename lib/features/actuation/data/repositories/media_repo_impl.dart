import 'package:cicero_app/core/error/failures.dart';
import 'package:cicero_app/features/actuation/data/datasources/media_local_data_source.dart';
import 'package:cicero_app/features/actuation/data/models/media_model.dart';
import 'package:cicero_app/features/actuation/domain/repositories/media_repository.dart';
import 'package:fpdart/src/either.dart';

class MediaRepositoryImpl implements MediaRepository{
  MediaLocalDataSource mediaLocalDataSource;
  MediaRepositoryImpl(this.mediaLocalDataSource);

  @override
  Future<Either<Failure, MediaModel>> createMedia({required MediaModel media}) async{
    try{
      MediaModel mediaModel= await mediaLocalDataSource.createMedia(media);
      return right(mediaModel);
    }
    catch(e){
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteMedia({required int id}) async{
    try{
      bool isDeleted= await mediaLocalDataSource.deleteMedia(id);
      return isDeleted? right(isDeleted):left(Failure("Couldn't delete the media"));
    }
    catch(e){
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MediaModel>>> getAllMedia({required int id}) async{
    try{
      List<MediaModel> mediaList= await mediaLocalDataSource.getMedia(id);
      return right(mediaList);
    }
    catch(e){
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MediaModel?>> updateMedia({required MediaModel media}) async{
    try{
      MediaModel? mediaModel= await mediaLocalDataSource.updateMedia(media);
      return mediaModel==null?left(Failure("Couldn't update the media")): right(mediaModel);
    }
    catch(e){
      return left(Failure(e.toString()));
    }
  }
  
  
}