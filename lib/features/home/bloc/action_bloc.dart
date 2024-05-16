import 'package:bloc/bloc.dart';
part 'action_event.dart';
part 'action_state.dart';

class ActionBloc extends Bloc<ActionEvent, ActionState> {
  ActionBloc() : super(ActionInitial()) {
    on<ActionEventComputer>(_onComputer);
    on<ActionEventReset>(_onReset);
    on<ActionEventWindow>(_onWindow);
  }

  _onComputer(ActionEventComputer event, Emitter emit){
    emit(ActionStateComputer());
    print("computer state started");
  }

  _onReset(ActionEventReset event, Emitter<ActionState> emit) {
    emit(ActionInitial());
    print("back to default");
  }

  _onWindow(ActionEventWindow event, Emitter<ActionState> emit) {
    emit(ActionStateWindow());
    print("window state started");
  }
}
