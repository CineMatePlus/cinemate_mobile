import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cinemate_mobile/main.dart' as app;
import 'package:cinemate_mobile/core/services/api_service.dart';
import 'package:cinemate_mobile/core/modules/auth/service/service.dart';
import 'package:cinemate_mobile/modules/movie/widgets/movie_card.dart';
import 'package:cinemate_mobile/modules/movie/screens/movie_detail/view.dart';
import 'package:cinemate_mobile/modules/collections/widgets/collection_card.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('demo account restores session and explores real backend data', (
    tester,
  ) async {
    const password = String.fromEnvironment('DEMO_PASSWORD');
    expect(
      password,
      isNotEmpty,
      reason: 'Pass DEMO_PASSWORD through a local dart-define file.',
    );
    final api = ApiService();
    final auth = AuthService(apiService: api);
    await auth.login('demo1@example.com', password);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isOnboardingCompleted', true);
    app.main();
    Future<void> waitFor(Finder finder) async {
      for (var i = 0; i < 120 && finder.evaluate().isEmpty; i++) {
        await tester.pump(const Duration(milliseconds: 500));
      }
      expect(finder, findsWidgets);
      await tester.pump(const Duration(seconds: 3));
    }

    await waitFor(find.byType(BottomNavigationBar));
    await binding.convertFlutterSurfaceToImage();
    await waitFor(find.byType(MovieCard));
    await binding.takeScreenshot('01-discovery');
    await tester.tap(find.byType(MovieCard).first);
    await waitFor(find.byType(MovieDetailView));
    await tester.pump(const Duration(seconds: 5));
    await binding.takeScreenshot('02-movie-detail');
    await tester.tap(find.byIcon(Icons.arrow_back).first);
    await tester.pump(const Duration(seconds: 1));
    Future<void> tab(int index) async {
      final bar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      bar.onTap!(index);
      await tester.pump(const Duration(seconds: 4));
    }

    await tab(1);
    await tester.enterText(find.byType(TextField).first, 'space adventure');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await waitFor(find.byType(MovieCard));
    await binding.takeScreenshot('03-semantic-search');
    await tab(2);
    await waitFor(find.text('Ece'));
    await binding.takeScreenshot('04-similar-users');
    await tab(3);
    await waitFor(find.byType(CollectionCard));
    await binding.takeScreenshot('05-collections');
    await tester.tap(find.byType(CollectionCard).first);
    await waitFor(find.byType(MovieCard));
    await binding.takeScreenshot('06-collection-detail');
    await tester.tap(find.byIcon(Icons.arrow_back).first);
    await tester.pump(const Duration(seconds: 1));
    await tab(4);
    await waitFor(find.text('8 movies'));
    await binding.takeScreenshot('07-profile');
    expect(tester.takeException(), isNull);
    api.close();
  });
}
