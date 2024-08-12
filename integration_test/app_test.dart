import 'dart:math';

import 'package:acote_assignment/presentation/screen/user_detail_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:acote_assignment/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      'fetch all uesrs , pagnation, banner, click first user, fetch clicked users repositories',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsWidgets);

    // 배너 유무 테스트
    expect(find.byType(CachedNetworkImage), findsWidgets);

    // 배너 클릭 테스트 진행 시, url 연결은 성공했으나 뒤로가기에 대해 컨트롤 할 수 없어서 주석처리함
    // 배너 클릭 테스트
    // await tester.tap(find.byType(CachedNetworkImage).first);
    // await tester.pumpAndSettle(const Duration(seconds: 20));

    // 이전화면으로 돌아오기 불가능
    // await tester.tap(find.byTooltip('Back'));
    // await tester.pumpAndSettle();

    // 불러온 데이터 중 첫번째 사용자 클릭 테스트
    await tester.tap(find.byType(ListTile).first);
    await tester.pumpAndSettle();

    expect(find.byType(UserDetailView), findsOneWidget);
    expect(find.text('mojombo'), findsOneWidget);

    // 뒤로가기 버튼 클릭 테스트
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsWidgets);

    // 페이지네이션 동작 진행 전의 리스트의 개수와 동작 진행 후의 리스트 개수를 비교하여 페이지네이션 동작 유무 판별 진행
    final initialItemCount = find.byType(ListTile).evaluate().length;
    final scrollController = tester
        .widget<Scrollable>(find.byType(Scrollable))
        .controller as ScrollController;

    scrollController.jumpTo(scrollController.position.maxScrollExtent);

    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle(const Duration(seconds: 10));

    final newItemCount = find.byType(ListTile).evaluate().length;

    expect(newItemCount, greaterThan(initialItemCount));
  });
}
