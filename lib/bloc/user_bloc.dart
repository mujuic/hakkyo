import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hakkyo/models/eschool.dart';
import 'package:hakkyo/models/user_model.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserStateInitial()) {
    on<UserEventLogin>(_onLoginEvent , transformer: droppable());
  }

  _onLoginEvent (UserEventLogin event, Emitter<UserState> emit) async{

  emit(UserStateLoading());

  try{
    //проверяем зарегитрирован ли пользователь в базе данных
    bool isKnown = false;
    
    await FirebaseFirestore.instance.collection("users").doc(event.username).get().then((doc) => {isKnown = doc.exists});

    //создаем словарь, основу для пользователя
    Map<String,dynamic> r = {};

    if(isKnown){
      
      //копируем словарь из базы данных
      await FirebaseFirestore.instance.collection("users").doc(event.username).get().then((doc){r = doc.data() as Map<String, dynamic> ;});
      
    }else {
      r["eiId"] = "406053";

      final cookie = event.cookie; 

      r["cookie"] = cookie;

      //получаем основные данные и записываем в словарь
      Map<String,dynamic> state = await getState(cookie);

      Map<String, dynamic> group = await getClass(cookie, state["userId"].toString());

      final userId = state["userId"].toString(); r["userId"] = userId;

      final name = state["profile"]["lastName"] +" " + state["profile"]["firstName"] +" " +state["profile"]["middleName"]; r["name"] = name;

      final groupId = group["groupId"].toString(); r["groupId"] = groupId;

      final groupName = group["groupName"]; r["groupName"] = groupName;

      final yearId = group["yearId"].toString(); r["yearId"] = yearId;

      //получаем данные об оценках
      final marks = await getMarks(userId, "406053", cookie);
      //превращаем в словари
      final List<Map<String,dynamic>> jsonMarks = []; final List<Map<String,dynamic>> jsonEvents = [];

      marks.forEach((element){

        jsonMarks.add(element.toJson());

      }); r["marks"] = jsonMarks; 

      final events = await getEvents(userId, "406053", cookie);

      events.forEach((element){

        jsonEvents.add(element.toJson());

      }); r["events"] = jsonEvents;
      
      //получаем данные о предметах
      final subjects = await getSubjects(userId, "406053", cookie);   

      //заполняем словарь (предмет, его id) и массив id
      final subjUnitMap = subjects["subjUnitMap"]; r["subjUnitMap"] = subjUnitMap;

      final unitList = subjects["unitList"]; r["unitList"] = unitList;

      //распределяем данные об оценках по предметам и сохраняем в словарь
      marks.forEach((element) {
        subjects[element.unitId].incrementNum();
        subjects[element.unitId].incrementCoefficientSum(element.mktWt);

      });

      //превращаем класс предметов в словари
      final Map<String,dynamic> jsonSubjects = {};

      unitList.forEach((element){
        jsonSubjects[element] = subjects[element].toJson();

      }); r["subjects"] = jsonSubjects; 

      //получаем данные о дз
      final diaryPeriod = await getDiaryPeriod(userId, "1710709200000", "1725051600000", cookie); //r["diaryPeriod"] = diaryPeriod;

      final homework = diaryPeriod["homework"];  
      
      //превращаем класс дз в словари
      final List<Map<String,dynamic>> jsonHomework = [];

      homework.forEach((element){
        jsonHomework.add(element.toJson());

      });   r["homework"] = jsonHomework;
      
      //сохраняем пользователя в базе данных
      FirebaseFirestore.instance.collection("users").doc(event.username).set(r);
    }

    //создаем пользователя и передаем bloc
    User user = User.fromJson(r);

    emit(UserStateLoaded(user: user)); 

    print("succesfully logged in"); 

  }catch(e){
    //показываем ошибку
    print(e);

    emit(UserStateFailure());
  }
}
}


