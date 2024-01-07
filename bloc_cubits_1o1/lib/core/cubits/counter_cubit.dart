import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  int? initialValue;
  CounterCubit({int? initValue}) : super(initValue ?? 0) {
    initialValue = initValue;
  }

  void getValue() => emit(state);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);

  bool isMatchedInitialValue() {
    if (initialValue == null || initialValue != state) {
      return false;
    }
    return true;
  }
}
