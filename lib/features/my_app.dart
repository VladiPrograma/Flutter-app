import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/common/cubits/app_user/app_user_cubit.dart';
import '../core/network/connection_listener.dart';
import 'auth/presentation/bloc/auth_bloc.dart';
import 'auth/presentation/pages/login_page.dart';
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    initNoInternetListener(context);
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppUserCubit, AppUserState, bool>(
      selector: (state) {
        return state is AppUserLoggedIn;
      },
      builder: (context, isLoggedIn) {
        // if (isLoggedIn) {
        //   return  Your screen here();
        // }
        return const LoginPage();
      },
    );
  }
}
