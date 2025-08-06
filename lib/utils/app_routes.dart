import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/my_events_screen.dart';
import '../screens/invitations_screen.dart';
import '../screens/event_planning/event_planning_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';
  static const String myEvents = '/my-events';
  static const String invitations = '/invitations';
  static const String eventPlanning = '/event-planning';

  static Map<String, WidgetBuilder> get routes {
    return {
      login: (context) => const LoginScreen(),
      dashboard: (context) => const DashboardScreen(),
      profile: (context) => const ProfileScreen(),
      myEvents: (context) => const MyEventsScreen(),
      invitations: (context) => const InvitationsScreen(),
      eventPlanning: (context) => const EventPlanningScreen(),
    };
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case dashboard:
        return MaterialPageRoute(builder: (context) => const DashboardScreen());
      case profile:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      case myEvents:
        return MaterialPageRoute(builder: (context) => const MyEventsScreen());
      case invitations:
        return MaterialPageRoute(builder: (context) => const InvitationsScreen());
      case eventPlanning:
        return MaterialPageRoute(builder: (context) => const EventPlanningScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
