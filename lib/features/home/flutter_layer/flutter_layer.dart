// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakkyo/bloc/user_bloc.dart';
import 'package:hakkyo/features/home/bloc/action_bloc.dart';
import 'package:hakkyo/features/home/widgets/subject_block.dart';
import 'package:hakkyo/models/subject.dart';
import 'package:hakkyo/widgets/my_button.dart';
import 'package:hakkyo/widgets/my_container.dart';
import 'package:hakkyo/widgets/my_text.dart';
import 'package:hakkyo/widgets/my_title.dart';


class FlutterLayer extends StatefulWidget {
  const FlutterLayer({super.key});

  @override
  State<FlutterLayer> createState() => _FlutterLayerState();
}

class _FlutterLayerState extends State<FlutterLayer> {

TextEditingController markField = TextEditingController();

  TextEditingController coeffField = TextEditingController();

  List<String> smileList = [
    "(´･ᴗ･ )",
    "٩(｡•́‿•̀｡)۶",
    '( ‾́ ◡ ‾́ )',
    "(ﾉ´ヮ)ﾉ",
    "凸(￣ヘ￣)"
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<ActionBloc, ActionState>(
                bloc: context.read<ActionBloc>(),
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MyTitle(text: state.text),
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 70, bottom: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocBuilder<ActionBloc, ActionState>(
                  bloc: context.read<ActionBloc>(),
                  builder: (context, state) {
                    return GestureDetector(
                        onTap: () async {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                if (state is ActionStateComputer) {
                                  return Dialog(
                                      child: MyContainer(widget: BlocBuilder<UserBloc, UserState>(
                                    bloc: context.read<UserBloc>(),
                                    builder: (context, state) {
                                      if (state is UserStateLoaded) {
                                        return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: state.user.unitList.length,
                                            itemBuilder: (context, index) {
                                              Subject sub = state.user.subjects[state.user.unitList[index]];
                                              return SubjectBlock(sub: sub, index: index, events: state.user.events);
                                            }
                                          );
                                        
                                      }
                                      return const MyText(color: Colors.white, text: "USER NOT LOADED");
                                    },
                                  )));
                                }

                                if (state is ActionStateWindow) {
                                  return Dialog(
                                      child: MyContainer(widget: BlocBuilder<UserBloc, UserState>(
                                    bloc: context.read<UserBloc>(),
                                    builder: (context, state) {
                                      if (state is UserStateLoaded) {
                                        return Center(child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            MyText(text: "${state.user.name.split(" ")[1]} ${state.user.name.split(" ")[2]}, " , color: Colors.white),
                                            MyText(text: "не стоит..." , color: Colors.white)
                                          ],
                                        ));
                                        
                                      }
                                      return const MyText(color: Colors.white, text: "USER NOT LOADED");
                                    },
                                  )));
                                }

                                return Dialog(child: MyContainer(widget:
                                  BlocBuilder<UserBloc, UserState>(
                                  bloc: context.read<UserBloc>(),
                                  builder: (context, state) {
                                    return Center(
                                        child: ListView(
                                          
                                          shrinkWrap: true,
                                          children: [
                                            const Image(image: AssetImage('assets/prince.jpg')),
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: MyText(color: Colors.white,text:state.user.name),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: MyText(color: Colors.white,text:"Класс ${state.user.groupName}"),
                                            ),
                                          ],
                                    ));
                                  },
                                )));
                              });
                        },
                        child: MyButton(
                          widget: MyText(
                              color: Colors.white, text: state.buttonText),
                        ));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TopRow extends StatelessWidget {
  const TopRow({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              border: Border.all(width: 4, color: Colors.black),
            ),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}


