import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riv_gen/homePage.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

// final nameProvier = Provider<String>((ref) {
//   return 'abc';
// });
// final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
//   return UserNotifier();
// });
// final userChangeNotifierProvider = ChangeNotifierProvider((ref) {
//   return UserNotifierChange();
// });
final fetchUserProvider = FutureProvider((ref) {});
