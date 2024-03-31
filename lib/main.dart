import 'package:cicero_app/core/utils/navigation_service.dart';
import 'package:cicero_app/features/splash_screen.dart';

import '/core/common/cubits/app_user/app_user_cubit.dart';
import '/core/theme/theme.dart';
import '/features/auth/presentation/bloc/auth_bloc.dart';
import '/features/blog/presentation/bloc/blog_bloc.dart';
import '/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<BlogBloc>(),
      ),
    ],
    child:MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        title: 'Cicero App',
        theme: AppTheme.darkThemeMode,
        home: const SplashScreen()
    ),
  ));
}


