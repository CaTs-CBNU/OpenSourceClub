import 'package:cats/entrance/view/login_view.dart';
import 'package:cats/entrance/view_model/login_view_model.dart';
import 'package:cats/navigation/bottom_menu/search/view/search_view.dart';
import 'package:cats/navigation/bottom_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// The route configuration.
class GoRouterUtil {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return ChangeNotifierProvider<LoginViewModel>(
            create: (_) => LoginViewModel(),
            child: const LoginView(),
          );
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'home',
            builder: (BuildContext context, GoRouterState state) {
              return const BottomView();
            },
          ),
          GoRoute(
            path: 'search',
            builder: (BuildContext context, GoRouterState state) {
              return const SearchView();
            },
          ),
        ],
      ),
    ],
  );
}
