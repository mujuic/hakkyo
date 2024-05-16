import 'package:auto_route/auto_route.dart';
import 'package:hakkyo/features/home/view/HomePage.dart';
import 'package:hakkyo/features/login/view/LoginPage.dart';

part 'app_router.gr.dart';

bool isLogin = true;

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

 @override
 List<AutoRoute> get routes => [
   AutoRoute(page: LoginRoute.page, initial: isLogin),
   AutoRoute(page: HomeRoute.page, initial: !isLogin),
 ];
}