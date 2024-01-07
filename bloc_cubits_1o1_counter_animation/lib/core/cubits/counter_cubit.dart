import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

class CounterCubit extends Cubit<double> {
  double sliderValue = 0.0;
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);

  double assignValue(double value) {
    sliderValue = value;
    emit(sliderValue);
    return sliderValue;
  }

  getSliderValue() {
    return sliderValue;
  }

  double getCubit() {
    increment();
    return state;
  }
}
