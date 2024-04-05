
import '../../data/models/media_model.dart';
import '../entities/media.dart';
import '../repositories/media_repository.dart';
import '/core/error/failures.dart';
import '/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class GetAllMedias implements UseCase<List<MediaModel>, int> {
  final MediaRepository mediaRepository;
  GetAllMedias(this.mediaRepository);

  @override
  Future<Either<Failure, List<MediaModel>>> call(int id) async {
    return await mediaRepository.getAllMedia(id: id);
  }
}

class CreateMedia implements UseCase<MediaModel, MediaModel> {
  final MediaRepository mediaRepository;
  CreateMedia(this.mediaRepository);
  @override
  Future<Either<Failure, MediaModel>> call(MediaModel media) async {
    return await mediaRepository.createMedia(media: media);
  }
}

class UpdateMedia implements UseCase<MediaModel?, MediaModel> {
  final MediaRepository mediaRepository;
  UpdateMedia(this.mediaRepository);
  @override
  Future<Either<Failure, MediaModel?>> call(MediaModel media) async {
    return await mediaRepository.updateMedia(media: media);
  }
}

class DeleteMedia implements UseCase<bool, int> {
  final MediaRepository mediaRepository;
  DeleteMedia(this.mediaRepository);
  @override
  Future<Either<Failure, bool>> call(int id) async {
    return await mediaRepository.deleteMedia(id: id);
  }
}
