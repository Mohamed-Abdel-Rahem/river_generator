import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riv_gen/cart.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. مراقبة حالة السلة (عشان الـ UI يتحدث لوحده)
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('سلة المشتريات (${cartItems.length})'),
        backgroundColor: Colors.blueAccent,
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('السلة فاضية يا محمد، ضيف حاجة!'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: Text(cartItems[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // 2. استدعاء دالة المسح من الـ Notifier
                      ref.read(cartProvider.notifier).removeItem(index);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 3. استدعاء دالة الإضافة
          final newItemName = 'منتج رقم ${cartItems.length + 1}';
          ref.read(cartProvider.notifier).addItem(newItemName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
