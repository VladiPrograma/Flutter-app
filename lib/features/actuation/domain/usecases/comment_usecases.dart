
import '../../data/models/comentario_actuacion_model.dart';
import '../entities/comentario_actuacion.dart';
import '../repositories/comment_repository.dart';
import '/core/error/failures.dart';
import '/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class GetAllComments implements UseCase<List<CommentModel>, int> {
  final CommentRepository commentRepository;
  GetAllComments(this.commentRepository);

  @override
  Future<Either<Failure, List<CommentModel>>> call(int id) async {
    return await commentRepository.getAllComment(id: id);
  }
}

class CreateComment implements UseCase<CommentModel, CommentModel> {
  final CommentRepository commentRepository;
  CreateComment(this.commentRepository);
  @override
  Future<Either<Failure, CommentModel>> call(CommentModel comment) async {
    return await commentRepository.createComment(comment: comment);
  }
}

class UpdateComment implements UseCase<CommentModel?, CommentModel> {
  final CommentRepository commentRepository;
  UpdateComment(this.commentRepository);
  @override
  Future<Either<Failure, CommentModel?>> call(CommentModel comment) async {
    return await commentRepository.updateComment(comment: comment);
  }
}

class DeleteComment implements UseCase<bool, int> {
  final CommentRepository commentRepository;
  DeleteComment(this.commentRepository);
  @override
  Future<Either<Failure, bool>> call(int id) async {
    return await commentRepository.deleteComment(id: id);
  }
}
