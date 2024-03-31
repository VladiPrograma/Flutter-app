import 'package:hive/hive.dart';

import '/core/common/cubits/app_user/app_user_cubit.dart';
import '/core/secrets/app_secrets.dart';
import '/features/auth/data/datasources/auth_remote_data_source.dart';
import '/features/auth/data/repositories/auth_repository_impl.dart';
import '/features/auth/domain/repository/auth_repository.dart';
import '/features/auth/domain/usecases/current_user.dart';
import '/features/auth/domain/usecases/user_login.dart';
import '/features/auth/domain/usecases/user_sign_up.dart';
import '/features/auth/presentation/bloc/auth_bloc.dart';
import '/features/blog/data/datasources/blog_local_data_source.dart';
import '/features/blog/data/datasources/blog_remote_data_source.dart';
import '/features/blog/data/repositories/blog_repository_impl.dart';
import '/features/blog/domain/repositories/blog_repository.dart';
import '/features/blog/domain/usecases/get_all_blogs.dart';
import '/features/blog/domain/usecases/upload_blog.dart';
import '/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

part 'init_dependencies.main.dart';
