import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riv_gen/main.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  void onSubmittedName(String value, WidgetRef ref) {
    ref.read(userProvider.notifier).updateName(value);
  }

  void onSubmittedAge(String value, WidgetRef ref) {
    ref.read(userProvider.notifier).updateAge(int.parse(value));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.name,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black87,
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: Colors.amber,
        scrolledUnderElevation: 30,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextField(
                onSubmitted: (value) => onSubmittedName(value, ref),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextField(
                onSubmitted: (value) => onSubmittedAge(value, ref),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter age',
                ),
              ),
            ),
            Text(
              'The Name of Provider is ${user.name} and the age is ${user.age.toString()}',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black87,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
