import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riv_gen/main.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  void onSubmitted(String value, WidgetRef ref) {
    ref.read(nameProvider.notifier).update((state) => value);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(nameProvider) ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
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
                onSubmitted: (value) => onSubmitted(value, ref),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Name',
                ),
              ),
            ),
            Text(
              'The Name of Provider is $name',
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
