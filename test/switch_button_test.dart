import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pizza_cut_helper/widgets/switch_button.dart';

void main(){
  testWidgets("Switch button consists in a button which has two states with an icon for each one", (tester) async{
    var icon1 = const Icon(Icons.add);
    var icon2 = const Icon(Icons.remove);
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: SwitchButton(icon1, icon2, 24, (p0) { }))));

    final firstIconFinder = find.byIcon(icon1.icon!);
    final secondIconFinder = find.byIcon(icon2.icon!);
    expect(firstIconFinder, findsNothing);
    expect(secondIconFinder, findsOneWidget);

    await tester.tap(find.byType(SwitchButton));
    await tester.pump();
    expect(firstIconFinder, findsOneWidget);
    expect(secondIconFinder, findsNothing);
  });
}