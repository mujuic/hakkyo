// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hakkyo/bloc/user_bloc.dart';
import 'package:hakkyo/features/login/bloc/login_bloc.dart';
import 'package:hakkyo/router/app_router.dart';
import 'package:hakkyo/widgets/my_button.dart';
import 'package:hakkyo/widgets/my_container.dart';
import 'package:hakkyo/widgets/my_text.dart';
import 'package:hakkyo/widgets/my_title.dart';
import 'package:hakkyo/widgets/my_titleText.dart';
import 'package:hakkyo/widgets/text_field.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final double screenHeight = MediaQuery.of(context).size.height;

  // final double screenWidth =  MediaQuery.of(context).size.width;

  LoginBloc logBloc = LoginBloc();

  TextEditingController loginController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => logBloc,
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.white),
        drawer: Drawer(  
          child: Container(
            color: Colors.white,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  Text('Хаккъе (от кор. 학교 - “школа”)', 
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                    )
                  ),
                  Text('Автор: Хам Николай', 
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                    )
                  ),
                ]
              )
            )
          )
        ),
        backgroundColor: Colors.black,
        body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Container(
              width: 200,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.black,
                border:Border.all(width: 5, color: Colors.white),
                borderRadius: BorderRadius.circular(100)
              ),
              child: const Center(
                child:Text("HAKKYO",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  )
                )
              )
            ),
          ),
        
          //поля для ввода текста
          MyTextField(textControl: loginController, text: "login", obscureFlag: false),
          
          MyTextField(textControl: passwordController, text: "password", obscureFlag: true),
        
          //кнопка логин
          GestureDetector(
            onTap: () async {
              logBloc.add(LoginEventLog(username: loginController.text, password: passwordController.text));
              await showDialog(
                  context: (context),
                  builder: (context) {
                    return BlocBuilder<LoginBloc, LoginState>(
                      bloc: logBloc,
                      builder: (context, state) {
                        if (state is LoginStateLoaded) {
                          final String cookie = state.cookie;
                          context.read<UserBloc>().add(UserEventLogin(username: loginController.text ,cookie: cookie));
                          return Dialog(
                            child: MyContainer(
                              widget: BlocBuilder<UserBloc, UserState>(
                                bloc: context.read<UserBloc>(),
                                builder: (context, state) {
                                  if(state is UserStateLoaded){
                                    return ElevatedButton(
                                      onPressed: () {
                                        AutoRouter.of(context).push(const HomeRoute());
                                      },
                                      child: const Text("Start"),
                                    );
                                  }
                              
                                  if(state is UserStateFailure){
                                    return ElevatedButton(
                                      onPressed: () {
                                        AutoRouter.of(context).maybePop();
                                      },
                                      child: const Text("fail"),
                                    );
                                  }
                                  return const CircularProgressIndicator();
                                }
                              )
                            )
                          );
                        }
                        if (state is LoginFailure) {
                          return const Dialog(
                            child: MyContainer(widget: Text("fail"))
                          );
                        }
                        return const Dialog(
                          child: MyContainer(widget: CircularProgressIndicator())
                        );
                      },
                    );
                  });
            },
            child: Container(
              width: 80,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black,
                border:Border.all(width: 2, color: Colors.white),
                borderRadius: BorderRadius.circular(5)
              ),
              child: const Center(child: MyText(text: "대문", color: Colors.white))
            ),
          ),
        ]),
      )),
    );
  }
}



// class MyDialog extends StatelessWidget {
//   const MyDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 300,
//       height: 500,
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 68, 68, 68),
//         border: Border.all(
//           width: 4,
//           color: Colors.black
//         ),
//         borderRadius: BorderRadius.circular(10)
//       ),
//       child: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             AutoRouter.of(context).maybePop();
//           }, 
//           child: const Icon(Icons.close)
//         ),
//       ),
//     );
//   }
// }