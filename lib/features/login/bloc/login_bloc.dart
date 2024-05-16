import 'package:bloc/bloc.dart';
import 'package:hakkyo/models/eschool.dart';
import 'package:meta/meta.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEventLog>(_onLog);
  }


  _onLog(LoginEventLog event, Emitter emit) async{
    
    emit(LoginStateLoading());
    
    try{
      final r = await loginPost(event.username, event.password);
      emit(LoginStateLoaded(cookie: r));

    }catch(e){
      emit(LoginFailure());
    }
  }
}
