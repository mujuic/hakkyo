import 'package:flutter/material.dart';
import 'package:hakkyo/bloc/user_bloc.dart';
import 'package:hakkyo/router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter router = AppRouter();
    return BlocProvider(
      create: (context) => UserBloc(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router.config(),
      ),
    );
  }
}
