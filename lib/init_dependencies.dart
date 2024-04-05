
import 'package:cicero_app/core/datasources/local_datasource.dart';
import 'package:cicero_app/features/actuation/data/datasources/actuation_data_source.dart';
import 'package:cicero_app/features/actuation/data/datasources/comment_local_data_source.dart';
import 'package:cicero_app/features/actuation/data/datasources/media_local_data_source.dart';
import 'package:cicero_app/features/actuation/data/repositories/actuation_repository_impl.dart';
import 'package:cicero_app/features/actuation/data/repositories/comment_repo_impl.dart';
import 'package:cicero_app/features/actuation/data/repositories/media_repo_impl.dart';
import 'package:cicero_app/features/actuation/domain/repositories/actuation_repository.dart';
import 'package:cicero_app/features/actuation/domain/repositories/comment_repository.dart';
import 'package:cicero_app/features/actuation/domain/repositories/media_repository.dart';
import 'package:cicero_app/features/actuation/domain/usecases/actuation_usecases.dart';
import 'package:cicero_app/features/actuation/domain/usecases/comment_usecases.dart';

import '/core/common/cubits/app_user/app_user_cubit.dart';
import '/core/secrets/app_secrets.dart';
import '/features/auth/data/datasources/auth_remote_data_source.dart';
import '/features/auth/data/repositories/auth_repository_impl.dart';
import '/features/auth/domain/repository/auth_repository.dart';
import '/features/auth/domain/usecases/current_user.dart';
import '/features/auth/domain/usecases/user_login.dart';
import '/features/auth/domain/usecases/user_sign_up.dart';
import '/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:get_it/get_it.dart';

import 'features/actuation/domain/usecases/media_usecases.dart';

part 'init_dependencies.main.dart';
