
import 'package:sutt_task_aryan/router/route_utils.dart';
import 'package:sutt_task_aryan/views/home_page.dart';
import 'package:sutt_task_aryan/views/login_page.dart';
import 'package:sutt_task_aryan/views/signin_page.dart';
import 'package:sutt_task_aryan/views/signup_page.dart';


import 'package:go_router/go_router.dart';

class AppRouter {

    GoRouter router = GoRouter(
    initialLocation: APP_PAGE.home.toPath,
    routes: <GoRoute>[
      GoRoute(
        path: APP_PAGE.home.toPath,
        name: APP_PAGE.home.toName,
        builder: (context, state) => LogInPage(),
      ),
      GoRoute(
        path: APP_PAGE.signin.toPath,
        name: APP_PAGE.signin.toName,
        builder: (context, state) => SignInPage(),
      ),
      GoRoute(
        path: APP_PAGE.signup.toPath,
        name: APP_PAGE.signup.toName,
        builder: (context, state) => SignUpPage(),
      ),
      GoRoute(
        path: APP_PAGE.login.toPath,
        name: APP_PAGE.login.toName,
        builder: (context, state) => HomePage(),
      ),
    ],
  );
}