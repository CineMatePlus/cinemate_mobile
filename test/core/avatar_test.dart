import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cinemate_mobile/core/widgets/user_avatar.dart';

void main() {
  testWidgets(
    'unspecified avatar uses a real fallback without decoding assets',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: UserAvatar(avatarUrl: null, gender: 2)),
        ),
      );
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
