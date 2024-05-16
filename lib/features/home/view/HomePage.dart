import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakkyo/features/home/bloc/action_bloc.dart';
import 'package:hakkyo/features/home/flame_layer/flame_layer.dart';
import 'package:hakkyo/features/home/flutter_layer/flutter_layer.dart';
import 'package:hakkyo/router/app_router.dart';
import 'package:hakkyo/widgets/my_titleText.dart';



@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider<ActionBloc>(
        create: (context) => ActionBloc(),
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(backgroundColor: Colors.white, title: const MyTitleText(color: Colors.black, text: "HAKKYO")),
            drawer: Drawer( 
              child: Container(
                color: Colors.white,
                child: Center(child: TextButton(onPressed: () => {AutoRouter.of(context).push(const LoginRoute())}, 
                  child: const Text('LOG OUT',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    )
                ))))),
            body: const Stack(
              children: [FlameLayer(), 
              FlutterLayer()],
            )
          ),
        )
      )
    );
  }
}
