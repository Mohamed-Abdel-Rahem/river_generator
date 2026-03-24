import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

// 1. لازم نضيف كلمة final أو base قبل الكلاس
final class LoggerRiverPod extends ProviderObserver {
  // 1. دي بتشتغل أول ما Provider جديد يتكريت في الرام
  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    debugPrint(
      '🟢 [Provider Created]: ${context.provider.name ?? context.provider.runtimeType}',
    );
  }

  // 2. دي بتشتغل لما الداتا اللي جوه الـ Provider تتغير
  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    debugPrint(
      '🔵 [Provider Updated]: ${context.provider.name ?? context.provider.runtimeType}',
    );
    // لو عايز تشوف الداتا القديمة والجديدة ممكن تطبع previousValue و newValue
  }

  // 3. دي بتشتغل لما الـ Provider يتمسح من الرام (بسبب autoDispose مثلاً)
  @override
  void didDisposeProvider(ProviderObserverContext context) {
    debugPrint(
      '🔴 [Provider Disposed]: ${context.provider.name ?? context.provider.runtimeType}',
    );
  }
}
