import 'package:flutter/material.dart';
import '../pages/forgot_password_page.dart';
import '../pages/private_room_page.dart';
import '../pages/chatting_page.dart';
import '../pages/login_page.dart';
import '../pages/signup_page.dart';

class Routes extends NavigatorObserver {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;

    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => const LogInPage());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case '/chat':
        if (args is String) {
          debugPrint("YES ARGS IS STRING");
          return MaterialPageRoute(builder: (_) => ChattingPage(roomID: args));
        }
        return _errorRoute();
      case '/forgot_password':
        return MaterialPageRoute(builder: (_) => const ForgotPassword());
      case '/private_room':
        return MaterialPageRoute(builder: (_) => const PrivateRoomPage());
      default:
        return _errorRoute();
    }
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('ERROR'),
      ),
    );
  });
}
