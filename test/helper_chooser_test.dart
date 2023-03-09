import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pizza_cut_helper/widgets/helper_chooser.dart';

void main(){
  testWidgets("HelperChooser widget consists in a group of iconButton where only one can be selected", (tester) async{
    final icons = [
      Icon(Icons.add),
      Icon(Icons.remove),
      Icon(Icons.close),
      Icon(Icons.front_hand)
    ];
    await tester.pumpWidget(MaterialApp(theme: ThemeData(useMaterial3: true),home: Scaffold(body: HelperChooser(icons),),));

    final finders = icons.map((e) => find.ancestor(of: find.byIcon(e.icon!), matching: find.byType(IconButton))).toList();
    for (int i = 0; i<= 3; i++){
      expect(finders[i], findsOneWidget);
    }

    expect((tester.widget(finders[0]) as IconButton).isSelected, equals(true));
    for (var i in [1,2,3]) {
      expect((tester.widget(finders[i]) as IconButton).isSelected, equals(false));
    }

    await tester.tap(finders[2]);
    await tester.pump();
    for (var i in [0,1,3]){
      expect((tester.widget(finders[i]) as IconButton).isSelected, equals(false));
    }
    expect((tester.widget(finders[2]) as IconButton).isSelected, equals(true));
  });
}