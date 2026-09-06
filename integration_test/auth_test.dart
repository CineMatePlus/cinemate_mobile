import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cinemate_mobile/main.dart' as app;
import 'package:cinemate_mobile/core/modules/auth/state.dart';
import 'package:cinemate_mobile/core/modules/auth/service/service.dart';
import 'package:cinemate_mobile/core/modules/auth/screens/login/view.dart';
import 'package:cinemate_mobile/core/services/api_service.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets(
    'register session restores in the app and logout returns to login',
    (tester) async {
      final api = ApiService();
      final auth = AuthService(apiService: api);
      final email =
          'mobile-${DateTime.now().microsecondsSinceEpoch}@example.com';
      final user = await auth.register(
        email,
        'Mobile acceptance',
        'IntegrationPass123!',
        2,
      );
      expect(user.email, email);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isOnboardingCompleted', true);
      app.main();
      for (
        var i = 0;
        i < 60 && find.byType(BottomNavigationBar).evaluate().isEmpty;
        i++
      ) {
        await tester.pump(const Duration(milliseconds: 500));
      }
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      final container = ProviderScope.containerOf(
        tester.element(find.byType(app.MyApp)),
      );
      expect(container.read(authProvider).user?.email, email);
      await container.read(authProvider.notifier).logout();
      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget);
      expect(await api.store.read(), isNull);
      api.close();
    },
  );
}
