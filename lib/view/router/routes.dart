import 'package:flutter/material.dart';

import '../pages/chatting_page.dart';
import '../pages/login_page.dart';
import '../pages/signup_page.dart';

class Routes extends NavigatorObserver {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => const LogInPage());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case '/chat':
        return MaterialPageRoute(builder: (_) => ChattingPage());
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
