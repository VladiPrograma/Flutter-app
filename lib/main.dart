import 'package:cicero_app/core/utils/navigation_service.dart';
import 'package:cicero_app/features/actuation/presentation/bloc/actuation_bloc.dart';
import 'package:cicero_app/features/splash_screen.dart';

import '/core/common/cubits/app_user/app_user_cubit.dart';
import '/core/theme/theme.dart';
import '/features/auth/presentation/bloc/auth_bloc.dart';
import '/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart' as sizer;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),  BlocProvider(
        create: (_) => serviceLocator<CameraBloc>(),
      ),

    ],
    child:
    sizer.Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: NavigationService.navigatorKey,
              title: 'Cicero App',
              theme: AppTheme.darkThemeMode,
              home: const SplashScreen()
          );
        }
    )



  ));
}


