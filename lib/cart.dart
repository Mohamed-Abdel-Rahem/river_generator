import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart.g.dart';

@riverpod
class Cart extends _$Cart {
  // دالة الـ build هي اللي بتحدد "أول قيمة" للسلة
  @override
  List<String> build() {
    return []; // السلة بتبدأ فاضية
  }

  // دالة لإضافة منتج
  void addItem(String name) {
    // 'state' هي المتغير اللي جواه الداتا الحالية (List<String>)
    // بنعمل Copy من اللستة القديمة ونضيف عليها الجديد
    state = [...state, name];
  }

  // دالة لمسح منتج معين
  void removeItem(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i],
    ];
  }
}
