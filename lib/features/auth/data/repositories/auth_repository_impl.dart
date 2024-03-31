import '/core/constants/constants.dart';
import '/core/error/exceptions.dart';
import '/core/error/failures.dart';
import '/features/auth/data/datasources/auth_remote_data_source.dart';
import '/core/common/entities/user.dart';
import '/features/auth/data/models/user_model.dart';
import '/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
return left(Failure("User not logged in"));

        // return
        //   right(
        //   UserModel(id: "id", email: "email", name: "name")
        // );


    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      final user = await fn();

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
