import 'package:super_get/super_get.dart';

class CounterController extends GetxController {
  final count = 0.obs;
  final history = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Worker: log every change
    ever(count, (val) {
      history.add('Count changed to $val');
    });

    // Worker: milestone alert
    everAll([count], (_) {
      if (count.value > 0 && count.value % 10 == 0) {
        Get.snackbar(
          '🎉 Milestone!',
          'You reached ${count.value}!',
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );
      }
    });
  }

  void increment() => count.value++;
  void decrement() {
    if (count.value > 0) count.value--;
  }

  void reset() {
    count.value = 0;
    history.clear();
  }

  void incrementBy(int amount) => count.value += amount;
}
